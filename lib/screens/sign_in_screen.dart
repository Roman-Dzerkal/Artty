import 'package:flutter/material.dart';
import 'package:artty/widgets/auth_widgets.dart';
import 'package:artty/screens/sign_up_screen.dart';
import 'package:artty/firestore/auth_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Enter your email';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : 'Enter a valid email';
  }

  String? _validatePassword(String? v) => (v != null && v.length >= 6) ? null : 'Min 6 characters';

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    
    setState(() => _loading = true);
    
    try {
      await AuthService.signIn(
        email: _email.text.trim(),
        password: _password.text,
      );
      // Auth wrapper will handle navigation
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AuthGradientHeader(title: 'Welcome back', subtitle: 'Sign in to continue your creative journey'),
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
                          AuthTextField(controller: _email, hintText: 'Email', icon: Icons.mail_outline, keyboardType: TextInputType.emailAddress, validator: _validateEmail),
                          const SizedBox(height: 12),
                          AuthTextField(controller: _password, hintText: 'Password', icon: Icons.lock_outline, obscure: _obscure, validator: _validatePassword, onToggleObscure: () => setState(() => _obscure = !_obscure)),
                          const SizedBox(height: 4),
                          Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () {}, child: const Text('Forgot password?'))),
                          const SizedBox(height: 4),
                          AuthPrimaryButton(
                            label: _loading ? 'Signing in...' : 'Sign in',
                            onPressed: _loading ? null : () async => _submit(),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      Row(children: [
                        Expanded(child: Divider(color: scheme.outline.withValues(alpha: 0.3))),
                        const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('or continue with')),
                        Expanded(child: Divider(color: scheme.outline.withValues(alpha: 0.3))),
                      ]),
                      const SizedBox(height: 12),
                      AuthSecondaryButton(label: 'Continue with Apple', icon: Icons.apple, iconColor: Colors.black, onPressed: () {}),
                      const SizedBox(height: 10),
                      AuthSecondaryButton(label: 'Continue with Google', icon: Icons.android, iconColor: Colors.green, onPressed: () {}),
                      const SizedBox(height: 24),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        const Text("Don't have an account?"),
                        TextButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SignUpScreen())), child: const Text('Sign up')),
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
