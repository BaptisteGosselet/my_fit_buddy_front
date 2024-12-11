import 'package:dio/dio.dart';
import 'package:my_fit_buddy/data/models/auth_models/login_form.dart';
import 'package:my_fit_buddy/data/models/auth_models/register_form.dart';
import 'package:my_fit_buddy/data/models/auth_models/token.dart';
import 'package:my_fit_buddy/data/services/api_service.dart';
import 'package:my_fit_buddy/data/services/auth_service/token_storage_service.dart';
import 'package:my_fit_buddy/utils/status_type.dart';

class AuthService {
  static const String authUrl = "/auth";

  Future<StatusType> register(
      String username, String email, String password) async {
    final RegisterForm registerForm =
        RegisterForm(username: username, email: email, password: password);
    try {
      await TokenStorageService.instance.removeToken();
      final response = await APIService.instance.request(
          "$authUrl/signup", DioMethod.post,
          param: registerForm.toJson(), authenticated: false);

      if (response.statusCode == 200) {
        return StatusType.ok;
      } else if (response.statusCode == 409) {
        if (response.data['detail'] != null) {
          if (response.data['detail'].contains('Username')) {
            return StatusType.registerUsernameAlreadyExists;
          }
          if (response.data['detail'].contains('Email')) {
            return StatusType.registerEmailAlreadyExists;
          }
        }
      } else {
        print('Erreur lors de l\'inscription: ${response.statusCode}');
        return StatusType.unknownError;
      }
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
      return StatusType.unknownError;
    }
    return StatusType.unknownError;
  }

  Future<StatusType> login(String username, String password) async {
    final LoginForm loginForm =
        LoginForm(usernameOrEmail: username, password: password);
    print('AuthService.login');
    try {
      await TokenStorageService.instance.removeToken();
      final response = await APIService.instance.request(
          "$authUrl/signin", DioMethod.post,
          param: loginForm.toJson(), authenticated: false);

      print(response);
      print(response.data['detail']);

      if (response.statusCode == 200) {
        TokenStorageService.instance.saveToken(Token.fromJson(response.data));
        await APIService.instance.retrieveRefreshToken();
        return StatusType.ok;
      } else if (response.statusCode == 401) {
        if (response.data['detail'] != null) {
          if (response.data['detail'].contains('Bad credentials')) {
            return StatusType.loginBadCredentials;
          }
        }
      } else {
        print('Erreur lors de la connexion : ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
    }
    return StatusType.unknownError;
  }

  Future<String?> getUsername() async {
    try {
      final response = await APIService.instance
          .request("/me/username", DioMethod.get, authenticated: true);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print(
            'Erreur lors de la récupération du nom d\'utilisateur : ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
    }
    return null;
  }

  Future<String?> getEmail() async {
    try {
      final response = await APIService.instance
          .request("/me/email", DioMethod.get, authenticated: true);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print(
            'Erreur lors de la récupération de l\'email : ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
    }
    return null;
  }
}
