import 'package:flutter/material.dart';
import 'package:makuna/components/SnackBAR.dart';
import 'package:makuna/components/brasilFields.dart';
import 'package:makuna/components/input_form.dart';
import 'package:makuna/daos/produto_dao.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/customWidgets.dart';
import 'package:intl/intl.dart';

class ProdutoCadastroScreen extends StatefulWidget {
  const ProdutoCadastroScreen({super.key, required this.produto});

  final Produto produto;

  @override
  State<ProdutoCadastroScreen> createState() => _ProdutoCadastroScreenState();
}

class _ProdutoCadastroScreenState extends State<ProdutoCadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _dataCompraController = TextEditingController();
  final _valorCompraController = TextEditingController();
  final _valorVendaPrevisaoController = TextEditingController();

  insertProduto(Produto produto) async {
    int id = await ProdutoDAO().insertProduto(produto);
    setState(() {
      produto.id = id;
    });
  }

  // N= Novo E = Editando
  String modoTela = '';
  String tituloTela = '';

  @override
  Widget build(BuildContext context) {
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
                      InputForm(
                          hint: "Ex.: iPhone 14, RTX 4090",
                          label: "Nome do produto",
                          validationMsg: "Insira o nome do produto",
                          controller: _nomeController),
                      InputForm(
                          hint: "Ex.: Pro Max preto 500 GB",
                          label: "Descrição do produto",
                          validationMsg: "Insira a descrição do produto",
                          controller: _descricaoController),
                      InputDataForm(
                          hint: "Ex.: 25/10/2022",
                          label: "Data do produto",
                          validationMsg: "Insira a data da compra",
                          controller: _dataCompraController),
                      InputRealForm(
                          hint: "Digite o custo do produto",
                          label: "Custo do produto",
                          validationMsg: "Insira o valor de custo",
                          controller: _valorCompraController),
                      InputRealForm(
                          hint: "Digite o valor de venda",
                          label: "valor previsto de venda",
                          validationMsg: "Insira o valor que pretende vender",
                          controller: _valorVendaPrevisaoController),
                    ]))));
  }

  void salvarFormulario() {
    if (_formKey.currentState!.validate()) {
      try {
        if (modoTela == "N") {
          Produto produto = Produto(
            nome: _nomeController.text,
            descricao: _descricaoController.text,
            dataCompra: _dataCompraController.text,
            valorCompra: double.parse(_valorCompraController.text),
            valorVendaPrevisao:
                double.parse(_valorVendaPrevisaoController.text),
          );
          insertProduto(produto);
          showSnackBAR("Produto registrado com sucesso.", context,
              Colors.lightBlue, Colors.black);
          Navigator.pop(context);
        } else {
          showSnackBAR("Produto atualizado com sucesso.", context,
              Colors.lightBlue, Colors.black);
          setState(() {});
        }
      } catch (e) {
        showSnackBAR(
            "Falha ao registrar o produto.", context, Colors.red, Colors.white);
      }
    }
  }
}
