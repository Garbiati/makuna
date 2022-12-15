import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makuna/components/SnackBAR.dart';
import 'package:makuna/screens/cliente.dart';
import 'package:makuna/screens/produto.dart';
import 'package:makuna/screens/start.dart';
import 'package:makuna/screens/venda.dart';
import 'dart:math';

void exibirMensagemSucesso(BuildContext context, String mensagem) {
  showSnackBAR(mensagem, context, Colors.blueAccent, Colors.black);
}

void exibirMensagemFalha(BuildContext context, String mensagem) {
  showSnackBAR(mensagem, context, Colors.red, Colors.white);
}

String validaModoTela(int? id) {
  return id! > 0 ? "E" : "N";
}

String getDataHoje() {
  return DateFormat('dd/MM/yyyy').format(DateTime.now());
}

Map<String, Widget Function(BuildContext)> obterRotas() {
  return {
    "/": (context) => const StartScreen(),
    "/produto": (context) => const ProdutoScreen(),
    "/cliente": (context) => const ClienteScreen(),
    "/venda": (context) => const VendaScreen(),
  };
}

String generateRandomString(int len) {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}

String generateOS() {
  return generateRandomString(10);
}

class MakunaSiteMap {
  final int index;
  final Icon icon;
  final String label;
  final String route;

  MakunaSiteMap(
      {required this.index,
      required this.icon,
      required this.label,
      required this.route});
}

List<MakunaSiteMap> menuIndex() {
  return [
    MakunaSiteMap(
        index: 0, icon: const Icon(Icons.home), label: "Home", route: "/"),
    MakunaSiteMap(
        index: 1,
        icon: const Icon(Icons.paid_rounded),
        label: "Vendas",
        route: "/venda"),
    MakunaSiteMap(
        index: 2,
        icon: const Icon(Icons.diamond),
        label: "Produtos",
        route: "/produto"),
    MakunaSiteMap(
        index: 3,
        icon: const Icon(Icons.contact_page),
        label: "Clientes",
        route: "/cliente"),
  ];
}
