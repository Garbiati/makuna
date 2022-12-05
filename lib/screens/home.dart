import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../components/list_home_item.dart';
import '../utils/customWidgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required String title});

  final title = const Text("Makuna");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      body: ListView(children: [
        const ListHomeItem(
            path: "images/003-clipboard.svg",
            title: "Produtos",
            subtitle: "Lista de Produtos",
            route: "/produto"),
        divisorList(),
        const ListHomeItem(
            path: "images/005-laptop.svg",
            title: "Clientes",
            subtitle: "Lista de Clientes",
            route: "/cliente"),
        divisorList(),
        const ListHomeItem(
            path: "images/006-cart.svg",
            title: "Vendas",
            subtitle: "Listar e realizar vendas",
            route: "/venda"),
        divisorList(),
      ]),
    );
  }
}
