import 'package:my_fit_buddy/core/http/http.dart';
import 'package:my_fit_buddy/data/models/auth_models/token.dart';
import 'package:my_fit_buddy/managers/token_manager.dart';

class RefreshTokenAction {
  RefreshTokenAction._singleton();
  static final RefreshTokenAction instance = RefreshTokenAction._singleton();
  static const String refreshTokenEndpoint = '/auth/refresh-token';

  Future<bool> refreshToken() async {
    try {
      final response = await Http.instance.request(
        refreshTokenEndpoint,
        DioMethod.post,
        authenticated: true,
        skipRefreshing: true,
      );

      if (response.statusCode == 200) {
        Token newToken = Token.fromJson(response.data);
        await TokenManager.instance.setToken(newToken);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
