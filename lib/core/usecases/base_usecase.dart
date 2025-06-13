import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class BaseUseCase<TParam, TResult> {
  /// This should be overridden with use case logic
  @protected
  Future<TResult> execute(TParam param);

  /// Wrapper to call use case with default error handling
  Future<TResult?> call(TParam param) async {
    try {
      return await execute(param);
    } catch (e, stk) {
      return _handleException(e, stk);
    }
  }

  TResult? _handleException(Object e, StackTrace stk) {
    debugPrint('Error occurred: $e');
    // debugPrint('Stack trace: $stk');
    // const ErrorHandler().handleErrorEvent(
    //   ErrorOccurredEvent(e),
    // );
    return null;
  }
}
