import 'package:habitree/core/result/result.dart';
import 'package:habitree/core/usecases/base_usecase_no_param.dart';
import 'package:habitree/domain/repositories/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignOutUseCase extends BaseUseCaseNoParam<Result<void>> {
  SignOutUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Result<void>> execute(void param) {
    return _authRepository.signOut();
  }
}
