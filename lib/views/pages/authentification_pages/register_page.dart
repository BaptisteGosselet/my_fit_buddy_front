import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/viewmodels/logging_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/my_fit_button.dart';
import 'package:my_fit_buddy/views/widgets/text_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoggingViewmodel loggingViewmodel = LoggingViewmodel();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController passwordConfirmController =
        TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  AppLocalizations.of(context)!.welcomeRegisterMessage,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 32),
                  textAlign: TextAlign.start,
                ),
              ),

              const Spacer(),

              //Fields
              Column(
                children: [
                  TextInput(
                    label: AppLocalizations.of(context)!.name,
                    controller: nameController,
                  ),
                  TextInput(
                    label: AppLocalizations.of(context)!.email,
                    controller: emailController,
                  ),
                  TextInput(
                    label: AppLocalizations.of(context)!.password,
                    isHidden: true,
                    controller: passwordController,
                  ),
                  TextInput(
                    label: AppLocalizations.of(context)!.passwordConfirm,
                    isHidden: true,
                    controller: passwordConfirmController,
                  )
                ],
              ),
              const Spacer(),

              //Buttons
              Column(
                children: [
                  MyFitButton(
                      buttonColor: fitBlueDark,
                      label: AppLocalizations.of(context)!.register,
                      onClick: () => {
                            loggingViewmodel.register(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                                passwordConfirmController.text)
                          }),
                  MyFitButton(
                      buttonColor: fitBlueMiddle,
                      label: AppLocalizations.of(context)!.login,
                      onClick: () => {context.goNamed('logging')}),
                ],
              ),
            ],
          ),
        )));
  }
}
