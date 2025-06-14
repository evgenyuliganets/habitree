import 'package:habitree/core/result/result.dart';
import 'package:habitree/core/usecases/base_usecase.dart';
import 'package:habitree/domain/repositories/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendOtpEmailUseCase extends BaseUseCase<String, Result<void>> {
  SendOtpEmailUseCase(
    this._authRepository,
  );

  final AuthRepository _authRepository;

  @override
  Future<Result<void>> execute(String param) async {
    return _authRepository.sendOtpToEmail(param);
  }
}
