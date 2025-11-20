import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  final void Function(String username, String password)? onSubmit;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onCreateAccount;

  const SignInForm({
    Key? key,
    this.onSubmit,
    this.onForgotPassword,
    this.onCreateAccount,
  }) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Tracks whether password is visible. Requirement: widget should hold `showPassword` state.
  bool _showPassword = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _handleSubmit() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    widget.onSubmit?.call(username, password);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _passwordController,
            obscureText: !_showPassword,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: _toggleShowPassword,
                tooltip: _showPassword ? 'Hide password' : 'Show password',
              ),
            ),
            onSubmitted: (_) => _handleSubmit(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  child: const Text('Sign in'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: widget.onForgotPassword,
                child: const Text('Forgot password'),
              ),
              TextButton(
                onPressed: widget.onCreateAccount,
                child: const Text('Create account'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
