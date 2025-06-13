import 'package:habitree/data/models/auth/google_token.dart';
import 'package:habitree/data/models/auth/session.dart';

abstract class AuthRemoteDataSource {
  Future<Session> signInWithGoogle(GoogleToken googleToken);

  Future<void> signOut();

  Future<void> deleteAccount();
}