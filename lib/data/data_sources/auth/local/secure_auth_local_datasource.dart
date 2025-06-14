import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:habitree/core/database/safe_local_call.dart';
import 'package:habitree/core/result/result.dart';
import 'package:habitree/data/data_sources/auth/local/auth_local_datasource.dart';
import 'package:habitree/data/models/auth/session_dto.dart';
import 'package:habitree/domain/entities/auth/session.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthLocalDataSource)
class SecureAuthLocalDataSource implements AuthLocalDataSource {
  SecureAuthLocalDataSource(this._storage);

  final FlutterSecureStorage _storage;

  static const _sessionKey = 'auth_session';

  @override
  Future<Result<void>> saveSession(Session session) {
    return safeLocalCall(() async {
      final dto = SessionDto.fromDomain(session);
      final json = jsonEncode(dto.toJson());
      log('Saving session: $json', name: 'SecureAuthLocalDataSource');
      await _storage.write(key: _sessionKey, value: json);
    });
  }

  @override
  Future<Result<void>> clearSession() {
    return safeLocalCall(() async {
      await _storage.delete(key: _sessionKey);
    });
  }

  @override
  Future<Result<Session?>> getSavedSession() {
    return safeLocalCall(() async {
      final jsonStr = await _storage.read(key: _sessionKey);
      log('Retrieving session: $jsonStr', name: 'SecureAuthLocalDataSource');
      if (jsonStr == null) return null;
      final jsonMap = jsonDecode(jsonStr) as Map<String, dynamic>;
      return SessionDto.fromJson(jsonMap).toDomain();
    });
  }
}
