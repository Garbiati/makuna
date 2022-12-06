import 'package:flutter/material.dart';
import 'package:makuna/models/cliente.dart';
import 'package:makuna/screens/clienteAdicionar.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/customWidgets.dart';
import 'package:makuna/daos/cliente_dao.dart';

class ClienteScreen extends StatefulWidget {
  const ClienteScreen({super.key});

  @override
  State<ClienteScreen> createState() => _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  final title = const Text("Cadastro de Clientes");
  final addRoute = const ClienteAdicionarScreen();

  List<Cliente> clientes = [];

  @override
  void initState() {
    super.initState();
    getAllClientes();
  }

  getAllClientes() async {
    List<Cliente> result = await ClienteDAO().readAll();
    setState(() {
      clientes = result;
    });
  }

  deleteClienteById(int id) async {
    await ClienteDAO().deleteCliente(id);
    getAllClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title, actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => addRoute))
                  .then((cliente) => getAllClientes());
            },
            icon: addIcon)
      ]),
      body: ListView.separated(
          itemBuilder: (context, index) => _buildItem(index),
          separatorBuilder: (context, index) => divisorList(),
          itemCount: clientes.length),
    );
  }

  Widget _buildItem(int index) {
    Cliente cliente = clientes[index];
    return Padding(
      padding: cardPadding,
      child: Container(
        decoration: cardBoxStyle(),
        child: ListTile(
          leading: Text(cliente.id.toString()),
          title: Text(cliente.nome),
          subtitle: Text(cliente.telefone),
          onLongPress: () {
            deleteClienteById(cliente.id!);
          },
        ),
      ),
    );
  }
}
