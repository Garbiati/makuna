import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:intl/intl.dart';

class InputDataForm extends StatelessWidget {
  const InputDataForm({
    super.key,
    required this.hint,
    required this.label,
    required this.validationMsg,
    required this.controller,
    this.enabled,
  });

  final String hint;
  final String label;
  final String validationMsg;
  final TextEditingController controller;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          DataInputFormatter()
        ],
        maxLength: 10,
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(hintText: hint, labelText: label),
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enabled: enabled,
        validator: ((value) {
          if (value == null || value.isEmpty) {
            return validationMsg;
          }

          try {
            UtilData.obterDateTime(value);
          } catch (e) {
            return "Formato de data inválida";
          }
          return null;
        }));
  }
}

class InputRealForm extends StatelessWidget {
  const InputRealForm({
    super.key,
    required this.hint,
    required this.label,
    required this.validationMsg,
    required this.controller,
    this.enabled,
  });

  final String hint;
  final String label;
  final String validationMsg;
  final TextEditingController controller;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          CurrencyInputFormatter()
        ],
        maxLength: 17,
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(hintText: hint, labelText: label),
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enabled: enabled,
        validator: ((value) {
          if (value == null || value.isEmpty) {
            return validationMsg;
          }
          return null;
        }));
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
