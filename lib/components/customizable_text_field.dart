import 'package:flutter/material.dart';

class CustomizableTextField extends StatelessWidget {
  final String? initialValue;
  final String labelText;
  late TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final AutovalidateMode autovalidateMode;

  CustomizableTextField(
      {Key? key,
      this.initialValue,
      required this.labelText,
      required this.controller,
      required this.validator, required this.onEditingComplete, required this.autovalidateMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      key: key,
      controller: controller,
      initialValue: initialValue,
      textCapitalization: TextCapitalization.words,
      validator: validator,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}
