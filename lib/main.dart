import 'package:fintech_registration_app/screens/landing_page.dart';
import 'package:fintech_registration_app/screens/registration_form_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registration: FinTech',
      home: RegistrationFormPage(),
    );
  }
}

