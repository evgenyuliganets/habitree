import 'package:habitree/core/result/result.dart';
import 'package:habitree/data/models/auth/google_token_dto.dart';
import 'package:habitree/data/models/auth/session_dto.dart';

abstract class AuthRemoteDataSource {
  Future<Result<SessionDto>> signInWithGoogle(GoogleTokenDto googleToken);

  Future<Result<void>> signOut();

  Future<Result<void>> deleteAccount();

  Future<Result<void>> sendOtpToEmail(String email);
}
