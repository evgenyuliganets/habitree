import 'package:dio/dio.dart';
import 'package:habitree/data/data_sources/auth/local/auth_local_datasource.dart';

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
          final response = await dio.fetch<Response<dynamic>>(req.options);
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
      final response = await dio.post<Map<String, dynamic>>(
        '/auth/v1/token?grant_type=refresh_token',
        data: {
          'refresh_token': refreshToken,
        },
      );

      final accessToken = response.data?['access_token'] as String?;
      final newRefreshToken = response.data?['refresh_token'] as String?;

      if (accessToken == null || newRefreshToken == null) {
        return false;
      }

      await authStorage.saveAccessToken(accessToken);
      await authStorage.saveRefreshToken(newRefreshToken);

      return true;
    } on Exception {
      return false;
    }
  }
}
