import 'package:flutter/material.dart';
import 'package:my_fit_buddy/viewmodels/auth_viewmodel.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/widgets/buttons/fit_button.dart';
import 'package:my_fit_buddy/views/widgets/headers/fit_header.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final authViewmodel = AuthViewmodel();
  bool isEditing = false;
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
    setState(() {
      nameController.text = username;
      emailController.text = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fitCloudWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FitHeader(
                title: "Label Profil",
                leftIcon: isEditing ? Icons.close : null,
                onLeftIconPressed: isEditing
                    ? () {
                        setState(() {
                          isEditing = false;
                        });
                      }
                    : null,
                rightIcon: isEditing ? Icons.check : Icons.edit,
                onRightIconPressed: () {
                  if (isEditing) {
                    authViewmodel.editProfile(
                      nameController.text,
                      emailController.text,
                      context,
                    );
                  }
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Informations',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.grey, thickness: 1.0),
                    const SizedBox(height: 8.0),
                    const Text('Nom',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    const SizedBox(height: 4.0),
                    isEditing
                        ? TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Entrez votre nom',
                            ),
                          )
                        : Text(nameController.text,
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                    const SizedBox(height: 8.0),
                    const Text('Email',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    const SizedBox(height: 4.0),
                    isEditing
                        ? TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Entrez votre email',
                            ),
                          )
                        : Text(emailController.text,
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                    const SizedBox(height: 24.0),
                    if (isEditing)
                      Center(
                        child: FitButton(
                          buttonColor: Colors.red,
                          label: 'Supprimer le compte',
                          onClick: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirmation'),
                                content: const Text(
                                    'Êtes-vous sûr de vouloir supprimer votre compte ?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Annuler'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      authViewmodel.deleteAccount(context);
                                    },
                                    style: TextButton.styleFrom(
                                        foregroundColor: Colors.red),
                                    child: Text('Confirmer'),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
