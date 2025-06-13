import 'package:habitree/data/data_sources/auth/remote/auth_remote_datasource.dart';
import 'package:habitree/data/models/auth/google_token.dart';
import 'package:habitree/data/models/auth/session.dart';
import 'package:habitree/domain/repositories/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<Session> signInWithGoogle(GoogleToken googleToken) async {
    return _remoteDataSource.signInWithGoogle(googleToken);
  }

  @override
  Future<void> signOut() async {
    await _remoteDataSource.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    await _remoteDataSource.deleteAccount();
  }

  @override
  Future<Session?> getCurrentSession() async {
    // TODO: implement getCurrentSession
    return null;
  }
}
