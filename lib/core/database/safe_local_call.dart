import 'package:habitree/core/error/failure_types.dart';
import 'package:habitree/core/result/result.dart';
import 'package:habitree/i18n/strings.g.dart';

Future<Result<T>> safeLocalCall<T>(Future<T> Function() call) async {
  try {
    final result = await call();
    return Success(result);
  } on Exception catch (e, stack) {
    return FailureResult(
      DatabaseFailure(
        userMessage: t.errors.unknown,
        originalError: e,
        stackTrace: stack,
      ),
    );
  }
}
