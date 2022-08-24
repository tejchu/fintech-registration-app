import 'dart:ui';

import 'package:fintech_registration_app/components/customizable_dropdown_menu.dart';
import 'package:fintech_registration_app/components/customizable_text_field.dart';
import 'package:fintech_registration_app/models/majors.dart';
import 'package:fintech_registration_app/models/projects.dart';
import 'package:fintech_registration_app/screens/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/years.dart';
import '../services/download_service.dart';

class RegistrationFormPage extends StatefulWidget {
  const RegistrationFormPage({Key? key}) : super(key: key);

  @override
  State<RegistrationFormPage> createState() => _RegistrationFormPageState();
}

class _RegistrationFormPageState extends State<RegistrationFormPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  final Major = GlobalKey();
  bool? myValue = false;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users 
          .add({
            'first_name': firstName.text, // John Doe
            'last_name': lastName.text, // Stokes and Sons
            'email': email.text // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: myColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SizedBox(
          width: 600,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: [
              Image.asset(
                'assets/IBCMLOGO.png',
                height: 200,
                width: 200,
              ),
              Form(
                child: Column(
                  children: [
                    CustomizableTextField(
                      key: const Key('FirstName'),
                      labelText: 'First Name',
                      controller: firstName,
                    ),
                    CustomizableTextField(
                      key: const Key('LastName'),
                      labelText: 'Last Name',
                      controller: lastName,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomizableDropdownButton(
                      list: majors,
                      initialValue: 'Your major',
                    ),
                    CustomizableDropdownButton(
                      list: years,
                      initialValue: 'Year Of Graduation',
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('upload your cv here'),
                    ),
                    CustomizableDropdownButton(
                      list: projects,
                      initialValue: 'Project',
                    ),
                    CustomizableTextField(
                      key: const Key('Email'),
                      labelText: 'Your Jacobs Email',
                      controller: email,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Upload NDA'),
                        ),
                      ],
                    ),
                    CheckboxListTile(
                      title: Text('accept terms and conitions'),
                      value: myValue,
                      onChanged: (bool? value) {
                        setState(() {
                          myValue = value;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addUser();
                        print(firstName.text);
                        print(lastName.text);
                        print(email.text);
                      },
                      child: Text('proceed'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
