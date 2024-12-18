import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_fit_buddy/data/models/auth_models/token.dart';

class TokenStorageService {
  TokenStorageService._singleton();
  static final TokenStorageService instance = TokenStorageService._singleton();

  final storage = const FlutterSecureStorage();

  Future<void> saveToken(Token token) async {
    await storage.write(key: 'jwt', value: jsonEncode(token.toJson()));
    print(
        'TokenStorageService.saveToken : Token enregistré sous forme de JSON.');
  }

  Future<Token?> getToken() async {
    final tokenJson = await storage.read(key: 'jwt');
    if (tokenJson != null) {
      final Map<String, dynamic> tokenMap = jsonDecode(tokenJson);
      return Token.fromJson(tokenMap);
    }
    print('TokenStorageService.getToken : Aucun token trouvé.');
    return null;
  }

  Future<void> removeToken() async {
    await storage.delete(key: 'jwt');
    print('TokenStorageService.removeToken : Token supprimé.');
  }

  Future<bool> hasToken() async {
    return await storage.read(key: 'jwt') != null;
  }

  Future<bool> isRefreshTokenValid() async {
    final Token? tokenJson = await getToken();
    if (tokenJson == null) {
      return false;
    } else {
      return tokenJson.hasRefreshTokenValid();
    }
  }
}
