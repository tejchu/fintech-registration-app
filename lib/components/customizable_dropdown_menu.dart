import 'package:fintech_registration_app/models/registrants.dart';
import 'package:flutter/material.dart';

import '../screens/registration_form_page.dart';

class CustomizableDropdownButton extends StatefulWidget {
  final List<String> list;
  final String initialValue;

  const CustomizableDropdownButton({
    Key? key,
    required this.list,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<CustomizableDropdownButton> createState() =>
      _CustomizableDropdownButtonState();
}

class _CustomizableDropdownButtonState
    extends State<CustomizableDropdownButton> {
  late String selectedMajor;
  late bool valueChanged;

  @override
  void initState() {
    super.initState();
    valueChanged = false;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == widget.initialValue || value == null) {
          return "This field is required";
        } else {
          return null;
        }
      },
      isExpanded: true,
      items: List.generate(
        widget.list.length,
        (index) => DropdownMenuItem<String>(
          value: widget.list[index],
          child: Text(widget.list[index]),
        ),
      ),
      hint: (valueChanged) ? null : Text(widget.initialValue),
      value: (valueChanged) ? selectedMajor : null,
      onChanged: (String? selection) {
        setState(() {
          valueChanged = true;
          selectedMajor = selection!;
          switch (widget.initialValue) {
            case 'Your major':
              major = selection;
              break;
            case 'Year Of Graduation':
              gradYear = selection;
              break;
            case 'Project':
              project = selection;
              break;
          }
          // print(selectedMajor);
        });
      },
    );
  }
}
