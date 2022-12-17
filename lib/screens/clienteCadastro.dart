import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:makuna/components/input_form.dart';
import 'package:makuna/daos/cliente_dao.dart';
import 'package:makuna/models/cliente.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/usuarioHelper.dart';
import 'package:makuna/utils/util.dart';
import '../components/input_email_form.dart';
import 'package:masked_text/masked_text.dart';

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
  final _enderecoController = TextEditingController();
  final _numeroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cepController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();

// N= Novo E = Editando
  String modoTela = '';
  String tituloTela = '';

  @override
  Widget build(BuildContext context) {
    modoTela = validaModoTela(widget.cliente.id);
    configuraTitulo();
    preencherCampos();

    return Scaffold(
        appBar: AppBar(
          title: Text(tituloTela),
          actions: [
            IconButton(
                icon: const Icon(Icons.save),
                iconSize: 38,
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
                        fieldTelefone(),
                        fieldEmail(),
                        fieldEndereco(),
                        fieldNumero(),
                        fieldBairro(),
                        fieldCep(),
                        fieldCidade(),
                        fieldEstado(),
                      ]),
                ))));
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

  Widget fieldEndereco() {
    return TextField(
      decoration: InputDecoration(labelText: 'Endereço do cliente'),
      controller: _enderecoController,
      maxLength: 255,
    );
  }

  Widget fieldNumero() {
    return TextField(
      decoration: InputDecoration(labelText: 'Numero do endereço do cliente'),
      keyboardType: TextInputType.number,
      controller: _numeroController,
      maxLength: 10,
    );
  }

  Widget fieldBairro() {
    return TextField(
      decoration: InputDecoration(labelText: 'Bairro do cliente'),
      controller: _bairroController,
      maxLength: 255,
    );
  }

  Widget fieldCep() {
    return MaskedTextField(
      decoration: InputDecoration(labelText: 'Cep do cliente'),
      controller: _cepController,
      keyboardType: TextInputType.number,
      mask: '#####-###',
      maxLength: 9,
    );
  }

  Widget fieldCidade() {
    return TextField(
      decoration: InputDecoration(labelText: 'Cidade do cliente'),
      controller: _cidadeController,
      maxLength: 150,
    );
  }

  Widget fieldEstado() {
    return TextField(
      controller: _estadoController,
      decoration: InputDecoration(labelText: 'Estado do Cliente'),
      maxLength: 50,
    );
  }

//Telas e validações
  void configuraTitulo() {
    modoTela == "N"
        ? tituloTela = "Novo cadastro de cliente"
        : tituloTela = "Atualizar dados cliente";
  }

  void preencherCampos() {
    if (modoTela == "E") {
      _nomeController.text = widget.cliente.nome;
      _telefoneController.text = widget.cliente.telefone;
      _emailController.text = widget.cliente.email;
      _enderecoController.text = widget.cliente.endereco!;
      _numeroController.text = widget.cliente.numero!;
      _bairroController.text = widget.cliente.bairro!;
      _cepController.text = widget.cliente.cep!;
      _cidadeController.text = widget.cliente.cidade!;
      _estadoController.text = widget.cliente.estado!;
    }
  }

//Persistencias
  void salvarFormulario() {
    if (_formKey.currentState!.validate()) {
      try {
        Cliente cliente = Cliente(
          usuarioId: usuarioId,
          nome: _nomeController.text,
          telefone: _telefoneController.text,
          email: _emailController.text,
          urlAvatar: "",
          dataCadastro: DateTime.now().toString(),
          ativo: 1,
          endereco: _enderecoController.text,
          numero: _numeroController.text,
          bairro: _bairroController.text,
          cep: _cepController.text,
          cidade: _cidadeController.text,
          estado: _estadoController.text,
        );

        if (modoTela == "N") {
          insertCliente(cliente);
          exibirMensagemSucesso(context, "Cliente cadastrado com sucesso.");
        } else if (modoTela == "E") {
          cliente.id = widget.cliente.id;
          updateCliente(cliente);
          exibirMensagemSucesso(context, "Cliente atualizado com sucesso.");
        }
        Navigator.pop(context);
      } catch (e) {
        exibirMensagemFalha(context, "Erro ao salvar as informações");
      }
    }
  }

  updateCliente(Cliente cliente) async {
    await ClienteDAO().updateCliente(cliente);
    setState(() {});
  }

  insertCliente(Cliente cliente) async {
    int id = await ClienteDAO().insertCliente(cliente);
    setState(() {
      cliente.id = id;
    });
  }
}
