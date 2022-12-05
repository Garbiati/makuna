import 'package:flutter/material.dart';
import 'package:makuna/components/input_form.dart';
import 'package:makuna/daos/cliente_dao.dart';
import 'package:makuna/models/cliente.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/customWidgets.dart';

class AddClienteScreen extends StatefulWidget {
  const AddClienteScreen({super.key});

  @override
  State<AddClienteScreen> createState() => _AddClienteScreenState();
}

class _AddClienteScreenState extends State<AddClienteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();

  insertCliente(Cliente cliente) async {
    int id = await ClienteDAO().insertCliente(cliente);
    setState(() {
      cliente.id = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Novo Cliente")),
        body: Padding(
            padding: cardPadding,
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputForm(
                          hint: "Digite o nome do cliente",
                          label: "Nome do cliente",
                          validationMsg: "Insira o nome do cliente",
                          controller: _nomeController),
                      InputForm(
                          hint: "Digite o telefone do cliente",
                          label: "Telefone do cliente",
                          validationMsg: "Insira o telefone do cliente",
                          controller: _telefoneController),
                      Padding(
                          padding: cardPadding,
                          child: ElevatedButton(
                              onPressed: (() {
                                if (_formKey.currentState!.validate()) {
                                  Cliente cliente = Cliente(
                                      nome: _nomeController.text,
                                      telefone: _telefoneController.text);
                                  insertCliente(cliente);
                                  Navigator.pop(context);
                                }
                              }),
                              child: salvarText))
                    ]))));
  }
}
