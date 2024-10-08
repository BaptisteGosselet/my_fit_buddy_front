import 'package:my_fit_buddy/services/login_service.dart';

class LoggingViewmodel {
  LoginService loginService = LoginService();

  login(String email, String password) {
    password = '#$password#'; //simule le hash admettons
    loginService.login(email, password);
  }

  register(String name, String email, String password, String passwordConfirm) {
    password = '#$password#';
  }

  enterInviteMode() {
    loginService.enterInviteMode();
  }
}
