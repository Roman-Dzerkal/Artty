import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:artty/firestore/auth_service.dart';
import 'package:artty/screens/home_shell.dart';
import 'package:artty/screens/sign_in_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _LoadingScreen();
        }
        
        if (snapshot.hasData && snapshot.data != null) {
          // User is signed in
          return const HomeShell();
        } else {
          // User is not signed in
          return const SignInScreen();
        }
      },
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (rect) => LinearGradient(
                colors: [scheme.primary, scheme.inversePrimary],
              ).createShader(rect),
              child: Text(
                'Artty',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(scheme.primary),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading...',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: scheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}