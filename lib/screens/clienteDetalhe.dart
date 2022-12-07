import 'package:flutter/material.dart';
import 'package:makuna/models/cliente.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/customWidgets.dart';

class ClienteDetalheScreen extends StatelessWidget {
  const ClienteDetalheScreen({super.key, required this.cliente});
  final Cliente cliente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Detalhes do cliente")),
        body: Padding(
            padding: cardPadding,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(cliente.id.toString()),
              Text(cliente.nome),
              Text(cliente.telefone),
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
