import 'package:fintech_registration_app/components/customizable_text_field.dart';
import 'package:fintech_registration_app/models/project.dart';
import 'package:fintech_registration_app/screens/successful_registration_page.dart';
import 'package:fintech_registration_app/services/file_uploader_service.dart';
import 'package:fintech_registration_app/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';
import '../components/customizable_dropdown_menu.dart';
import '../models/majors.dart';
import '../models/years.dart';
import '../services/download_service.dart';

//Todo create map with data to put in firebase

String major = '';
String gradYear = '';
String project = '';

class RegistrationFormPage extends StatefulWidget {
  const RegistrationFormPage({Key? key}) : super(key: key);

  @override
  State<RegistrationFormPage> createState() => _RegistrationFormPageState();
}

class _RegistrationFormPageState extends State<RegistrationFormPage> {
  final GlobalKey<FormState> _formFieldKey = GlobalKey<FormState>();

  //text field value geters
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();

  //logic variables for validation
  bool? myValue = false;
  bool submittedCV = false;
  bool submittedNDA = false;
  bool downloadedNDA = false;
  File? pickedCV;
  File? pickedNDA;

  //select files
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
                      validator: (value) =>
                      (value == null || value.isEmpty)
                          ? "This field is required"
                          : null,
                    ),
                    CustomizableTextField(
                      labelText: 'Last Name',
                      controller: lastName,
                      validator: (value) =>
                      (value == null || value.isEmpty)
                          ? "This field is required"
                          : null,
                    ),
                    CustomizableDropdownButton(
                      list: majors,
                      initialValue: 'Your major',
                    ),
                    CustomizableDropdownButton(
                      list: years,
                      initialValue: 'Year Of Graduation',
                    ),
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
                                    children: [
                                      (submittedCV)
                                          ? Checkbox(
                                        activeColor: Colors.transparent,
                                        value: submittedCV,
                                        onChanged: (value) => false,
                                      )
                                          : const Icon(Icons.upload),
                                      Text(
                                        (!submittedCV)
                                            ? 'Upload your CV'
                                            : 'CV uploaded',
                                        style: TextStyle(
                                            color: (submittedCV)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        (submittedCV)
                            ? CloseButton(
                          color: Colors.black54,
                          onPressed: () =>
                              setState(() {
                                submittedCV = false;
                                pickedCV = null;
                              }),
                        )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    CustomizableDropdownButton(
                      list: projects,
                      initialValue: 'Project',
                    ),
                    CustomizableTextField(
                      labelText: 'Your Constructor Email',
                      controller: email,
                      validator: (value) =>
                      (value == null || value.isEmpty)
                          ? "This field is required"
                          : (!value.endsWith('@constructor.university') &&
                          value.length < 22)
                          ? "Please enter a valid Constructor University email address"
                          : null,
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
                                setState(() {
                                  downloadedNDA = true;
                                });
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
                                      children: [
                                        (downloadedNDA)
                                            ? Checkbox(
                                          activeColor: Colors.transparent,
                                          value: downloadedNDA,
                                          onChanged: (value) => false,
                                        )
                                            : const Icon(Icons.download),
                                        Text(
                                          'Download NDA',
                                          style: TextStyle(
                                              color: (downloadedNDA)
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
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
                                    children: [
                                      (submittedNDA)
                                          ? Checkbox(
                                        activeColor: Colors.transparent,
                                        value: submittedNDA,
                                        onChanged: (value) => false,
                                      )
                                          : const Icon(Icons.upload),
                                      Text(
                                        (!submittedNDA)
                                            ? 'Upload NDA'
                                            : 'NDA uploaded',
                                        style: TextStyle(
                                            color: (submittedNDA)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        (submittedNDA)
                            ? CloseButton(
                          color: Colors.black54,
                          onPressed: () {
                            setState(() {
                              submittedNDA = false;
                              pickedNDA = null;
                            });
                          },
                        )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    CheckboxListTile(
                      title: Text(
                        'accept terms and conitions',
                        style: TextStyle(
                            color: (myValue!) ? myColor : Colors.redAccent),
                      ),
                      value: myValue,
                      activeColor: Colors.transparent,
                      tileColor: Colors.black12,
                      onChanged: (bool? value) {
                        setState(() {
                          myValue = value;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            if (_formFieldKey.currentState!.validate() &&
                                myValue! &&
                                submittedCV) {
                              //add major,project,gradYear to firebase
                              FirebaseService().addUser({
                                'first_name': firstName.text, // John Doe
                                'last_name': lastName.text, // Stokes and Sons
                                'email': email.text, // 42
                              });
                              FileUploaderService.uploadFile(
                                  'CVs/${firstName.text}${lastName.text}',
                                  pickedCV);
                              FileUploaderService.uploadFile(
                                  'NDAs/${firstName.text}${lastName.text}',
                                  pickedNDA);

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const SuccessfulRegistrationPage(),
                                ),
                              );
                            }
                          },
                          child: SizedBox(
                            width: 200,
                            height: 50,
                            child: Card(
                              color: myButtonColor,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(child: Text('Submit')),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      '*Keep in mind that every person can only register once!',
                      style: TextStyle(fontSize: 10),
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
