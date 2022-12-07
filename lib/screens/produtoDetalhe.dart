import 'package:flutter/material.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/customWidgets.dart';

class ProdutoDetalheScreen extends StatelessWidget {
  const ProdutoDetalheScreen({super.key, required this.produto});

  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Detalhes do produto")),
        body: Padding(
            padding: cardPadding,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(produto.id.toString()),
              Text(produto.nome),
              Text(produto.descricao),
              Text(produto.valorCompra.toString()),
              Text(produto.valorVendaPrevisao.toString()),
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
