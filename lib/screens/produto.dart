import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:makuna/daos/produto_dao.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/screens/produtoAdicionar.dart';
import 'package:makuna/screens/produtoDetalhe.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/customWidgets.dart';

class ProdutoScreen extends StatefulWidget {
  const ProdutoScreen({super.key});

  @override
  State<ProdutoScreen> createState() => _ProdutoScreenState();
}

class _ProdutoScreenState extends State<ProdutoScreen> {
  final title = const Text("Cadastro de Produtos");
  final addRoute = const ProdutoAdicionarScreen();

  List<Produto> produtos = [];

  @override
  void initState() {
    super.initState();
    getAllProdutos();
  }

  getAllProdutos() async {
    List<Produto> result = await ProdutoDAO().readAll();
    setState(() {
      produtos = result;
    });
  }

  deleteProdutosById(int id) async {
    await ProdutoDAO().deleteProduto(id);
    getAllProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title, actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => addRoute))
                  .then((produto) => getAllProdutos());
            },
            icon: addIcon)
      ]),
      body: ListView.separated(
          itemBuilder: (context, index) => _buildItem(index),
          separatorBuilder: (context, index) => divisorList(),
          itemCount: produtos.length),
    );
  }

  Widget _buildItem(int index) {
    Produto produto = produtos[index];
    return Padding(
      padding: cardPadding,
      child: Container(
        decoration: cardBoxStyle(),
        child: ListTile(
          leading: Text(produto.id.toString()),
          title: Text(produto.nome),
          subtitle: Text(produto.valorVendaPrevisao.toString()),
          onLongPress: () {
            deleteProdutosById(produto.id!);
          },
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProdutoDetalheScreen(produto: produto)))
                .then((produto) => getAllProdutos());
          },
        ),
      ),
    );
  }
}
