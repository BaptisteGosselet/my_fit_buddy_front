import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/core/http/refresh_token_action.dart';
import 'package:my_fit_buddy/managers/token_manager.dart';
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
        print("L'appli est en train de load");
        await Future.delayed(const Duration(seconds: 2));

        bool allowToGoHome = false;

        if (await TokenManager.instance.isRefreshTokenValid()) {
          allowToGoHome = await RefreshTokenAction.instance.refreshToken();
        }

        if (!allowToGoHome) {
          await TokenManager.instance.clearToken();
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
