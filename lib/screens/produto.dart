import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:makuna/daos/produto_dao.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/screens/operacaoRealizada.dart';
import 'package:makuna/screens/produtoCadastro.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/customWidgets.dart';
import 'package:makuna/utils/util.dart';

class ProdutoScreen extends StatefulWidget {
  const ProdutoScreen({super.key});

  @override
  State<ProdutoScreen> createState() => _ProdutoScreenState();
}

class _ProdutoScreenState extends State<ProdutoScreen> {
  final title = const Text("Cadastro de Produtos");

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
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProdutoCadastroScreen(
                              produto: _criarNovoProduto())))
                  .then((produto) => getAllProdutos());
            },
            icon: addIcon,
            iconSize: 38,
          )
        ]),
        body: _buildBodyScreen());
  }

  Widget _buildBodyScreen() {
    return produtos.isNotEmpty
        ? _exibirLista()
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              exibirListaVazia(context, "Nenhum produto cadastrado."),
              ElevatedButton(
                  onPressed: () {
                    somenteDevModeInserirProdutos();

                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const OperacaoRealizadaScreen()))
                        .then((produto) => getAllProdutos());
                  },
                  child: const Text("DEVMOD: Auto Preencher"))
            ],
          );
  }

  Widget _exibirLista() {
    return ListView.separated(
        itemBuilder: (context, index) => _buildItem(index),
        separatorBuilder: (context, index) => divisorList(),
        itemCount: produtos.length);
  }

  Widget fieldQuantidade(Produto produto) => Text(
        "Quantidade:${produto.quantidade}",
      );

  Widget _buildItem(int index) {
    Produto produto = produtos[index];
    return Padding(
      padding: cardPadding,
      child: Container(
        decoration: cardBoxStyle(),
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
                child: Text(
                  "${produto.quantidade}x ",
                  style: const TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
          title: Text(produto.nome),
          subtitle: Text(produto.descricao),
          onLongPress: () {
            deleteProdutosById(produto.id!);
          },
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProdutoCadastroScreen(produto: produto)))
                .then((produto) => getAllProdutos());
          },
        ),
      ),
    );
  }

  Produto _criarNovoProduto() {
    return Produto(
      id: 0,
      usuarioId: 0,
      codigoProduto: "",
      nome: "",
      descricao: "",
      valorCompra: 0,
      valorVendaPrevisao: 0,
      quantidade: 0,
      dataCompra: "",
      ativo: 1,
    );
  }
}
