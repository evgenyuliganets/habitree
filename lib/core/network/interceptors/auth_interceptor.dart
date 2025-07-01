import 'package:dio/dio.dart';
import 'package:habitree/core/constants/constants.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/data/data_sources/auth/local/auth_local_datasource.dart';
import 'package:habitree/shared/utils/app_utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.authStorage, this.dio);

  final AuthLocalDataSource authStorage;
  final Dio dio;

  bool _isRefreshing = false;

  final List<
      ({
        RequestOptions options,
        ErrorInterceptorHandler handler,
      })> _queuedRequests = [];

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await authStorage.getAccessToken();
    log('ACCESS TOKEN ON REQUEST: $token', name: 'AuthInterceptor');
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    _queuedRequests.add((options: err.requestOptions, handler: handler));

    if (_isRefreshing) return;

    _isRefreshing = true;

    final refreshToken = await authStorage.getRefreshToken();
    final success = await _refreshToken(refreshToken);

    if (success) {
      for (final req in _queuedRequests) {
        final token = await authStorage.getAccessToken();
        req.options.headers['Authorization'] = 'Bearer $token';
        try {
          req.options.responseType = ResponseType.json;
          final response = await dio.fetch<dynamic>(req.options);
          req.handler.resolve(response);
        } on DioException catch (e) {
          req.handler.reject(e);
        }
      }
    } else {
      for (final req in _queuedRequests) {
        req.handler.reject(err);
      }
    }

    _queuedRequests.clear();
    _isRefreshing = false;
  }

  Future<bool> _refreshToken(String? refreshToken) async {
    try {
      final rawDio = Dio();
      rawDio.options.validateStatus = (status) => true;

      rawDio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      );
      final response = await rawDio.post<Map<String, dynamic>?>(
        '${AppConstants.baseUrl}/auth/v1/token?'
        'grant_type=refresh_token',
        data: {'refresh_token': refreshToken},
        options: Options(
          headers: {
            'apikey': AppConstants.supabaseAnonKey,
            'Content-Type': 'application/json',
          },
        ),
      );

      final isSuccess = response.statusCode == 200;
      log('Refresh token response: ${response.data}');
      log('Refresh token success: $isSuccess');

      if (!isSuccess) {
        AppUtils.logout();
        return false;
      }

      final accessToken = response.data?['access_token'] as String?;
      final newRefreshToken = response.data?['refresh_token'] as String?;

      if (accessToken == null || newRefreshToken == null) return false;

      await authStorage.saveAccessToken(accessToken);
      await authStorage.saveRefreshToken(newRefreshToken);

      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
