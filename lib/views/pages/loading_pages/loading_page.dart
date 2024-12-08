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
            )
          ],
        ),
      ),
      asyncNavigationCallback: () async {
        await Future.delayed(const Duration(seconds: 2));

        print("loading page.");

        bool allowToGoHome = false;

        Token? storedToken = await TokenStorageService.instance.getToken();
        if (storedToken != null && storedToken.hasRefreshTokenValid()) {
          if (await APIService.instance.retrieveRefreshToken()) {
            print("loading page valide le token");
            allowToGoHome = true;
          }
        }

        if (!allowToGoHome) {
          print("le token n'a pas été validé par loading page");
          await TokenStorageService.instance.removeToken();
          allowToGoHome = false;
        }

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
