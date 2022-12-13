import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final title = const Text("Configurações");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: title), body: const Text("Configurações"));
  }
}
