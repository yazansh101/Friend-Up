
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/screens/home.dart';
import '../login/screens/login_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState ==
            ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (authSnapshot.hasData) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
