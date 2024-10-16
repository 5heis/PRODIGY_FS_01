import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prodigy_fs_01/pages/home.dart';
import 'package:prodigy_fs_01/pages/login.dart';



class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user logged in
          if (snapshot.hasData) {
            return MainHomePage();
          }
          //user is NOT logged in
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
