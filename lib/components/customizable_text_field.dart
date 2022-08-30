import 'package:flutter/material.dart';

class CustomizableTextField extends StatelessWidget {
  final String? initialValue;
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomizableTextField(
      {Key? key,
      this.initialValue,
      required this.labelText,
      required this.controller,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: key,
      controller: controller,
      initialValue: initialValue,
      textCapitalization: TextCapitalization.words,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}
