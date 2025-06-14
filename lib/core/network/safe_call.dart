import 'dart:io';

import 'package:dio/dio.dart';
import 'package:habitree/core/error/failure_types.dart';
import 'package:habitree/core/result/result.dart';
import 'package:habitree/i18n/strings.g.dart';

Future<Result<T>> safeCall<T>(Future<T> Function() request) async {
  try {
    final data = await request();
    return Success(data);
  } on DioException catch (e, stack) {
    final status = e.response?.statusCode;
    final res = e.response;

    if (status == 401) {
      return FailureResult(
        HttpFailure(
          userMessage: t.errors.sessionExpired,
          code: '401',
          originalError: e,
          response: res,
          stackTrace: stack,
        ),
      );
    }

    if (status == 404) {
      return FailureResult(
        HttpFailure(
          userMessage: t.errors.notFound,
          code: '404',
          originalError: e,
          response: res,
          stackTrace: stack,
        ),
      );
    }

    if (status == 500) {
      return FailureResult(
        HttpFailure(
          userMessage: t.errors.serverError,
          code: '500',
          originalError: e,
          response: res,
          stackTrace: stack,
        ),
      );
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return FailureResult(
        HttpFailure(
          userMessage: t.errors.timeout,
          code: 'timeout',
          originalError: e,
          response: res,
          stackTrace: stack,
        ),
      );
    }

    if (e.type == DioExceptionType.unknown && e.error is SocketException) {
      return FailureResult(
        HttpFailure(
          userMessage: t.errors.noInternet,
          code: 'no_internet',
          originalError: e,
          response: res,
          stackTrace: stack,
        ),
      );
    }

    final dynamic data = res?.data;
    final extractedMsg = (data is Map<String, dynamic> && data['msg'] is String)
        ? data['msg'] as String
        : t.errors.unknownHttp;

    return FailureResult(
      HttpFailure(
        userMessage: extractedMsg,
        code: status?.toString() ?? 'unknown_http',
        originalError: e,
        response: res,
        stackTrace: stack,
      ),
    );
  } on Object catch (e, stack) {
    return FailureResult(
      UnknownFailure(
        userMessage: t.errors.unknown,
        originalError: e,
        stackTrace: stack,
      ),
    );
  }
}
