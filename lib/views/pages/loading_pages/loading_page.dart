import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/data/models/auth_models/token.dart';
import 'package:my_fit_buddy/data/services/api_service.dart';
import 'package:my_fit_buddy/data/services/auth_service/token_storage_service.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      useImmersiveMode: true,
      backgroundColor: Colors.white,
      childWidget: SizedBox(
        height: 250,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/images/MyFitBuddy.png"),
            LinearProgressIndicator(
              backgroundColor: fitBlueSky,
              color: fitBlueDark,
              minHeight: 6,
              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ),
      ),
      asyncNavigationCallback: () async {
        await Future.delayed(const Duration(seconds: 2));

        // Variable pour contrôler si la requête a réussi
        bool requestSuccessful = false;

        // Tentative de tester l'API en boucle avec un délai de 5 secondes
        while (!requestSuccessful) {
          try {
            String s = await APIService.instance.test();

            if (s.contains('ok')) {
              print("Réponse API valide.");
              requestSuccessful = true;
            } else {
              print("Réponse API invalide.");
            }
          } catch (e) {
            print(
                "Erreur lors de la requête API, tentative de nouveau dans 5 secondes.");
          }

          // Si la requête échoue, attendre 5 secondes avant de réessayer
          if (!requestSuccessful) {
            await Future.delayed(const Duration(seconds: 5));
          }
        }

        print("loading page.");

        bool allowToGoHome = false;

        // Récupération du token stocké
        Token? storedToken = await TokenStorageService.instance.getToken();

        if (storedToken != null && storedToken.hasRefreshTokenValid()) {
          try {
            // Tentative de rafraîchissement du token
            if (await APIService.instance.retrieveRefreshToken()) {
              print("loading page valide le token");
              allowToGoHome = true;
            } else {
              print("Le refresh token n'est pas valide.");
            }
          } catch (e) {
            print("Erreur lors de la récupération du token : $e");
            // Échec de la récupération du token, ne permet pas d'aller à la page d'accueil
          }
        } else {
          print("Le token stocké est invalide ou inexistant.");
        }

        // Si le token n'a pas été validé, on le supprime
        if (!allowToGoHome) {
          print("le token n'a pas été validé par loading page");
          await TokenStorageService.instance.removeToken();
        }

        // Vérification que le contexte est monté avant de naviguer
        if (context.mounted) {
          if (allowToGoHome) {
            GoRouter.of(context).goNamed("home");
          } else {
            GoRouter.of(context).goNamed("register");
          }
        }
      },
    );
  }
}
