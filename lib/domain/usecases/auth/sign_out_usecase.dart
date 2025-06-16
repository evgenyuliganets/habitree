import 'package:habitree/core/result/result.dart';
import 'package:habitree/core/usecases/base_usecase_no_param.dart';
import 'package:habitree/data/services/auth/google_sign_in_service.dart';
import 'package:habitree/domain/repositories/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignOutUseCase extends BaseUseCaseNoParam<Result<void>> {
  SignOutUseCase(
    this._authRepository,
    this._googleSignInService,
  );

  final AuthRepository _authRepository;
  final GoogleSignInService _googleSignInService;

  @override
  Future<Result<void>> execute(void param) async {
    try {
      final isSignedIn = await _googleSignInService.isSignedIn();
      if (isSignedIn) {
        await _googleSignInService.signOut();
      }
    } on Exception catch (_) {
      // Ignore Google sign-out error and proceed with app logout
    }

    return _authRepository.signOut();
  }
}
