import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:habitree/core/database/safe_local_call.dart';
import 'package:habitree/core/result/result.dart';
import 'package:habitree/data/data_sources/auth/local/auth_local_datasource.dart';
import 'package:habitree/data/models/auth/session_dto.dart';
import 'package:habitree/domain/entities/auth/session.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthLocalDataSource)
class SecureAuthLocalDataSource implements AuthLocalDataSource {
  SecureAuthLocalDataSource(this._storage);

  final FlutterSecureStorage _storage;
  static const _sessionKey = 'auth_session';

  Session? _sessionCache;

  @override
  Future<Result<void>> saveSession(Session session) {
    return safeLocalCall(() async {
      final dto = SessionDto.fromDomain(session);
      final json = jsonEncode(dto.toJson());

      _sessionCache = session;

      log('🔐 Saving session: $json', name: 'SecureAuthLocalDataSource');
      await _storage.write(key: _sessionKey, value: json);
    });
  }

  @override
  Future<Result<void>> clearSession() {
    return safeLocalCall(() async {
      _sessionCache = null;
      await _storage.delete(key: _sessionKey);
      log(
        '🧹 Session cleared (RAM + Storage)',
        name: 'SecureAuthLocalDataSource',
      );
    });
  }

  @override
  Future<Result<Session?>> getSavedSession() {
    return safeLocalCall(() async {
      if (_sessionCache != null) {
        log(
          '✅ Returning session from cache',
          name: 'SecureAuthLocalDataSource',
        );
        return _sessionCache;
      }

      final jsonStr = await _storage.read(key: _sessionKey);
      log(
        '📦 Retrieving session from storage: $jsonStr',
        name: 'SecureAuthLocalDataSource',
      );

      if (jsonStr == null) return null;

      final jsonMap = jsonDecode(jsonStr) as Map<String, dynamic>;
      final session = SessionDto.fromJson(jsonMap).toDomain();
      _sessionCache = session;
      return session;
    });
  }

  @override
  Future<String?> getAccessToken() async {
    final result = await getSavedSession();
    return result.getOrNull()?.accessToken;
  }

  @override
  Future<String?> getRefreshToken() async {
    final result = await getSavedSession();
    return result.getOrNull()?.refreshToken;
  }

  @override
  Future<void> saveAccessToken(String token) async {
    final result = await getSavedSession();
    final session = result.dataOrNull;
    if (session == null) return;

    final updated = Session(
      accessToken: token,
      refreshToken: session.refreshToken,
      expiresAt: session.expiresAt,
    );

    await saveSession(updated);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    final result = await getSavedSession();
    final session = result.dataOrNull;
    if (session == null) return;

    final updated = Session(
      accessToken: session.accessToken,
      refreshToken: token,
      expiresAt: session.expiresAt,
    );

    await saveSession(updated);
  }
}
