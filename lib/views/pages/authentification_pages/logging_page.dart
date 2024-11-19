import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/viewmodels/auth_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';
import 'package:my_fit_buddy/views/widgets/fit_button.dart';
import 'package:my_fit_buddy/views/widgets/inputs/fit_text_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoggingPage extends StatelessWidget {
  const LoggingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthViewmodel loggingViewmodel = AuthViewmodel();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  AppLocalizations.of(context)!.welcomeLoginMessage,
                  style:
                      const TextStyle(fontWeight: fitWeightBold, fontSize: 32),
                  textAlign: TextAlign.start,
                ),
              ),

              const Spacer(),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: FitTextInput(
                  label: AppLocalizations.of(context)!.name,
                  controller: usernameController,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: FitTextInput(
                  label: AppLocalizations.of(context)!.password,
                  isHidden: true,
                  controller: passwordController,
                ),
              ),

              const Spacer(),

              FitButton(
                buttonColor: fitBlueDark,
                label: AppLocalizations.of(context)!.login,
                onClick: () => {
                  loggingViewmodel.login(usernameController.text,
                      passwordController.text, context),
                },
              ),
              FitButton(
                buttonColor: fitBlueMiddle,
                label: AppLocalizations.of(context)!.goToRegister,
                onClick: () => {context.goNamed('register')},
              ),
            ],
          ),
        )));
  }
}
