import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:makuna/components/input_email_form.dart';
import 'package:makuna/components/input_form.dart';
import 'package:makuna/utils/customStyles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final title = const Text("Perfil");
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _sobreNomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: title,
          actions: [
            IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  salvarFormulario();
                })
          ],
        ),
        body: Padding(
            padding: cardPadding,
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fieldAvatar(),
                        fieldNome(),
                        fieldSobreNome(),
                        fieldEmail(),
                        fieldUsuario(),
                        fieldSenha()
                      ]),
                ))));
  }

  Widget fieldAvatar() => Avatar(
        sources: [
          GravatarSource(_emailController.text, 300),
        ],
        name: _nomeController.text.isEmpty ? "?" : _nomeController.text,
      );

  Widget fieldNome() {
    return InputForm(
      hint: "",
      label: "Nome",
      validationMsg: "Campo nome é obrigatório",
      controller: _nomeController,
      maxLength: 50,
    );
  }

  Widget fieldSobreNome() {
    return InputForm(
      hint: "",
      label: "Sobre Nome",
      validationMsg: "Campo Sobre nome é obrigatório",
      controller: _sobreNomeController,
      maxLength: 50,
    );
  }

  Widget fieldEmail() {
    return InputEmailForm(
      hint: "email@provedor.com",
      label: "Email do cliente",
      validationMsg: "Insira o email do cliente",
      controller: _emailController,
    );
  }

  Widget fieldUsuario() {
    return InputForm(
      hint: "",
      label: "Usuario",
      validationMsg: "Campo Usuario é obrigatório",
      controller: _sobreNomeController,
      maxLength: 50,
    );
  }

  Widget fieldSenha() {
    return InputForm(
      hint: "",
      label: "Senha",
      validationMsg: "Campo Senha é obrigatório",
      controller: _sobreNomeController,
      maxLength: 50,
    );
  }

  void salvarFormulario() {}
}
