import 'package:flutter/material.dart';
import 'package:makuna/models/cliente.dart';
import 'package:makuna/models/produto.dart';

import 'package:makuna/models/venda.dart';

import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/customWidgets.dart';

class VendaDetalheScreen extends StatelessWidget {
  const VendaDetalheScreen(
      {super.key,
      required this.venda,
      required this.cliente,
      required this.produto});

  final Venda venda;
  final Cliente cliente;
  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Resumo da Venda")),
        body: Padding(
            padding: cardPadding,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(cliente.nome),
              Text(produto.nome),
              Text(venda.valorVenda.toString()),
              Text(venda.descricao),
              Text(venda.dataVenda),
              Padding(
                  padding: cardPadding,
                  child: ElevatedButton(
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      child: voltarText))
            ])));
  }
}
