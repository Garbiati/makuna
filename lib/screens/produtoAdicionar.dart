import 'package:flutter/material.dart';
import 'package:makuna/components/input_form.dart';
import 'package:makuna/daos/produto_dao.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/customWidgets.dart';
import 'package:intl/intl.dart';

class ProdutoAdicionarScreen extends StatefulWidget {
  const ProdutoAdicionarScreen({super.key});

  @override
  State<ProdutoAdicionarScreen> createState() => _ProdutoAdicionarScreenState();
}

class _ProdutoAdicionarScreenState extends State<ProdutoAdicionarScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Novo Produto")),
        body: Padding(
            padding: cardPadding,
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputForm(
                          hint: "Digite o nome do produto",
                          label: "Nome do produto",
                          validationMsg: "Insira o nome do produto",
                          controller: _nomeController),
                      InputForm(
                          hint: "Digite uma descrição do produto",
                          label: "Descrição do produto",
                          validationMsg: "Insira a descrição do produto",
                          controller: _descricaoController),
                      InputForm(
                          hint: "Digite a data da compra",
                          label: "Data do produto",
                          validationMsg: "Insira a data da compra",
                          controller: _dataCompraController),
                      InputForm(
                          hint: "Digite o custo do produto",
                          label: "Custo do produto",
                          validationMsg: "Insira o valor de custo",
                          controller: _valorCompraController),
                      InputForm(
                          hint: "Digite o valor de venda",
                          label: "valor previsto de venda",
                          validationMsg: "Insira o valor que pretende vender",
                          controller: _valorVendaPrevisaoController),
                      Padding(
                          padding: cardPadding,
                          child: ElevatedButton(
                              onPressed: (() {
                                if (_formKey.currentState!.validate()) {
                                  Produto produto = Produto(
                                    nome: _nomeController.text,
                                    descricao: _descricaoController.text,
                                    dataCompra: _dataCompraController.text,
                                    valorCompra: double.parse(
                                        _valorCompraController.text),
                                    valorVendaPrevisao: double.parse(
                                        _valorVendaPrevisaoController.text),
                                  );
                                  insertProduto(produto);
                                  Navigator.pop(context);
                                }
                              }),
                              child: salvarText))
                    ]))));
  }
}
