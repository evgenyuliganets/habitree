import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/result/result.dart';
import 'package:habitree/di/di.dart';
import 'package:habitree/domain/usecases/auth/delete_account_usecase.dart';
import 'package:habitree/domain/usecases/auth/get_current_session_usecase.dart';
import 'package:habitree/domain/usecases/auth/send_otp_email.dart';
import 'package:habitree/domain/usecases/auth/sign_in_with_google_usecase.dart';
import 'package:habitree/domain/usecases/auth/sign_out_usecase.dart';
import 'package:habitree/presentation/auth/providers/auth_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(
    this._signInWithGoogleUseCase,
    this._signOutUseCase,
    this._deleteAccountUseCase,
    this._getCurrentSessionUseCase,
    this._sendOtpEmailUseCase,
  ) : super(const AuthState.initial());

  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignOutUseCase _signOutUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final GetCurrentSessionUseCase _getCurrentSessionUseCase;
  final SendOtpEmailUseCase _sendOtpEmailUseCase;

  Future<void> loadCurrentSession() async {
    final result = await _getCurrentSessionUseCase.call();
    result?.mapResult(
      success: (session) {
        if (session != null) {
          state = Authenticated(session: session);
        } else {
          state = const AuthInitial();
        }
      },
      failure: (_) => state = const AuthInitial(),
    );
  }

  Future<void> signInWithGoogle() async {
    final result = await _signInWithGoogleUseCase.call();
    result?.mapResult(
      success: (session) => state = Authenticated(session: session),
      failure: (f) => state = AuthError(message: f.userMessage),
    );
  }

  Future<void> sendOtpToEmail(String email) async {
    state = AuthOtpInProgress(email: email);
    final result = await _sendOtpEmailUseCase.call(email);
    result?.mapResult(
      success: (_) => state = AuthOtpSent(email: email),
      failure: (f) => state = AuthError(message: f.userMessage),
    );
  }

  Future<void> signOut() async {
    final result = await _signOutUseCase.call();
    result?.mapResult(
      success: (_) => state = const AuthInitial(),
      failure: (f) => state = AuthError(message: f.userMessage),
    );
  }

  Future<void> deleteAccount() async {
    final result = await _deleteAccountUseCase.call();
    result?.mapResult(
      success: (_) => state = const AuthInitial(),
      failure: (f) => state = AuthError(message: f.userMessage),
    );
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => getIt<AuthNotifier>(),
);
