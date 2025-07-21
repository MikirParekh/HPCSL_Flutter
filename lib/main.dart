import 'package:flutter/material.dart';

import 'Sign In/UI/login.dart';// Import your LoginScreen file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      title: 'HPCSL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF0097DD),
      ),
      home: LoginScreen(), // Set LoginScreen as the home screen
    );
  }
}
