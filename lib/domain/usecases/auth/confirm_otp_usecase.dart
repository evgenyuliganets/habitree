import 'package:habitree/core/result/result.dart';
import 'package:habitree/core/usecases/base_usecase.dart';
import 'package:habitree/domain/entities/auth/session.dart';
import 'package:habitree/domain/repositories/auth/auth_repository.dart';
import 'package:habitree/domain/usecases/auth/params/confirm_otp_email_param.dart';
import 'package:injectable/injectable.dart';

@injectable
class ConfirmOtpEmailUseCase
    extends BaseUseCase<ConfirmOtpEmailParam, Result<Session>> {
  ConfirmOtpEmailUseCase(
    this._authRepository,
  );

  final AuthRepository _authRepository;

  @override
  Future<Result<Session>> execute(ConfirmOtpEmailParam param) async {
    return _authRepository.confirmOtpEmail(param);
  }
}
