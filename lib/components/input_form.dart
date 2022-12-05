import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  const InputForm({
    super.key,
    required this.hint,
    required this.label,
    required this.validationMsg,
    required this.controller,
    });
    
  final String hint;
  final String label;
  final String validationMsg;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(hintText: hint, labelText: label),
        controller: controller,
        validator: ((value) {
          if (value == null || value.isEmpty) {
            return validationMsg;
          }
          return null;
        }));
  }
}
