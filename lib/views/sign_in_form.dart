import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  final Future<void> Function(String username, String password)? onSubmit;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onCreateAccount;

  const SignInForm({
    Key? key,
    this.onSubmit,
    this.onForgotPassword,
    this.onCreateAccount,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Tracks whether password is visible. Requirement: widget should hold `showPassword` state.
  bool _showPassword = false;

  // Form state and validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;
  // Submission state
  bool _isSubmitting = false;

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

  Future<void> _handleSubmit() async {
    if (_isSubmitting) return; // prevent duplicate submissions

    // Validate form before submitting
    final form = _formKey.currentState;
    if (form == null) return;
    if (!form.validate()) {
      // show validation errors
      setState(() {});
      return;
    }

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    setState(() => _isSubmitting = true);

    try {
      if (widget.onSubmit != null) {
        await widget.onSubmit!.call(username, password);
      }
    } catch (e) {
      // If the submit handler throws, show a basic error snackbar.
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign in failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
              enabled: !_isSubmitting,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a username';
                }
                return null;
              },
              onChanged: (_) {
                // re-evaluate form validity
                final valid = _formKey.currentState?.validate() ?? false;
                if (valid != _isFormValid) {
                  setState(() => _isFormValid = valid);
                }
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
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
              onFieldSubmitted: (_) {
                if (!_isSubmitting) _handleSubmit();
              },
              enabled: !_isSubmitting,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              onChanged: (_) {
                final valid = _formKey.currentState?.validate() ?? false;
                if (valid != _isFormValid) {
                  setState(() => _isFormValid = valid);
                }
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        (_isFormValid && !_isSubmitting) ? _handleSubmit : null,
                    child: _isSubmitting
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text('Signing in...'),
                            ],
                          )
                        : const Text('Sign in'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _isSubmitting ? null : widget.onForgotPassword,
                  child: const Text('Forgot password'),
                ),
                TextButton(
                  onPressed: _isSubmitting ? null : widget.onCreateAccount,
                  child: const Text('Create account'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
