import 'package:flutter/material.dart';
import 'package:artty/widgets/auth_widgets.dart';
import 'package:artty/screens/home_shell.dart';
import 'package:artty/screens/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;
  bool _agree = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  String? _validateName(String? v) => (v != null && v.trim().length >= 2) ? null : 'Enter your name';
  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Enter your email';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : 'Enter a valid email';
  }

  String? _validatePassword(String? v) => (v != null && v.length >= 6) ? null : 'Min 6 characters';

  String? _validateConfirm(String? v) => v == _password.text ? null : 'Passwords do not match';

  void _submit() {
    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please agree to the terms')));
      return;
    }
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeShell()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AuthGradientHeader(title: 'Create your account', subtitle: 'Join the community of artists and makers'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20), boxShadow: [
                          BoxShadow(color: scheme.shadow.withValues(alpha: 0.06), blurRadius: 18, offset: const Offset(0, 8)),
                        ]),
                        child: Column(children: [
                          AuthTextField(controller: _name, hintText: 'Name', icon: Icons.person_outline, validator: _validateName),
                          const SizedBox(height: 12),
                          AuthTextField(controller: _email, hintText: 'Email', icon: Icons.mail_outline, keyboardType: TextInputType.emailAddress, validator: _validateEmail),
                          const SizedBox(height: 12),
                          AuthTextField(controller: _password, hintText: 'Password', icon: Icons.lock_outline, obscure: _obscure1, validator: _validatePassword, onToggleObscure: () => setState(() => _obscure1 = !_obscure1)),
                          const SizedBox(height: 12),
                          AuthTextField(controller: _confirm, hintText: 'Confirm password', icon: Icons.lock_outline, obscure: _obscure2, validator: _validateConfirm, onToggleObscure: () => setState(() => _obscure2 = !_obscure2)),
                          const SizedBox(height: 8),
                          Row(children: [
                            Checkbox(value: _agree, onChanged: (v) => setState(() => _agree = v ?? false)),
                            Expanded(child: Text('I agree to the Terms & Privacy Policy', style: Theme.of(context).textTheme.bodyMedium)),
                          ]),
                          const SizedBox(height: 4),
                          AuthPrimaryButton(label: 'Create account', onPressed: _submit),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      Row(children: [
                        Expanded(child: Divider(color: scheme.outline.withValues(alpha: 0.3))),
                        const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('or sign up with')),
                        Expanded(child: Divider(color: scheme.outline.withValues(alpha: 0.3))),
                      ]),
                      const SizedBox(height: 12),
                      AuthSecondaryButton(label: 'Sign up with Apple', icon: Icons.apple, iconColor: Colors.black, onPressed: () {}),
                      const SizedBox(height: 10),
                      AuthSecondaryButton(label: 'Sign up with Google', icon: Icons.android, iconColor: Colors.green, onPressed: () {}),
                      const SizedBox(height: 24),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        const Text('Already have an account?'),
                        TextButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SignInScreen())), child: const Text('Sign in')),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
