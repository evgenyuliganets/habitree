import 'package:habitree/core/result/result.dart';
import 'package:habitree/domain/entities/auth/google_token.dart';
import 'package:habitree/domain/entities/auth/session.dart';

abstract class AuthRepository {
  Future<Result<Session>> signInWithGoogle(GoogleToken googleToken);

  Future<Result<void>> signOut();

  Future<Result<void>> deleteAccount();

  Future<Result<Session?>> getCurrentSession();

  Future<Result<void>> sendOtpToEmail(String email);
}
