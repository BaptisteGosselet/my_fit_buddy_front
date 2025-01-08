import 'package:dio/dio.dart';
import 'package:my_fit_buddy/core/http/http.dart';
import 'package:my_fit_buddy/data/models/auth_models/edit_user_form.dart';
import 'package:my_fit_buddy/data/models/auth_models/login_form.dart';
import 'package:my_fit_buddy/data/models/auth_models/register_form.dart';
import 'package:my_fit_buddy/data/models/auth_models/token.dart';
import 'package:my_fit_buddy/managers/token_manager.dart';
import 'package:my_fit_buddy/utils/status_type.dart';

class AuthService {
  static const String authUrl = "/auth";
  static const String userUrl = "/users";

  Future<StatusType> register(
      String username, String email, String password) async {
    final RegisterForm registerForm =
        RegisterForm(username: username, email: email, password: password);
    try {
      await TokenManager.instance.clearToken();
      final response = await Http.instance.request(
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
        return StatusType.unknownError;
      }
    } on DioException {
      return StatusType.unknownError;
    }
    return StatusType.unknownError;
  }

  Future<StatusType> login(String username, String password) async {
    final LoginForm loginForm =
        LoginForm(usernameOrEmail: username, password: password);
    await TokenManager.instance.clearToken();
    final response = await Http.instance.request(
        "$authUrl/signin", DioMethod.post,
        param: loginForm.toJson(), authenticated: false);

    if (response.statusCode == 200) {
      TokenManager.instance.setToken(Token.fromJson(response.data));
      return StatusType.ok;
    } else if (response.statusCode == 401) {
      if (response.data['detail'] != null) {
        if (response.data['detail'].contains('Bad credentials')) {
          return StatusType.loginBadCredentials;
        }
      }
    }

    return StatusType.unknownError;
  }

  Future<String?> getUsername() async {
    try {
      final response = await Http.instance
          .request("$userUrl/me/username", DioMethod.get, authenticated: true);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException {
      return null;
    }
    return null;
  }

  Future<String?> getEmail() async {
    try {
      final response = await Http.instance
          .request("$userUrl/me/email", DioMethod.get, authenticated: true);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException {
      return null;
    }
    return null;
  }

  // Nouvelle méthode deleteAccount
  Future<bool> deleteAccount() async {
    try {
      final response = await Http.instance
          .request("$userUrl/me/delete", DioMethod.delete, authenticated: true);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException {
      return false;
    }
  }

  Future<bool> editUser(EditUserForm form) async {
    try {
      final response = await Http.instance.request(
        "$userUrl/me/edit",
        DioMethod.put,
        param: form.toJson(),
        authenticated: true,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException {
      return false;
    }
  }
}
