import 'package:fintech_registration_app/components/customizable_text_field.dart';
import 'package:fintech_registration_app/screens/landing_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universal_html/html.dart';
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

  final GlobalKey<FormState> _formFieldKey = GlobalKey<FormState>();
  ValueKey<bool> checkKey = ValueKey(false);
  File? pickedCV;
  bool submittedCV = false;
  File? pickedNDA;
  bool submittedNDA = false;

  void selectCV() {
    FileUploadInputElement selectInput = FileUploadInputElement()
      ..accept = 'pdf/*';
    selectInput.click();

    selectInput.onChange.listen((event) {
      final file = selectInput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      setState(() {
        pickedCV = file;
        submittedCV = true;
      });
    });
  }

  void selectNDA() {
    FileUploadInputElement selectInput = FileUploadInputElement()
      ..accept = 'pdf/*';
    selectInput.click();

    selectInput.onChange.listen((event) {
      final file = selectInput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      setState(() {
        pickedNDA = file;
        submittedNDA = true;
      });
    });
  }

  void uploadFile(pathName, selectedFile) {
    final path = pathName;
    print(selectedFile);
    FirebaseStorage.instance
        .refFromURL('gs://fintech-registration-app.appspot.com/')
        .child(path)
        .putBlob(selectedFile);
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
                    // SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: selectCV,
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
                                      Icon(Icons.upload),
                                      Text('Upload your CV'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Checkbox(
                          activeColor: Colors.black,
                          value: submittedCV,
                          onChanged: (value) => false,
                        ),
                        CloseButton(
                          color: Colors.black,
                          onPressed: () {
                            setState(() {
                              submittedCV = false;
                              pickedCV = null;
                            });
                          },
                        ),
                      ],
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
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
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
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: selectNDA,
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
                                      Icon(Icons.upload),
                                      Text('Upload NDA'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Checkbox(
                          activeColor: Colors.black,
                          value: submittedNDA,
                          onChanged: (value) => false,
                        ),
                        CloseButton(
                          color: Colors.black,
                          onPressed: () {
                            setState(() {
                              submittedNDA = false;
                              pickedNDA = null;
                            });
                          },
                        ),
                      ],
                    ),
                    CheckboxListTile(
                      title: Text(
                        'accept terms and conitions',
                        style: TextStyle(
                            color: (myValue!) ? myColor : Colors.redAccent),
                      ),
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
                        if (_formFieldKey.currentState!.validate() &&
                            myValue! &&
                            submittedCV) {
                          print("object");
                          addUser();
                          uploadFile('CVs/${firstName.text}${lastName.text}',
                              pickedCV);
                          uploadFile('NDAs/${firstName.text}${lastName.text}',
                              pickedNDA);
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
