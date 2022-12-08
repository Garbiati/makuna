import 'package:brasil_fields/brasil_fields.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension RealCurrency on String {
  double convertRealCurrencyToDouble() {
    return UtilBrasilFields.converterMoedaParaDouble(
        (this).replaceAll('R\$', '').trim());
  }
}

extension RealCurrenCy on double {
  String convertDoubleToRealCurrency() {
    return UtilBrasilFields.obterReal((this));
  }
}
