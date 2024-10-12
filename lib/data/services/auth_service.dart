import 'package:dio/dio.dart';
import 'package:my_fit_buddy/data/models/auth_models/register_form.dart';
import 'package:my_fit_buddy/data/services/api_service.dart';

class AuthService {
  static const String authUrl = "/auth";

  Future<String?> register(String username, String password) async {
    final RegisterForm registerForm =
        RegisterForm(username: username, password: password);

    try {
      final response = await APIService.instance.request(
          "$authUrl/register", DioMethod.post,
          param: registerForm.toJson(), contentType: "application/json");

      if (response.statusCode == 200) {
        final String message = response.data
            .toString(); //pour les objets un exemple : User.fromJson(response.data)
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

  login(String email, String password) {
    //print('Connexion ViewModel - email:`$email`, password:`$password`');
  }

  enterInviteMode() {
    //print('Mode invité Viewmodel');
  }
}
