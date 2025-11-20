import 'package:flutter/material.dart';
import 'sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SignInForm(
                onSubmit: (username, password) {
                  // Placeholder submit handler for now — will be replaced by business logic later
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Submitted username: $username')),
                  );
                },
                onForgotPassword: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Forgot password tapped')),
                  );
                },
                onCreateAccount: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Create account tapped')),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
