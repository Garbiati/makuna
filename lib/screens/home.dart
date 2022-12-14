import 'package:flutter/material.dart';
import 'package:makuna/components/cardHome.dart';

import 'package:makuna/utils/usuarioHelper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final title = const Text("Makuna");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    String saudacao = "Olá: ${GetUsuario(usuarioId).nome}";

    return Column(children: <Widget>[
      Text(
        saudacao,
        style: const TextStyle(fontSize: 48),
      ),
      const Spacer(),
      const CardHomeWidget(
          titulo: "Vendas",
          desc1: "Total de vendas no mês: R\$ 25.000,00",
          desc2: "Total de lucro no mês: R\$ 5.000,00"),
      const Spacer(),
      const CardHomeWidget(
          titulo: "Inventário",
          desc1: "Total em produtos: R\$ 40.000,00",
          desc2: "Produto mais lucrativo: iPhone 14"),
      const Spacer(),
      const CardHomeWidget(
          titulo: "Clientes",
          desc1: "O que mais compra: João das Neves",
          desc2: "O que menos compra: Maria da Terra"),
      const Spacer(),
      const CardHomeWidget(
          titulo: "Previsão e médias",
          desc1: "Lucro estimado:  R\$ 8.000,00",
          desc2: "Valor médio mensal: R\$ 5.000,00"),
      const Spacer(),
    ]);
  }
}
