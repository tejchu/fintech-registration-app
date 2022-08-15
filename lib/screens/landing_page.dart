import 'package:fintech_registration_app/models/registrants.dart';
import 'package:fintech_registration_app/screens/registration_form_page.dart';
import 'package:flutter/material.dart';
import '../services/download_service.dart';

Color myColor = const Color.fromARGB(255, 31, 32, 61);
Color myButtonColor = const Color.fromARGB(255, 150, 159, 170);

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailPrefix = TextEditingController();
    String emailSuffix = '@jacobs_university.de';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: myColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          clipBehavior: Clip.antiAliasWithSaveLayer,
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
                    'Welcome to the official registration page, '
                        'in order for you to be eligible to register you need to '
                        'download and sign the Non Disclosure Agreement below.',
                    style: TextStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: 500,
                  child: TextFormField(
                    key: _registerFormKey,
                    controller: emailPrefix,
                    onChanged: (value) {
                      if (validateEmail(emailPrefix.text) != 'success') {
                        const InputDecoration(
                          errorText: 'Invalid email address'
                        );
                    };
                    },
                    decoration: InputDecoration(
                        label: Text('Email'),

                        //,
                        suffixText: emailSuffix),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        downloadFile('assets/Blank_NDA.pdf');
                      },
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: Card(
                          color: myButtonColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Icon(Icons.download),
                                Text('Download NDA'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        if (validateEmail(emailPrefix.text) == 'success') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                              const RegistrationFormPage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Invalid email address')));
                        }
                      },
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: Card(
                          color: myButtonColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Icon(Icons.navigate_next),
                                Text('Proceed to Form'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String validateEmail(String emailPrefix) {
  if (emailPrefix == null ||
      emailPrefix == '' ||
      emails.contains(emailPrefix)) {
    return 'invalid email address';
  } else {
    return 'success';
  }
}
