import 'package:flutter/material.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Congratulations!! You're Logged in", 
            style: TextStyle(
              color: Colors.grey[900], 
              fontWeight: FontWeight.bold, 
              fontSize: 35),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}