import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final title = const Text("Perfil");
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: title), body: const Text("Perfil"));
  }
}
