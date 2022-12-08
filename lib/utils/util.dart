import 'package:flutter/material.dart';
import 'package:makuna/components/SnackBAR.dart';

void exibirMensagemSucesso(BuildContext context, String mensagem) {
  showSnackBAR(mensagem, context, Colors.blueAccent, Colors.black);
}

void exibirMensagemFalha(BuildContext context, String mensagem) {
  showSnackBAR(mensagem, context, Colors.red, Colors.white);
}

String validaModoTela(int? id) {
  return id! > 0 ? "E" : "N";
}
