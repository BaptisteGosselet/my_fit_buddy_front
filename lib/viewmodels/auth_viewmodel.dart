import 'package:my_fit_buddy/data/services/api_service.dart';
import 'package:my_fit_buddy/data/services/auth_service.dart';

class AuthViewmodel {
  AuthService authService = AuthService();

  test() async {
    print('test');
    try {
      String result = await APIService.instance.test();
      print('Résultat du test : $result');
    } catch (e) {
      print('Erreur lors du test API : $e');
    }
  }

  register(String username, String email, String password,
      String passwordConfirm) async {
    await test();
    if (password == passwordConfirm) {
      String? result = await authService.register(username, password);
      if (result != null) {
        print(result);
      } else {
        print("result null");
      }
    } else {
      print("Les mots de passes sont différents");
    }
  }

  login(String email, String password) {
    password = '#$password#'; //simule le hash admettons
    authService.login(email, password);
  }
}
