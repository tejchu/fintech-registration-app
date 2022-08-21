import 'package:fintech_registration_app/components/customizable_text_field.dart';
import 'package:fintech_registration_app/screens/landing_page.dart';
import 'package:flutter/material.dart';
import '../components/customizable_dropdown_menu.dart';
import '../models/majors.dart';
import '../models/projects.dart';
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
  final GlobalKey<FormState> _formFieldKey = GlobalKey<FormState>();
  ValueKey<bool> checkKey = ValueKey(false);

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
                key: _formFieldKey,
                child: Column(
                  children: [
                    CustomizableTextField(
                      labelText: 'First Name',
                      controller: firstName,
                      onEditingComplete: () {
                        //formFieldKey.currentState!.validate();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    CustomizableTextField(
                      labelText: 'Last Name',
                      controller: lastName,
                      onEditingComplete: () {
                        //formFieldKey.currentState!.validate();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      labelText: 'Your Jacobs Email',
                      controller: email,
                      onEditingComplete: () {
                       // formFieldKey.currentState!.validate();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        } else if (!value.endsWith('@jacobs-university.de')) {
                          return "Please enter a valid Jacobs University email address";
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      title: Text('accept terms and conitions',style: TextStyle(color: (myValue!)?myColor:Colors.redAccent),),
                      value: myValue,
                      activeColor: myColor,
                      tileColor: Colors.black12,
                      onChanged: (bool? value) {
                        setState(() {
                          myValue = value;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formFieldKey.currentState!.validate() && myValue!) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LandingPage(),
                            ),
                          );
                        }
                      },
                      child: Text('proceed'),
                    ),
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