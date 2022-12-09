import 'package:flutter/material.dart';
import 'package:makuna/screens/cliente.dart';
import 'package:makuna/screens/produto.dart';
import 'package:makuna/screens/home.dart';
import 'package:makuna/screens/venda.dart';
import 'package:makuna/utils/util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Makuna',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: "/",
      routes: obterRotas(),
    );
  }
}
