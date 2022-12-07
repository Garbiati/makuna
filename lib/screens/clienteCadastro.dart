import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:makuna/components/SnackBAR.dart';
import 'package:makuna/components/input_form.dart';
import 'package:makuna/daos/cliente_dao.dart';
import 'package:makuna/models/cliente.dart';
import 'package:makuna/utils/customStyles.dart';
import '../components/input_email_form.dart';

class ClienteCadastroScreen extends StatefulWidget {
  const ClienteCadastroScreen({super.key, required this.cliente});

  final Cliente cliente;

  @override
  State<ClienteCadastroScreen> createState() => _ClienteCadastroScreenState();
}

class _ClienteCadastroScreenState extends State<ClienteCadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();

// N= Novo E = Editando
  String modoTela = '';
  String tituloTela = '';

  @override
  Widget build(BuildContext context) {
    checkModoTela();
    configuraTitulo();
    preencherCampos();

    return Scaffold(
        appBar: AppBar(
          title: Text(tituloTela),
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldAvatar(),
                      fieldNome(),
                      fieldTelefone(),
                      fieldEmail(),
                    ]))));
  }

//Fields
  Widget fieldAvatar() => Avatar(
        sources: [
          GravatarSource(_emailController.text, 300),
        ],
        name: _nomeController.text.isEmpty ? "?" : _nomeController.text,
      );

  Widget fieldNome() {
    return InputForm(
      hint: "Ex.: João Augusto da Silva",
      label: "Nome do cliente",
      validationMsg: "Insira o nome do cliente",
      controller: _nomeController,
      maxLength: 50,
    );
  }

  Widget fieldTelefone() {
    return InputForm(
      hint: "(99) 9 9999-999",
      label: "Telefone do cliente",
      validationMsg: "Insira o telefone do cliente",
      controller: _telefoneController,
      customMask: '(##) # ####-####',
      tipoImput: TextInputType.phone,
      maxLength: 16,
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

//Telas e validações
  void checkModoTela() {
    widget.cliente.id! > 0 ? modoTela = "E" : modoTela = "N";
  }
  
  void configuraTitulo() {
    modoTela == "N"
        ? tituloTela = "Novo cadastro de cliente"
        : tituloTela = "Atualizar dados cliente";
  }

  void preencherCampos() {
    if (modoTela == "E") {
      _nomeController.text = widget.cliente.nome;
      _telefoneController.text = widget.cliente.telefone;
      _emailController.text = widget.cliente.email!;
    }
  }

//Persistencias
  void salvarFormulario() {
    if (_formKey.currentState!.validate()) {
      try {
        if (modoTela == "N") {
          Cliente cliente = Cliente(
              nome: _nomeController.text,
              telefone: _telefoneController.text,
              email: _emailController.text,
              urlAvatar: "",
              dataCadastro: DateTime.now().toString());

          insertCliente(cliente);

          showSnackBAR("Cliente cadastrado com sucesso.", context,
              Colors.lightBlue, Colors.black);
          Navigator.pop(context);
        } else if (modoTela == "E") {
          showSnackBAR("Cliente atualizado com sucesso.", context,
              Colors.lightBlue, Colors.black);
          setState(() {});
        }
      } catch (e) {
        showSnackBAR(
            "Erro ao salvar as informações", context, Colors.red, Colors.white);
      }
    }
  }

  insertCliente(Cliente cliente) async {
    int id = await ClienteDAO().insertCliente(cliente);
    setState(() {
      cliente.id = id;
    });
  }
}
