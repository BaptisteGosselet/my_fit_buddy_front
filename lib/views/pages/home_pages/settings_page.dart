import 'package:flutter/material.dart';
import 'package:my_fit_buddy/viewmodels/auth_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/fit_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewmodel = AuthViewmodel();
    return Scaffold(
      backgroundColor: fitCloudWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Settings Page', style: TextStyle(color: Colors.black)),
            FitButton(
              buttonColor: fitBlueDark,
              label: 'LABEL DECONNEXION',
              onClick: () => { authViewmodel.logout(context) },
            ),
          ],
        ),
      ),
    );
  }
}
