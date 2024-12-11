import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/data/services/api_service.dart';
import 'package:my_fit_buddy/data/services/auth_service/auth_service.dart';
import 'package:my_fit_buddy/data/services/auth_service/token_storage_service.dart';
import 'package:my_fit_buddy/managers/toast_manager.dart';
import 'package:my_fit_buddy/utils/status_type.dart';
import 'package:my_fit_buddy/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthViewmodel {
  AuthService authService = AuthService();

  test() async {
    try {
      String result = await APIService.instance.test();
      print('Résultat du test : $result');
    } catch (e) {
      print('Résultat du test : Erreur lors du test API : $e');
    }
  }

  Future<void> register(String username, String email, String password,
      String passwordConfirm, BuildContext context) async {
    await TokenStorageService.instance.removeToken();

    String forbiddenUsernameCharacters =
        Utils.instance.usernameForbiddenCharacters(username);

    if (username.length > 20) {
      if (context.mounted) {
        ToastManager.instance.showWarningToast(
            context, AppLocalizations.of(context)!.registerUsernameTooLong);
      }
      return;
    }

    if (forbiddenUsernameCharacters.isNotEmpty) {
      if (context.mounted) {
        ToastManager.instance.showWarningToast(
            context,
            AppLocalizations.of(context)!.registerForbiddenUsernameCharacters +
                forbiddenUsernameCharacters);
      }
      return;
    }

    if (!Utils.instance.isValidEmail(email)) {
      if (context.mounted) {
        ToastManager.instance.showWarningToast(
            context, AppLocalizations.of(context)!.registerNotValidEmailFormat);
      }
      return;
    }
    if (password.length < 8) {
      if (context.mounted) {
        ToastManager.instance.showWarningToast(
            context, AppLocalizations.of(context)!.registerPasswordTooShort);
      }
      return;
    }
    if (password != passwordConfirm) {
      if (context.mounted) {
        ToastManager.instance.showWarningToast(
            context, AppLocalizations.of(context)!.registerDifferentPassword);
      }
      return;
    }

    await test();

    username = username.toLowerCase();
    email = email.toLowerCase();

    StatusType result = await authService.register(username, email, password);
    if (context.mounted) {
      if (result == StatusType.ok) {
        login(username, password, context);
        ToastManager.instance.showSuccessToast(
            context, AppLocalizations.of(context)!.registerSuccess);
      } else {
        if (result == StatusType.registerUsernameAlreadyExists) {
          ToastManager.instance.showErrorToast(context,
              AppLocalizations.of(context)!.registerUsernameAlreadyExists);
        }
        if (result == StatusType.registerEmailAlreadyExists) {
          ToastManager.instance.showErrorToast(context,
              AppLocalizations.of(context)!.registerEmailAlreadyExists);
        }
        if (result == StatusType.unknownError) {
          ToastManager.instance.showErrorToast(
              context, AppLocalizations.of(context)!.unknownError);
        }
      }
    }
  }

  Future<void> login(
      String username, String password, BuildContext context) async {
    await TokenStorageService.instance.removeToken();

    await test();
    print('AuthViewModel.login');
    StatusType result = await authService.login(username, password);
    if (context.mounted) {
      if (result == StatusType.ok) {
        context.goNamed('home');
      } else if (result == StatusType.loginBadCredentials) {
        ToastManager.instance.showErrorToast(
            context, AppLocalizations.of(context)!.loginBadCredentials);
      } else {
        ToastManager.instance.showErrorToast(
            context, AppLocalizations.of(context)!.unknownError);
      }
    }
    return;
  }

  Future<void> logout(BuildContext context) async {
    await TokenStorageService.instance.removeToken();
    if (context.mounted) {
      context.goNamed('loading');
    }
    return;
  }

  Future<bool> deleteAccount(BuildContext context) async {
    print("Compte deleted");
    /*
    try {
      StatusType result = await authService.deleteAccount();

      if (result == StatusType.ok) {
        await TokenStorageService.instance.removeToken();
        if (context.mounted) {
          ToastManager.instance.showSuccessToast(
              context, AppLocalizations.of(context)!.deleteAccountSuccess);
          context.goNamed(
              'welcome'); // Redirection vers la page d'accueil ou de bienvenue
        }
        return true;
      } else if (result == StatusType.unauthorized) {
        if (context.mounted) {
          ToastManager.instance.showErrorToast(
              context, AppLocalizations.of(context)!.unauthorizedAction);
        }
      } else {
        if (context.mounted) {
          ToastManager.instance.showErrorToast(
              context, AppLocalizations.of(context)!.deleteAccountFailed);
        }
      }
    } catch (e) {
      if (context.mounted) {
        ToastManager.instance.showErrorToast(
            context, AppLocalizations.of(context)!.unknownError);
      }
    }
    */
    return false;
  }

  Future<bool> editProfile(final String newUsername, final String newEmail,
      final BuildContext context) async {
    print("edit $newUsername, $newEmail");
    return false;
  }

  Future<String> getUsername() async {
    try {
      String? username = await authService.getUsername();
      if (username != null) {
        return username;
      } else {
        return "Failed to fetch username";
      }
    } catch (e) {
      return "Error: $e";
    }
  }

  Future<String> getEmail() async {
    try {
      String? email = await authService.getEmail();
      if (email != null) {
        return email;
      } else {
        return "Failed to fetch email";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}
