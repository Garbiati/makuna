import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makuna/components/SnackBAR.dart';
import 'package:makuna/daos/cliente_dao.dart';
import 'package:makuna/daos/produto_dao.dart';
import 'package:makuna/models/cliente.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/screens/cliente.dart';
import 'package:makuna/screens/produto.dart';
import 'package:makuna/screens/start.dart';
import 'package:makuna/screens/venda.dart';
import 'dart:math';

import 'package:makuna/utils/usuarioHelper.dart';

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

//DEV

somenteDevModeInserirClientes() async {
  List<Cliente> clientes = [];

  clientes = await ClienteDAO().readAll();

  if (clientes.isEmpty) {
    ClienteDAO().insertCliente(Cliente(
        usuarioId: usuarioId,
        nome: "Alessandro Henrique Garbiati",
        telefone: "(11) 9 9999-9999",
        email: "a.garbiati@gmail.com",
        urlAvatar: "",
        dataCadastro: getDataHoje(),
        ativo: 1));

    ClienteDAO().insertCliente(Cliente(
        usuarioId: usuarioId,
        nome: "Diogo Silva",
        telefone: "(11) 9 9999-9999",
        email: "rm346597@fiap.com.br",
        urlAvatar: "",
        dataCadastro: getDataHoje(),
        ativo: 1));
    ClienteDAO().insertCliente(Cliente(
        usuarioId: usuarioId,
        nome: "Laura Deperon Ribeiro",
        telefone: "(11) 9 9999-9999",
        email: "rm347232@fiap.com.br",
        urlAvatar: "",
        dataCadastro: getDataHoje(),
        ativo: 1));
    ClienteDAO().insertCliente(Cliente(
        usuarioId: usuarioId,
        nome: "Magno Belloni de Souza",
        telefone: "(11) 9 9999-9999",
        email: "rm346800@fiap.com.br",
        urlAvatar: "",
        dataCadastro: getDataHoje(),
        ativo: 1));
    ClienteDAO().insertCliente(Cliente(
        usuarioId: usuarioId,
        nome: "Thiago Barbosa de Souza",
        telefone: "(11) 9 9999-9999",
        email: "rm346728@fiap.com.br",
        urlAvatar: "",
        dataCadastro: getDataHoje(),
        ativo: 1));
  }
}

somenteDevModeInserirProdutos() async {
  List<Produto> produtos = [];

  produtos = await ProdutoDAO().readAll();

  if (produtos.isEmpty) {
    ProdutoDAO().insertProduto(Produto(
        usuarioId: usuarioId,
        codigoProduto: "",
        nome: "iPhone 14 Pro Max",
        descricao: "Preto de 500 GB",
        valorCompra: 7500,
        valorVendaPrevisao: 10000,
        quantidade: 8,
        dataCompra: getDataHoje(),
        ativo: 1));

    ProdutoDAO().insertProduto(Produto(
        usuarioId: usuarioId,
        codigoProduto: "",
        nome: "RTX 4090",
        descricao: "32 GB",
        valorCompra: 25000,
        valorVendaPrevisao: 28000,
        quantidade: 3,
        dataCompra: getDataHoje(),
        ativo: 1));

    ProdutoDAO().insertProduto(Produto(
        usuarioId: usuarioId,
        codigoProduto: "",
        nome: "CPU Core i9 ",
        descricao: "12900K 3.2 GHz",
        valorCompra: 2200,
        valorVendaPrevisao: 2800,
        quantidade: 5,
        dataCompra: getDataHoje(),
        ativo: 1));

    ProdutoDAO().insertProduto(Produto(
        usuarioId: usuarioId,
        codigoProduto: "",
        nome: "Memória Kingston 16GB",
        descricao: "DDR5, 5200MHZ",
        valorCompra: 400,
        valorVendaPrevisao: 800,
        quantidade: 5,
        dataCompra: getDataHoje(),
        ativo: 1));

    ProdutoDAO().insertProduto(Produto(
        usuarioId: usuarioId,
        codigoProduto: "",
        nome: "SSD Kingston 480 GB",
        descricao: "A400",
        valorCompra: 80,
        valorVendaPrevisao: 230,
        quantidade: 5,
        dataCompra: getDataHoje(),
        ativo: 1));
  }
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
