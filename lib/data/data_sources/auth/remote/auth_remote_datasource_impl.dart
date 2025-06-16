import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:habitree/core/constants/constants.dart';
import 'package:habitree/core/network/dio_client.dart';
import 'package:habitree/core/network/safe_call.dart';
import 'package:habitree/core/result/result.dart';
import 'package:habitree/data/data_sources/auth/local/auth_local_datasource.dart';
import 'package:habitree/data/data_sources/auth/remote/auth_remote_datasource.dart';
import 'package:habitree/data/models/auth/google_token_dto.dart';
import 'package:habitree/data/models/auth/session_dto.dart';
import 'package:habitree/domain/entities/auth/email_auth_status.dart';
import 'package:habitree/domain/usecases/auth/params/confirm_otp_email_param.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(
    this._dioClient,
    this._authLocalDataSource,
  );

  final DioClient _dioClient;
  final AuthLocalDataSource _authLocalDataSource;

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
          'options': {
            'shouldCreateUser': true,
          },
        },
      );
    });
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      final refreshToken = await _authLocalDataSource.getRefreshToken();

      if (refreshToken != null) {
        await _dioClient.post<Map<String, dynamic>>(
          '/auth/v1/logout',
          data: {'refresh_token': refreshToken},
        );
      }
    } on Exception catch (_) {
    } finally {
      await _authLocalDataSource.clearSession();
    }

    return const Success(null);
  }

  @override
  Future<Result<void>> deleteAccount() {
    return safeCall(() async {
      await _dioClient.delete<Map<String, dynamic>>('/auth/v1/user');
    });
  }

  @override
  Future<Result<SessionDto>> confirmOtpEmail(ConfirmOtpEmailParam param) {
    return safeCall(() async {
      final response = await _dioClient.post<Map<String, dynamic>>(
        '/auth/v1/verify',
        data: {
          'email': param.email,
          'token': param.otp,
          'type': 'email',
        },
      );
      return SessionDto.fromJson(response.data!);
    });
  }

  @override
  Future<Result<EmailAuthStatus>> checkEmailStatus(String email) async {
    return safeCall(() async {
      final response = await _dioClient.post<String>(
        '/rest/v1/rpc/check_email_status',
        data: {'input_email': email},
        options: Options(
          headers: {
            'apikey': AppConstants.supabaseAnonKey,
            'Authorization': 'Bearer ${AppConstants.supabaseAnonKey}',
            'Content-Type': 'application/json',
          },
        ),
      );
      final parsed = jsonDecode(response.data!) as String;
      return EmailAuthStatus.fromString(parsed);
    });
  }
}
