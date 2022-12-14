import 'package:flutter/material.dart';
import 'package:makuna/screens/cliente.dart';
import 'package:makuna/screens/config.dart';
import 'package:makuna/screens/home.dart';
import 'package:makuna/screens/produto.dart';
import 'package:makuna/screens/profile.dart';
import 'package:makuna/screens/venda.dart';
import 'package:makuna/utils/usuarioHelper.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final title = const Text("Makuna, controle de revendas.");
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: const <Widget>[
            HomeScreen(),
            ProdutoScreen(),
            ClienteScreen(),
            VendaScreen(),
            // ProfileScreen(),
            // ConfigScreen()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Página Inicial'),
            BottomNavigationBarItem(
                icon: Icon(Icons.diamond), label: 'Produtos'),
            BottomNavigationBarItem(
                icon: Icon(Icons.contacts), label: 'Clientes'),
            BottomNavigationBarItem(icon: Icon(Icons.shopify), label: 'Vendas'),
            // BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.settings), label: 'Configurações'),
          ],
        ));
  }
}
