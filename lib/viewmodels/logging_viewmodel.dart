import 'package:my_fit_buddy/data/services/api_service.dart';
import 'package:my_fit_buddy/data/services/login_service.dart';

class LoggingViewmodel {
  LoginService loginService = LoginService();

  test() async {
    print('test');
    try {
      String result = await APIService.instance.test();
      print(
          'Résultat du test : $result'); // Afficher la réponse dans la console
    } catch (e) {
      print('Erreur lors du test API : $e');
    }
  }

  login(String email, String password) {
    password = '#$password#'; //simule le hash admettons
    loginService.login(email, password);
  }

  register(String name, String email, String password, String passwordConfirm) {
    password = '#$password#';
    test();
  }

  enterInviteMode() {
    loginService.enterInviteMode();
  }
}
