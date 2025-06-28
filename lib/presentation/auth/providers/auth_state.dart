import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habitree/domain/entities/auth/session.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;

  const factory AuthState.otpInProgress({required String email}) =
      AuthOtpInProgress;

  const factory AuthState.otpSent({required String email}) = AuthOtpSent;

  const factory AuthState.otpVerificationInProgress({required String email}) =
      AuthOtpVerificationInProgress;

  const factory AuthState.authenticated({required Session session}) =
      Authenticated;

  const factory AuthState.error({required String message}) = AuthError;
}
