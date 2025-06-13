import 'package:habitree/data/data_sources/auth/remote/auth_remote_datasource.dart';
import 'package:habitree/data/models/auth/google_token.dart';
import 'package:habitree/data/models/auth/session.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();

  @override
  Future<Session> signInWithGoogle(GoogleToken googleToken) async {
    // TODO: implement API call here
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    // TODO: implement API call here
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount() async {
    // TODO: implement API call here
    throw UnimplementedError();
  }
}
