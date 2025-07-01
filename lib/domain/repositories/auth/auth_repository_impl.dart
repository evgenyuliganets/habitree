import 'dart:developer';

import 'package:habitree/core/result/result.dart';
import 'package:habitree/data/data_sources/auth/local/auth_local_datasource.dart';
import 'package:habitree/data/data_sources/auth/remote/auth_remote_datasource.dart';
import 'package:habitree/data/models/auth/google_token_dto.dart';
import 'package:habitree/domain/entities/auth/email_auth_status.dart';
import 'package:habitree/domain/entities/auth/google_token.dart';
import 'package:habitree/domain/entities/auth/session.dart';
import 'package:habitree/domain/repositories/auth/auth_repository.dart';
import 'package:habitree/domain/usecases/auth/params/confirm_otp_email_param.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(
    this._remote,
    this._local,
  );

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  @override
  Future<Result<Session>> signInWithGoogle(GoogleToken googleToken) async {
    final remoteResult = await _remote.signInWithGoogle(
      GoogleTokenDto.fromDomain(googleToken),
    );

    final mapped = remoteResult.map((dto) => dto.toDomain());

    log('Sign in with Google result: $mapped', name: 'AuthRepositoryImpl');

    if (mapped is Success<Session>) {
      await _local.saveSession(mapped.data);
    }

    return mapped;
  }

  @override
  Future<Result<void>> sendOtpToEmail(String email) {
    return _remote.sendOtpToEmail(email);
  }

  @override
  Future<Result<void>> signOut() async {
    final refreshToken = await _local.getRefreshToken();
    final remoteResult = await _remote.signOut(refreshToken!);

    await _local.clearSession();

    log('Sign out result: $remoteResult', name: 'AuthRepositoryImpl');

    return const Success(null);
  }

  @override
  Future<Result<void>> deleteAccount() async {
    final remoteResult = await _remote.deleteAccount();

    if (remoteResult is Success<void>) {
      await _local.clearSession();
    }

    return remoteResult;
  }

  @override
  Future<Result<Session?>> getCurrentSession() {
    return _local.getSavedSession();
  }

  @override
  Future<Result<Session>> confirmOtpEmail(ConfirmOtpEmailParam param) async {
    final remoteResult = await _remote.confirmOtpEmail(param);

    final mapped = remoteResult.map((dto) => dto.toDomain());

    if (mapped is Success<Session>) {
      await _local.saveSession(mapped.data);
    }

    return mapped;
  }

  @override
  Future<Result<EmailAuthStatus>> checkEmailStatus(String email) {
    return _remote.checkEmailStatus(email);
  }
}
