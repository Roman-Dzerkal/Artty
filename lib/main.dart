import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:artty/theme.dart';
import 'package:artty/widgets/auth_wrapper.dart';
import 'package:artty/screens/sign_in_screen.dart';
import 'package:artty/screens/sign_up_screen.dart';
import 'package:artty/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arttyshock',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const AuthWrapper(),
      routes: {
        '/sign-in': (context) => const SignInScreen(),
        '/sign-up': (context) => const SignUpScreen(),
      },
    );
  }
}
