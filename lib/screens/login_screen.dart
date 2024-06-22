import 'package:flutter/material.dart';

import '../widget/sf_appbar.dart';
import '../widget/sf_primary_button.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      // Perform login logic
      final email = _emailController.text;
      final password = _passwordController.text;
      print('Email: $email, Password: $password');
      // You can add your authentication logic here
    }
  }

  void _createAccount() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SfAppBar("Welcome"),
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
              SfPrimaryButton(
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
