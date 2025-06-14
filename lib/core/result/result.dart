import 'package:habitree/core/error/failure.dart';

sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;
}

class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  final Failure failure;
}

extension ResultExtensions<T> on Result<T> {
  /// Transforms a successful result of type [T] into a new success of type [R],
  /// using the provided [transform] function.
  /// If the result is a failure, it is forwarded without changes.
  Result<R> map<R>(R Function(T value) transform) {
    if (this is Success<T>) {
      return Success<R>(transform((this as Success<T>).data));
    } else {
      return FailureResult<R>((this as FailureResult).failure);
    }
  }

  /// Returns the failure inside the result, or null if this is a success.
  Failure? get failureOrNull {
    return this is FailureResult ? (this as FailureResult).failure : null;
  }

  /// Returns the data inside the result, or null if this is a failure.
  T? get dataOrNull {
    return this is Success<T> ? (this as Success<T>).data : null;
  }

  /// Allows pattern matching with functions for both success and failure cases.
  void when({
    required void Function(T data) success,
    required void Function(Failure failure) failure,
  }) {
    if (this is Success<T>) {
      success((this as Success<T>).data);
    } else {
      failure((this as FailureResult).failure);
    }
  }
}


extension ResultExtensionsX<T> on Result<T> {
  R mapResult<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) {
    if (this is Success<T>) {
      return success((this as Success<T>).data);
    } else if (this is FailureResult<T>) {
      return failure((this as FailureResult<T>).failure);
    } else {
      throw StateError('Unexpected Result type: $this');
    }
  }
}
