import 'package:dio/dio.dart';

/// Base class for all application-level failures.
abstract class Failure {
  const Failure({
    required this.userMessage,
    this.code,
    this.originalError,
    this.response,
    this.stackTrace,
  });

  /// UI-friendly message for user display (e.g. snackbar, error page)
  final String userMessage;

  /// Optional code (e.g. '401', 'no_internet', 'validation_required')
  final String? code;

  /// Optional technical error (DioException, SocketException, etc.)
  final Object? originalError;

  /// Optional HTTP response (only for Dio errors)
  final Response<dynamic>? response;

  /// Optional stack trace (debugging or logging)
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'Failure(userMessage: $userMessage, code: $code, originalError: '
        '$originalError, response: $response, stackTrace: $stackTrace)';
  }
}
