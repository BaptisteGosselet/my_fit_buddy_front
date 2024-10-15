import 'package:dio/dio.dart';
import 'package:my_fit_buddy/data/models/auth_models/login_form.dart';
import 'package:my_fit_buddy/data/models/auth_models/register_form.dart';
import 'package:my_fit_buddy/data/models/auth_models/token.dart';
import 'package:my_fit_buddy/data/services/api_service.dart';
import 'package:my_fit_buddy/data/services/auth_service/token_storage_service.dart';

class AuthService {
  static const String authUrl = "/auth";

  Future<String?> register(String username, String password) async {
    final RegisterForm registerForm =
        RegisterForm(username: username, password: password);

    try {
      final response = await APIService.instance.request(
          "$authUrl/signup", DioMethod.post,
          param: registerForm.toJson());

      if (response.statusCode == 200) {
        final String message = response.data.toString();
        return message;
      } else {
        print('Erreur lors de l\'inscription: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
      return null;
    }
  }

  Future<bool> login(String username, String password) async {
    final LoginForm loginForm =
        LoginForm(username: username, password: password);

    try {
      final response = await APIService.instance.request(
          "$authUrl/signin", DioMethod.post,
          param: loginForm.toJson());

      if (response.statusCode == 200) {
        TokenStorageService.instance.saveToken(Token.fromJson(response.data));
        return true;
      } else {
        print('Erreur lors de la connexion : ${response.statusCode}');
        return false;
      }
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
      return false;
    }
  }
}
