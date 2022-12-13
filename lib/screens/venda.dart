import 'package:flutter/material.dart';
import 'package:makuna/components/bottomNavigatorBar.dart';
import 'package:makuna/daos/cliente_dao.dart';
import 'package:makuna/daos/produto_dao.dart';
import 'package:makuna/daos/venda_dao.dart';
import 'package:makuna/models/cliente.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/models/venda.dart';
import 'package:makuna/screens/vendaCadastro.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/customWidgets.dart';
import 'package:makuna/utils/usuarioHelper.dart';

class VendaScreen extends StatefulWidget {
  const VendaScreen({super.key});

  @override
  State<VendaScreen> createState() => _VendaScreenState();
}

class _VendaScreenState extends State<VendaScreen> {
  final title = const Text("Histórico de vendas");
  List<Venda> vendas = [];
  List<Produto> produtos = [];
  List<Cliente> clientes = [];

  @override
  void initState() {
    super.initState();
    getAllVendas();
    getAllProdutos();
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
                            builder: (context) =>
                                VendaCadastroScreen(venda: _criarNovaVenda())))
                    .then((venda) => getAllVendas());
              },
              icon: addIcon)
        ]),
        body: _buildBodyScreen(),
        bottomNavigationBar: const BottomNavigatorBarWidget());
  }

  Widget _buildBodyScreen() {
    return clientes.isNotEmpty
        ? _exibirLista()
        : exibirListaVazia(context, "Nenhuma venda realizada.");
  }

  Widget _exibirLista() {
    return ListView.separated(
        itemBuilder: (context, index) => _buildItem(index),
        separatorBuilder: (context, index) => divisorList(),
        itemCount: vendas.length);
  }

  Widget _buildItem(int index) {
    Venda venda = vendas[index];
    String nomeCliente =
        clientes.where((c) => c.id == venda.clienteId).first.nome;
    String nomeProduto = venda.order;

    return Padding(
      padding: cardPadding,
      child: Container(
        decoration: cardBoxStyle(),
        child: ListTile(
          leading: buildSvgIcon("images/icoVerificar.svg"),
          title: Text(nomeProduto),
          subtitle: Text(nomeCliente),
          onTap: () {
            Venda venda = vendas[index];
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            VendaCadastroScreen(venda: venda)))
                .then((venda) => getAllVendas());
          },
          onLongPress: () {
            deleteVendasById(venda.id!);
          },
        ),
      ),
    );
  }

  Venda _criarNovaVenda() {
    return Venda(
        id: 0,
        usuarioId: usuarioId,
        order: "",
        clienteId: 0,
        detail: "",
        dataVenda: "",
        valorTotalVenda: 0,
        ativo: 1);
  }

//Chamadas na DAO
  getAllVendas() async {
    List<Venda> result = await VendaDAO().readAll();
    setState(() {
      vendas = result;
    });
  }

  getAllProdutos() async {
    List<Produto> result = await ProdutoDAO().readAll();
    setState(() {
      produtos = result;
    });
  }

  getAllClientes() async {
    List<Cliente> result = await ClienteDAO().readAll();
    setState(() {
      clientes = result;
    });
  }

  deleteVendasById(int id) async {
    await VendaDAO().deleteVenda(id);
    getAllVendas();
  }
}
