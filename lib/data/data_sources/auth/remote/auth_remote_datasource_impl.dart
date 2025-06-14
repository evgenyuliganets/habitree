import 'package:dio/dio.dart';
import 'package:habitree/core/constants/constants.dart';
import 'package:habitree/core/network/dio_client.dart';
import 'package:habitree/core/network/safe_call.dart';
import 'package:habitree/core/result/result.dart';
import 'package:habitree/data/data_sources/auth/remote/auth_remote_datasource.dart';
import 'package:habitree/data/models/auth/google_token_dto.dart';
import 'package:habitree/data/models/auth/session_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<Result<SessionDto>> signInWithGoogle(GoogleTokenDto googleToken) {
    return safeCall(() async {
      final response = await _dioClient.post<Map<String, dynamic>>(
        '/auth/v1/token?grant_type=id_token',
        data: googleToken.toJson(),
      );

      return SessionDto.fromJson(response.data!);
    });
  }

  @override
  Future<Result<void>> sendOtpToEmail(String email) {
    return safeCall(() async {
      await _dioClient.post<Map<String, dynamic>>(
        '/auth/v1/otp',
        data: {
          'email': email,
          'create_user': true,
          'type': 'email',
        },
      );
    });
  }

  @override
  Future<Result<void>> signOut() {
    return safeCall(() async {
      await _dioClient.post<Map<String, dynamic>>('/auth/v1/logout');
    });
  }

  @override
  Future<Result<void>> deleteAccount() {
    return safeCall(() async {
      await _dioClient.delete<Map<String, dynamic>>('/auth/v1/user');
    });
  }
}
