import 'package:flutter/material.dart';

class AuthGradientHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const AuthGradientHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scheme.primaryContainer,
            scheme.inversePrimary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Artty', style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: scheme.onPrimaryContainer)),
          const SizedBox(height: 4),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onPrimaryContainer.withValues(alpha: 0.8))),
        ],
      ),
    );
  }
}

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final bool obscure;
  final String? Function(String?)? validator;
  final VoidCallback? onToggleObscure;
  const AuthTextField({super.key, required this.controller, required this.hintText, required this.icon, this.keyboardType = TextInputType.text, this.obscure = false, this.validator, this.onToggleObscure});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.blue),
        suffixIcon: onToggleObscure == null
            ? null
            : IconButton(
                icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: Colors.orange),
                onPressed: onToggleObscure,
              ),
        filled: true,
        fillColor: scheme.primaryContainer.withValues(alpha: 0.3),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: scheme.primary.withValues(alpha: 0.2))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: scheme.primary)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: scheme.primary.withValues(alpha: 0.2))),
      ),
    );
  }
}

class AuthPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const AuthPrimaryButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        child: Text(label),
      ),
    );
  }
}

class AuthSecondaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;
  const AuthSecondaryButton({super.key, required this.label, required this.icon, required this.iconColor, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        icon: Icon(icon, color: iconColor),
        label: Text(label),
      ),
    );
  }
}
