import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:makuna/components/brasilFields.dart';
import 'package:makuna/components/input_form.dart';
import 'package:makuna/daos/produto_dao.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/extension.dart';
import 'package:makuna/utils/util.dart';

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
    modoTela = validaModoTela(widget.produto.id);
    configuraTitulo();
    preencherCampos();

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
                        controller: _nomeController,
                        maxLength: 50,
                      ),
                      InputForm(
                        hint: "Ex.: Pro Max preto 500 GB",
                        label: "Modelo ou descrição do produto",
                        validationMsg:
                            "Insira o modelo ou descrição do produto",
                        controller: _descricaoController,
                        maxLength: 50,
                      ),
                      InputDataForm(
                          hint: "Ex.: 25/10/2022",
                          label: "Data de compra",
                          validationMsg:
                              "Insira a data que o produto foi comprado",
                          controller: _dataCompraController),
                      InputRealForm(
                          hint: "Ex.: 7.500,00",
                          label: "Custo do produto",
                          validationMsg: "Insira o valor de custo do produto",
                          controller: _valorCompraController),
                      InputRealForm(
                          hint: "Ex.: 10.000,00",
                          label: "valor de revenda",
                          validationMsg: "Insira o valor que pretende revender",
                          controller: _valorVendaPrevisaoController),
                    ]))));
  }

//Telas e validações
  void configuraTitulo() {
    modoTela == "N"
        ? tituloTela = "Novo produto"
        : tituloTela = "Atualizar produto";
  }

  void preencherCampos() {
    if (modoTela == "E") {
      _nomeController.text = widget.produto.nome;
      _descricaoController.text = widget.produto.descricao;
      _dataCompraController.text = widget.produto.dataCompra;
      _valorCompraController.text =
          widget.produto.valorCompra.convertDoubleToRealCurrency();
      _valorVendaPrevisaoController.text =
          widget.produto.valorVendaPrevisao.convertDoubleToRealCurrency();
    }
  }

  void salvarFormulario() {
    if (_formKey.currentState!.validate()) {
      try {
        if (modoTela == "N") {
          Produto produto = Produto(
            nome: _nomeController.text,
            descricao: _descricaoController.text,
            dataCompra: _dataCompraController.text,
            valorCompra:
                _valorCompraController.text.convertRealCurrencyToDouble(),
            valorVendaPrevisao: _valorVendaPrevisaoController.text
                .convertRealCurrencyToDouble(),
          );
          insertProduto(produto);
          exibirMensagemSucesso(context, "Produto registrado com sucesso.");
          Navigator.pop(context);
        } else {
          exibirMensagemSucesso(context, "Produto atualizado com sucesso.");
          setState(() {});
        }
      } catch (e) {
        exibirMensagemFalha(context, e.toString());
      }
    }
  }
}
