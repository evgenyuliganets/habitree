import 'package:habitree/core/result/result.dart';
import 'package:habitree/data/models/auth/google_token_dto.dart';
import 'package:habitree/data/models/auth/session_dto.dart';
import 'package:habitree/domain/entities/auth/email_auth_status.dart';
import 'package:habitree/domain/usecases/auth/params/confirm_otp_email_param.dart';

abstract class AuthRemoteDataSource {
  Future<Result<SessionDto>> signInWithGoogle(GoogleTokenDto googleToken);

  Future<Result<void>> signOut(String refreshToken);

  Future<Result<void>> deleteAccount();

  Future<Result<void>> sendOtpToEmail(String email);

  Future<Result<SessionDto>> confirmOtpEmail(ConfirmOtpEmailParam param);

  Future<Result<EmailAuthStatus>> checkEmailStatus(String email);
}
