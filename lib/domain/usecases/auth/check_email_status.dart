import 'package:habitree/core/result/result.dart';
import 'package:habitree/core/usecases/base_usecase.dart';
import 'package:habitree/domain/entities/auth/email_auth_status.dart';
import 'package:habitree/domain/repositories/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckEmailStatusUseCase
    extends BaseUseCase<String, Result<EmailAuthStatus>> {
  CheckEmailStatusUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<EmailAuthStatus>> execute(String param) {
    return _repository.checkEmailStatus(param);
  }
}
