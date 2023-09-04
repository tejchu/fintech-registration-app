import 'package:fintech_registration_app/models/registrants.dart';
import 'package:fintech_registration_app/screens/registration_form_page.dart';
import 'package:flutter/material.dart';
import '../services/download_service.dart';

Color myColor = const Color.fromARGB(255, 31, 32, 61);
Color myButtonColor = const Color.fromARGB(255, 150, 159, 170);

class SuccessfulRegistrationPage extends StatefulWidget {
  const SuccessfulRegistrationPage({Key? key}) : super(key: key);

  @override
  State<SuccessfulRegistrationPage> createState() =>
      _SuccessfulRegistrationPageState();
}

class _SuccessfulRegistrationPageState
    extends State<SuccessfulRegistrationPage> {
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailPrefix = TextEditingController();
    String emailSuffix = '@constructor.university';
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/IBCMLOGO.png',
              height: 200,
              width: 200,
            ),
            const SizedBox(
              width: 700,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Text(
                  'Your application has been successfully submitted!',
                  style: TextStyle(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              width: 700,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Text(
                  'Thank you for registering, we will get back to you as soon as possible!',
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


