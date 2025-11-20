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
                onSubmit: (username, password) async {
                  // Simulated async submit handler for testing the loading state.
                  await Future.delayed(const Duration(seconds: 2));
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Signed in as: $username')),
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
