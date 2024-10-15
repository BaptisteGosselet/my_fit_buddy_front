import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/data/services/auth_service/auth_service.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
 import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {

    return FlutterSplashScreen.fadeIn(
          useImmersiveMode : true,
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
          asyncNavigationCallback: () async { // TODO : authentification -> https://pub.dev/packages/another_flutter_splash_screen
          await Future.delayed(const Duration(seconds: 3));
            if (context.mounted) {
              GoRouter.of(context).goNamed("logging");
            }
          },
        );
  }
}
