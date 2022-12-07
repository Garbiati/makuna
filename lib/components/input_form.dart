import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputForm extends StatelessWidget {
  const InputForm({
    super.key,
    required this.hint,
    required this.label,
    required this.validationMsg,
    required this.controller,
    this.customMask,
    this.tipoImput,
    this.maxLength,
  });

  final String hint;
  final String label;
  final String validationMsg;
  final TextEditingController controller;
  final TextInputType? tipoImput;
  final String? customMask;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    var mask = MaskTextInputFormatter(mask: customMask);

    return TextFormField(
        inputFormatters: [mask],
        keyboardType: tipoImput,
        maxLength: maxLength,
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
