import 'package:flutter/material.dart';

class OperacaoRealizadaScreen extends StatelessWidget {
  const OperacaoRealizadaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var s = const TextStyle(fontSize: 32);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sucesso",
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(children: [
        Text("Operação realizada com sucesso!",
            textAlign: TextAlign.center, style: s),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Voltar")),
      ]),
    );
  }
}
