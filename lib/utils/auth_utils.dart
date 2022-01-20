import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:godartadmin/views/home_view.dart';
import 'package:godartadmin/views/login/login_view.dart';

class AuthView extends StatelessWidget {
  AuthView({Key? key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.active) {
          return const HomeView();
        } else {
          return const LoginView();
        }
      },
    );
  }
}
