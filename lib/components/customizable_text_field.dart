import 'package:flutter/material.dart';

class CustomizableTextField extends StatelessWidget {
  final String? initialValue;
  final String labelText;
  late TextEditingController controller;

  CustomizableTextField(
      {Key? key, this.initialValue, required this.labelText, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}
