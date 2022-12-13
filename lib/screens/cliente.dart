import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:makuna/components/bottomNavigatorBar.dart';
import 'package:makuna/models/cliente.dart';
import 'package:makuna/screens/clienteCadastro.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/customWidgets.dart';
import 'package:makuna/daos/cliente_dao.dart';

class ClienteScreen extends StatefulWidget {
  const ClienteScreen({super.key});

  @override
  State<ClienteScreen> createState() => _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  final title = const Text("Meus clientes");
  List<Cliente> clientes = [];

  bool exibirMensagem = true;

  @override
  void initState() {
    super.initState();
    getAllClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: title, actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClienteCadastroScreen(
                              cliente: _criarNovoCliente())))
                  .then((produto) => getAllClientes());
            },
            icon: addIcon,
            iconSize: 38,
          )
        ]),
        body: _buildBodyScreen(),
        bottomNavigationBar: const BottomNavigatorBarWidget());
  }

//Construção de tela

  Widget _buildBodyScreen() {
    return clientes.isNotEmpty
        ? _exibirLista()
        : exibirListaVazia(context, "Nenhum cliente cadastrado.");
  }

  Widget _exibirLista() {
    return ListView.separated(
        itemBuilder: (context, index) => _buildItem(index),
        separatorBuilder: (context, index) => divisorList(),
        itemCount: clientes.length);
  }

  Widget _buildItem(int index) {
    Cliente cliente = clientes[index];
    return Padding(
      padding: cardPadding,
      child: Container(
        decoration: cardBoxStyle(),
        child: ListTile(
          leading: fieldAvatar(cliente),
          title: Text(cliente.nome),
          subtitle: Text(cliente.telefone),
          onLongPress: () {
            deleteClienteById(cliente.id!);
          },
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ClienteCadastroScreen(cliente: cliente)))
                .then((produto) => getAllClientes());
          },
        ),
      ),
    );
  }

  Widget fieldAvatar(Cliente cliente) => Avatar(
        sources: [
          GravatarSource(cliente.email, 300),
        ],
        name: cliente.nome.isEmpty ? "?" : cliente.nome,
      );

//Chamadas DAO
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

  Cliente _criarNovoCliente() {
    return Cliente(
        id: 0,
        usuarioId: 0,
        nome: "",
        telefone: "",
        email: "",
        urlAvatar: "",
        dataCadastro: "",
        ativo: 1);
  }
}
