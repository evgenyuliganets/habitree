import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/result/result.dart';
import 'package:habitree/di/di.dart';
import 'package:habitree/domain/usecases/auth/confirm_otp_usecase.dart';
import 'package:habitree/domain/usecases/auth/delete_account_usecase.dart';
import 'package:habitree/domain/usecases/auth/get_current_session_usecase.dart';
import 'package:habitree/domain/usecases/auth/params/confirm_otp_email_param.dart';
import 'package:habitree/domain/usecases/auth/send_otp_email.dart';
import 'package:habitree/domain/usecases/auth/sign_in_with_google_usecase.dart';
import 'package:habitree/presentation/auth/providers/auth_state.dart';
import 'package:habitree/shared/utils/app_utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(
    this._signInWithGoogleUseCase,
    // this._signOutUseCase,
    this._deleteAccountUseCase,
    this._getCurrentSessionUseCase,
    this._sendOtpEmailUseCase,
    this._confirmOtpEmailUseCase,
    // this._checkEmailStatusUseCase,
  ) : super(const AuthState.initial());

  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  // final SignOutUseCase _signOutUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final GetCurrentSessionUseCase _getCurrentSessionUseCase;
  final SendOtpEmailUseCase _sendOtpEmailUseCase;
  final ConfirmOtpEmailUseCase _confirmOtpEmailUseCase;

  // final CheckEmailStatusUseCase _checkEmailStatusUseCase;

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
      failure: (f) {
        log('Failed to sign in with Google: $f', name: 'AuthNotifier');
        return state = AuthError(message: f.userMessage);
      },
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
    AppUtils.logout();
    // result?.mapResult(
    //   success: (_) => state = const AuthInitial(),
    //   failure: (f) => state = AuthError(message: f.userMessage),
    // );
  }

  Future<void> deleteAccount() async {
    final result = await _deleteAccountUseCase.call();
    result?.mapResult(
      success: (_) => state = const AuthInitial(),
      failure: (f) => state = AuthError(message: f.userMessage),
    );
  }

  Future<void> confirmOtp({required String code, required String email}) async {
    log('current state: $state', name: 'AuthNotifier');

    state = AuthOtpVerificationInProgress(email: email);

    final result = await _confirmOtpEmailUseCase.call(
      ConfirmOtpEmailParam(
        email: email,
        otp: code,
      ),
    );

    result?.mapResult(
      success: (s) => state = AuthState.authenticated(session: s),
      failure: (f) => state = AuthError(message: f.userMessage),
    );
  }

// Future<void> checkEmailStatus(String email) async {
//   state = AuthCheckingEmail(email);
//
//   final result = await _checkEmailStatusUseCase.call(email);
//
//   result.mapResult(
//     success: (status) {
//       switch (status) {
//         case EmailAuthStatus.notFound:
//         case EmailAuthStatus.awaitingConfirmation:
//         case EmailAuthStatus.confirmed:
//           state = AuthEmailStatusResult(email: email, status: status);
//       }
//     },
//     failure: (f) {
//       log('Failed to check email status: $f', name: 'AuthNotifier');
//       state = AuthError(message: f.userMessage);
//     },
//   );
// }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => getIt<AuthNotifier>(),
);
