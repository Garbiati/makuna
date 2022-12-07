import 'package:flutter/material.dart';

import 'package:makuna/utils/extension.dart';

class InputEmailForm extends StatelessWidget {
  const InputEmailForm({
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
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(hintText: hint, labelText: label),
      controller: controller,
      validator: (input) => input!.isValidEmail() ? null : "Confira seu email",
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: 150,
    );
  }
}
