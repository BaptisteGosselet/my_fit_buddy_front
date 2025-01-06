import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:my_fit_buddy/data/models/auth_models/token.dart';

class TokenManager {
  static final TokenManager _instance = TokenManager._internal();
  Token? _token;

  late FlutterSecureStorage _secureStorage;

  static const String tokenKey = 'token';

  TokenManager._internal() {
    _secureStorage = const FlutterSecureStorage();
  }

  static TokenManager get instance {
    return _instance;
  }

  Future<String?> getAccessToken() async {
    if (_token == null) {
      await _loadToken();
    }
    return _token?.accessToken;
  }

  Future<bool> isAccessTokenValid() async {
    if (_token == null) {
      await _loadToken();
    }
    if (_token?.accessExpirationDate == null) {
      return false;
    }
    return DateTime.now().isBefore(_token!.accessExpirationDate!);
  }

  Future<void> setToken(Token token) async {
    _token = token;
    String tokenJson = jsonEncode(token.toJson());
    await _secureStorage.write(key: tokenKey, value: tokenJson);
  }

  Future<String?> getRefreshToken() async {
    if (_token == null) {
      await _loadToken();
    }
    return _token?.refreshToken;
  }

  Future<bool> isRefreshTokenValid() async {
    if (_token == null) {
      await _loadToken();
    }
    if (_token?.refreshExpirationDate == null) {
      return false;
    }
    return DateTime.now().isBefore(_token!.refreshExpirationDate!);
  }

  Future<void> clearToken() async {
    await _secureStorage.delete(key: tokenKey);
    _token = null;
  }

  Future<void> _loadToken() async {
    try {
      String? tokenJson = await _secureStorage.read(key: tokenKey);
      if (tokenJson != null) {
        Map<String, dynamic> tokenMap = jsonDecode(tokenJson);
        _token = Token.fromJson(tokenMap);
      }
    } catch (e) {
      // handle error
      _token = null;
    }
  }
}
