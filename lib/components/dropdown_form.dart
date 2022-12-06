import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class DropdownForm extends StatelessWidget {
  const DropdownForm({
    super.key,
    required this.hint,
    required this.label,
    required this.source,
    required this.valKeyword,
    required this.labelKeyword,
    required this.validationMsg,
    this.selectedValue,
  });

  final String hint;
  final String label;
  final List<dynamic> source;
  final String valKeyword;
  final String labelKeyword;
  final String validationMsg;

  final dynamic selectedValue;

  @override
  Widget build(BuildContext context) {
    return FormHelper.dropDownWidgetWithLabel(
      context,
      hint,
      label,
      "",
      source,
      (onChangedVal) {},
      (onValidateVal) {
        if (onValidateVal == null) {
          return validationMsg;
        }
        return null;
      },
      borderFocusColor: Theme.of(context).primaryColor,
      borderColor: Theme.of(context).primaryColor,
      borderRadius: 10,
      optionValue: valKeyword,
      optionLabel: validationMsg,
    );
  }
}
