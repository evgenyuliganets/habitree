import 'package:habitree/core/error/failure.dart';
import 'package:habitree/core/result/result.dart';

typedef OnSuccess<T> = void Function(T data);
typedef OnFailure = void Function(Failure failure);

void handleResult<T>(
  Result<T> result, {
  required OnSuccess<T> onSuccess,
  OnFailure? onFailure,
}) {
  switch (result) {
    case Success(:final data):
      onSuccess(data);
    case FailureResult(:final failure):
      onFailure?.call(failure);
  }
}
