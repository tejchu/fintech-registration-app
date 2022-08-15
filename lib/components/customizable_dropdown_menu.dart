import 'package:fintech_registration_app/models/majors.dart';
import 'package:flutter/material.dart';

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
    return DropdownButton(
      isExpanded: true,
      items: List.generate(
        widget.list.length,
        (index) => DropdownMenuItem<String>(
          value: widget.list[index],
          child: Text(widget.list[index]),
        ),
      ),
      hint: Text((valueChanged) ? selectedMajor : widget.initialValue),
      onChanged: (String? selection) {
        setState(() {
          valueChanged = true;
          selectedMajor = selection!;
          print(selectedMajor);
        });
      },
    );
  }
}
