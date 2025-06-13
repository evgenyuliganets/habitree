import 'package:habitree/core/usecases/base_usecase.dart';
import 'package:habitree/data/models/auth/google_token.dart';
import 'package:habitree/data/models/auth/session.dart';
import 'package:habitree/domain/repositories/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInWithGoogleUseCase extends BaseUseCase<GoogleToken, Session> {
  SignInWithGoogleUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Session> execute(GoogleToken param) async {
    return _authRepository.signInWithGoogle(param);
  }
}
