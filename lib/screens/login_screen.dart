import 'package:flutter/material.dart';
import 'package:safemind/screens/signup_screen.dart';
import 'package:safemind/screens/tab_screen.dart';
import '../widget/sf_appbar.dart';
import '../widget/sf_primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const ROUTE_NAME = "LoginScreen";
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Navigate to the home screen or show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully logged in')),
        );
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, TabScreen.ROUTE_NAME);
        });
      } on FirebaseAuthException catch (e) {
        String message = 'An error occurred, please try again';
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _createAccount() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );

    if (result == true) {
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SfAppBar(
        "Welcome",
        backIcon: Icons.clear,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              TextButton(
                onPressed: _createAccount,
                child: Text('Create Account'),
              ),
              const SizedBox(height: 32),
              _isLoading
                  ? CircularProgressIndicator()
                  : SfPrimaryButton(
                "Login",
                _login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}