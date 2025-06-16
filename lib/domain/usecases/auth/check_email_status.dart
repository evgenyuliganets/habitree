import 'package:habitree/core/result/result.dart';
import 'package:habitree/domain/entities/auth/email_auth_status.dart';
import 'package:habitree/domain/repositories/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckEmailStatusUseCase {
  const CheckEmailStatusUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<EmailAuthStatus>> call(String email) {
    return _repository.checkEmailStatus(email);
  }
}