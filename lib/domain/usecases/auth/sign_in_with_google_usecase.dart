import 'package:habitree/core/result/result.dart';
import 'package:habitree/core/usecases/base_usecase_no_param.dart';
import 'package:habitree/data/services/auth/google_sign_in_service.dart';
import 'package:habitree/domain/entities/auth/session.dart';
import 'package:habitree/domain/repositories/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInWithGoogleUseCase extends BaseUseCaseNoParam<Result<Session>> {
  SignInWithGoogleUseCase(
      this._googleSignInService,
      this._authRepository,
      );

  final GoogleSignInService _googleSignInService;
  final AuthRepository _authRepository;

  @override
  Future<Result<Session>> execute(void param) async {
    final token = await _googleSignInService.signIn();
    return _authRepository.signInWithGoogle(token);
  }
}
