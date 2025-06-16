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
  /// Returns the data if this is a [Success], otherwise null.
  T? get dataOrNull => this is Success<T> ? (this as Success<T>).data : null;

  /// Returns the failure if this is a [FailureResult], otherwise null.
  Failure? get failureOrNull =>
      this is FailureResult ? (this as FailureResult).failure : null;

  /// Allows mapping the success value to another type.
  Result<R> map<R>(R Function(T value) transform) {
    if (this is Success<T>) {
      return Success<R>(transform((this as Success<T>).data));
    } else {
      return FailureResult<R>((this as FailureResult).failure);
    }
  }

  /// Pattern match without returning value.
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

  /// Pattern match that returns a value.
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

  T? getOrNull() => dataOrNull;
}
