import 'package:flutter/material.dart';
import 'package:my_fit_buddy/viewmodels/auth_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/buttons/fit_button.dart';
import 'package:my_fit_buddy/views/widgets/headers/fit_header.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final authViewmodel = AuthViewmodel();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final username = await authViewmodel.getUsername();
    final email = await authViewmodel.getEmail();
    if (mounted) {
      setState(() {
        nameController.text = username;
        emailController.text = email;
      });
    }
  }

  Future<void> _deleteAccount() async {
    if (!mounted) return;

    final bool result = await authViewmodel.deleteAccount(context);
    if (mounted) {
      if (result) {
        context.goNamed("register");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(AppLocalizations.of(context)!.accountDeleteFailed)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fitCloudWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FitHeader(
            title: AppLocalizations.of(context)!.profile,
          ),
          const SizedBox(height: 16.0),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    Text(
                      AppLocalizations.of(context)!.informationTitle,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.grey, thickness: 1.0),
                    const SizedBox(height: 8.0),
                    Text(
                      AppLocalizations.of(context)!.nameLabel,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      nameController.text,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      AppLocalizations.of(context)!.emailLabel,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      emailController.text,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Spacer(),
                    Center(
                      child: FitButton(
                        buttonColor: fitBlueDark,
                        label: AppLocalizations.of(context)!.logoutButton,
                        onClick: () {
                          authViewmodel.logout(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: FitButton(
                        buttonColor: Colors.red,
                        label: AppLocalizations.of(context)!.deleteAccountButton,
                        onClick: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(AppLocalizations.of(context)!.confirmation),
                                content: Text(AppLocalizations.of(context)!.deleteAccountConfirmation),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(AppLocalizations.of(context)!.cancel),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _deleteAccount();
                                    },
                                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                                    child: Text(AppLocalizations.of(context)!.confirm),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}