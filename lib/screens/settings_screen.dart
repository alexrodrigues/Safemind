import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    await _auth.signOut();
  }

  void _checkUserLoggedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome ${user.email ?? 'User'}')),
      );
    }
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmação"),
          content: Text("Tem certeza que deseja sair?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Sair"),
              onPressed: () {
                Navigator.of(context).pop();
                _signOut();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _reportBug() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'alex.rodrigues.developer@gmail.com',
      queryParameters: {
        'subject': 'Bug Report',
        'body': 'Por favor descreva o bug encontrado'
      },
    );

    try {
      await launch(emailLaunchUri.toString());
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLogged = FirebaseAuth.instance.currentUser != null;
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text(
            'Contato',
            style: TextStyle(
              color: Colors.black, // Change the color to blue
            ),
          ),
          tiles: <SettingsTile>[
            SettingsTile(
              title: Text("Reportar um bug"),
              onPressed: (context) {
                _reportBug();
              },
            ),
          ],
        ),
        SettingsSection(
          title: const Text(
            'Conta',
            style: TextStyle(
              color: Colors.black, // Change the color to blue
            ),
          ),
          tiles: <SettingsTile>[
            SettingsTile(
              title:  isLogged ? const Text("Sair") : const Text("Entrar"),
              onPressed: (context) {
                if (isLogged) {
                  _showSignOutDialog(context);

                } else {
                  _checkUserLoggedIn();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
