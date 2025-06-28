import 'package:dio/dio.dart';
import 'package:habitree/core/constants/constants.dart';
import 'package:habitree/core/network/dio_client.dart';
import 'package:habitree/core/network/interceptors/auth_interceptor.dart';
import 'package:habitree/data/data_sources/auth/local/auth_local_datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio(AuthLocalDataSource sessionStorage) {
    final dioOptions = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 45),
      headers: {
        'apikey': AppConstants.supabaseAnonKey,
        'Content-Type': 'application/json',
      },
    )
      ..followRedirects = true
      ..validateStatus = (statusCode) {
        if (statusCode == null) return false;
        if (statusCode == 422) return false;
        return statusCode >= 200 && statusCode < 300;
      };

    final dio = Dio(dioOptions);

    dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ),
      AuthInterceptor(sessionStorage, dio),
    ]);

    return dio;
  }

  @lazySingleton
  DioClient dioClient(Dio dio) => DioClient(dio);
}
