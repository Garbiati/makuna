import 'package:flutter/material.dart';
import 'package:makuna/daos/venda_dao.dart';
import 'package:makuna/models/venda.dart';
import 'package:makuna/screens/vendaCadastro.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/customWidgets.dart';

class VendaScreen extends StatefulWidget {
  const VendaScreen({super.key});

  @override
  State<VendaScreen> createState() => _VendaScreenState();
}

class _VendaScreenState extends State<VendaScreen> {
  final title = const Text("Histórico de vendas");
  List<Venda> vendas = [];

  @override
  void initState() {
    super.initState();
    getAllVendas();
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
      body: ListView.separated(
          itemBuilder: (context, index) => _buildItem(index),
          separatorBuilder: (context, index) => divisorList(),
          itemCount: vendas.length),
    );
  }

  Widget _buildItem(int index) {
    Venda venda = vendas[index];
    return Padding(
      padding: cardPadding,
      child: Container(
        decoration: cardBoxStyle(),
        child: ListTile(
          leading: buildSvgIcon("images/icoVerificar.svg"),
          title: Text(venda.descricao),
          subtitle: Text(venda.dataVenda),
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
      clienteId: 0,
      produtoId: 0,
      descricao: "",
      dataVenda: "",
      valorVenda: 0,
    );
  }

//Chamadas na DAO
  getAllVendas() async {
    List<Venda> result = await VendaDAO().readAll();
    setState(() {
      vendas = result;
    });
  }

  deleteVendasById(int id) async {
    await VendaDAO().deleteVenda(id);
    getAllVendas();
  }
}
