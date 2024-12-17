import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/data/models/auth_models/edit_user_form.dart';
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
    print("delete account");

    //test account
    if ((await getUsername()).contains("dbuser")) {
      print("NE SUPPRIME PAS DBUSER !!");
      return false;
    }

    try {
      bool result = await authService.deleteAccount();

      if (result) {
        await TokenStorageService.instance.removeToken();
        if (context.mounted) {
          ToastManager.instance
              .showSuccessToast(context, "Compte supprimé avec succès");
          context.goNamed('register');
        }
        return true;
      } else {
        if (context.mounted) {
          ToastManager.instance
              .showErrorToast(context, "Échec de la suppression du compte");
        }
      }
    } catch (e) {
      if (context.mounted) {
        ToastManager.instance.showErrorToast(context, "Erreur inconnue");
      }
    }
    return false;
  }

  Future<bool> editProfile(final String newUsername, final String newEmail,
      final BuildContext context) async {
    print("Editing profile with username: $newUsername, email: $newEmail");

    // Validation for username
    if (newUsername.isEmpty || newUsername.length > 20) {
      if (context.mounted) {
        ToastManager.instance.showWarningToast(
          context,
          AppLocalizations.of(context)!.editProfileInvalidUsername,
        );
      }
      return false;
    }

    String forbiddenUsernameCharacters =
        Utils.instance.usernameForbiddenCharacters(newUsername);
    if (forbiddenUsernameCharacters.isNotEmpty) {
      if (context.mounted) {
        ToastManager.instance.showWarningToast(
          context,
          AppLocalizations.of(context)!.editProfileForbiddenUsernameCharacters +
              forbiddenUsernameCharacters,
        );
      }
      return false;
    }

    if (!Utils.instance.isValidEmail(newEmail)) {
      if (context.mounted) {
        ToastManager.instance.showWarningToast(
          context,
          AppLocalizations.of(context)!.editProfileInvalidEmail,
        );
      }
      return false;
    }

    try {
      final editUserForm = EditUserForm(
        username: newUsername.toLowerCase(),
        email: newEmail.toLowerCase(),
      );

      bool result = await authService.editUser(editUserForm);

      if (result) {
        if (context.mounted) {
          ToastManager.instance.showSuccessToast(
            context,
            AppLocalizations.of(context)!.editProfileSuccess,
          );
          logout(context);
        }
        return true;
      } else {
        if (context.mounted) {
          ToastManager.instance.showErrorToast(
            context,
            AppLocalizations.of(context)!.editProfileFailure,
          );
        }
      }
    } catch (e) {
      print("Error editing profile: $e");
      if (context.mounted) {
        ToastManager.instance.showErrorToast(
          context,
          AppLocalizations.of(context)!.unknownError,
        );
      }
    }

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
