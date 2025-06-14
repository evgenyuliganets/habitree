import 'package:habitree/core/error/failure.dart';

class HttpFailure extends Failure {
  const HttpFailure({
    required super.userMessage,
    required String super.code,
    super.originalError,
    super.response,
    super.stackTrace,
  });
}

class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.userMessage,
    super.originalError,
    super.stackTrace,
  }) : super(
          code: 'validation',
        );
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({
    required super.userMessage,
    super.originalError,
    super.stackTrace,
  }) : super(
          code: 'db',
        );
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    super.userMessage = 'Unexpected error occurred',
    super.originalError,
    super.stackTrace,
  }) : super(
          code: 'unknown',
        );
}
