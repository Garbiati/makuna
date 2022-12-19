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

extension DateTimeFormat on String {
  DateTime convertToDateTime() {
    final String dia = substring(0, 2);
    final String mes = substring(3, 5);
    final String ano = substring(6);
    final String formatedDate = "$ano$mes$dia";
    return DateTime.parse(formatedDate);
  }
}

extension RealCurrenCy on double {
  String convertDoubleToRealCurrency(bool simbolo) {
    if (!simbolo) return (this).obterRealSemSimbolo();

    return UtilBrasilFields.obterReal((this));
  }
}
