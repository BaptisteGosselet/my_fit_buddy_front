import 'package:my_fit_buddy/services/login_service.dart';

class LoggingViewmodel {
  LoginService loginService = LoginService();

  login(String email, String password) {
    password = '#$password#'; //simule le hash admettons
    loginService.login(email, password);
  }

  enterInviteMode() {
    loginService.enterInviteMode();
  }
}
