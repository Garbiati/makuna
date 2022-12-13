import 'package:avatars/avatars.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:makuna/components/bottomNavigatorBar.dart';
import 'package:makuna/daos/produto_dao.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/screens/produtoCadastro.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/customWidgets.dart';

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
        : exibirListaVazia(context, "Nenhum produto cadastrado.");
  }

  Widget _exibirLista() {
    return ListView.separated(
        itemBuilder: (context, index) => _buildItem(index),
        separatorBuilder: (context, index) => divisorList(),
        itemCount: produtos.length);
  }

  Widget fieldQuantidade(Produto produto) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Qtd.", style: tituloMenuTextStyle),
          Text(
            produto.quantidade.toString(),
            style: descMenuTextStyle,
          )
        ],
      );

  Widget _buildItem(int index) {
    Produto produto = produtos[index];
    return Padding(
      padding: cardPadding,
      child: Container(
        decoration: cardBoxStyle(),
        child: ListTile(
          leading: fieldQuantidade(
              produto), // buildSvgIcon("images/icoProdutoDefault.svg"),
          title: Text(produto.nome),
          subtitle:
              Text(UtilBrasilFields.obterReal(produto.valorVendaPrevisao)),
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
