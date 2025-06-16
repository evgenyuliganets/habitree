import 'dart:developer';

enum EmailAuthStatus {
  notFound,
  awaitingConfirmation,
  confirmed;

  factory EmailAuthStatus.fromString(String? value) {
    final normalized = value?.trim();
    log(
      'Converting string to EmailAuthStatus: $normalized',
      name: 'EmailAuthStatus',
    );
    return switch (normalized) {
      'not_found' => EmailAuthStatus.notFound,
      'awaiting_confirmation' => EmailAuthStatus.awaitingConfirmation,
      'confirmed' => EmailAuthStatus.confirmed,
      _ => throw const FormatException('Unknown email status'),
    };
  }
}
