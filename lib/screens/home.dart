import 'package:flutter/material.dart';
import 'package:makuna/components/list_home_item.dart';
import 'package:makuna/utils/customWidgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final title = const Text("Makuna, controle de revendas.");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView(children: [
      const ListHomeItem(
          path: "images/MenuProduto.svg",
          title: "Meus produtos",
          subtitle: "Lista de Produtos",
          route: "/produto"),
      divisorList(),
      const ListHomeItem(
          path: "images/MenuCliente.svg",
          title: "Meus clientes",
          subtitle: "Lista de Clientes",
          route: "/cliente"),
      divisorList(),
      const ListHomeItem(
          path: "images/MenuVenda.svg",
          title: "Minhas Vendas",
          subtitle: "Listar e realizar vendas",
          route: "/venda"),
      divisorList(),
    ]);
  }
}
