import 'package:habitree/core/result/result.dart';
import 'package:habitree/domain/entities/auth/session.dart';

abstract class AuthLocalDataSource {
  Future<Result<void>> saveSession(Session session);
  Future<Result<void>> clearSession();
  Future<Result<Session?>> getSavedSession();

  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();

  Future<void> saveAccessToken(String token);
  Future<void> saveRefreshToken(String token);
}

