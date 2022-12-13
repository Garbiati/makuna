import 'package:flutter/material.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Makuna',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: "/",
      routes: obterRotas(),
    );
  }
}
