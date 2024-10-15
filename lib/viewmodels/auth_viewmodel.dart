import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/data/services/api_service.dart';
import 'package:my_fit_buddy/data/services/auth_service/auth_service.dart';

class AuthViewmodel {
  AuthService authService = AuthService();

  test() async {
    try {
      String result = await APIService.instance.test();
      print('Résultat du test : $result');
    } catch (e) {
      print('Erreur lors du test API : $e');
    }
  }

  Future<void> register(
      String username, String password, String passwordConfirm, BuildContext context) async {
    await test();
    if (password == passwordConfirm) {
      String? result = await authService.register(username, password);
      if (result != null) {
        login(username, password, context);
        print(result);
      } else {
        print("result null");
      }
    } else {
      print("Les mots de passes sont différents");
    }
  }

  Future<void> login(String username, String password, BuildContext context) async {
    await test();
    print("login");
    bool redirect = await authService.login(username, password);
    if(redirect){
      context.goNamed('home');
    }
    return;
  }
}
