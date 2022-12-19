import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makuna/components/brasilFields.dart';
import 'package:makuna/components/input_form.dart';
import 'package:makuna/daos/produto_dao.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/extension.dart';
import 'package:makuna/utils/usuarioHelper.dart';
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
  final _quantidadeProdutoController = TextEditingController();

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
                iconSize: 38,
                onPressed: () {
                  salvarFormulario();
                })
          ],
        ),
        body: Padding(
            padding: cardPadding,
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            fieldQuantidade(),
                            fieldData(),
                          ],
                        ),
                        InputForm(
                          hint: "Ex.: iPhone 14 Pro Max",
                          label: "Nome",
                          validationMsg: "Insira o nome do produto",
                          controller: _nomeController,
                          maxLength: 50,
                        ),
                        InputForm(
                          hint: "Ex.: Preto de 500 GB",
                          label: "Modelo",
                          validationMsg:
                              "Insira o modelo ou descrição do produto",
                          controller: _descricaoController,
                          maxLength: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              child: InputRealForm(
                                  hint: "Ex.: 7.500,00",
                                  label: "Valor do custo",
                                  validationMsg:
                                      "Insira o valor de custo do produto",
                                  controller: _valorCompraController),
                            ),
                            SizedBox(
                              width: 150,
                              child: InputRealForm(
                                  hint: "Ex.: 10.000,00",
                                  label: "Valor de revenda",
                                  validationMsg:
                                      "Insira o valor que pretende revender",
                                  controller: _valorVendaPrevisaoController),
                            ),
                          ],
                        ),
                      ]),
                ))));
  }

//Telas e validações
  Widget fieldData() {
    return InputDataForm(
        hint: "Ex.: 25/10/2022",
        label: "Data",
        validationMsg: "Insira a data que o produto foi comprado",
        controller: _dataCompraController);
  }

  Widget fieldQuantidade() {
    return SizedBox(
        width: 65,
        child: InputForm(
          hint: "",
          label: "QTD.",
          validationMsg: "Quantidade inválida",
          controller: _quantidadeProdutoController,
          maxLength: 3,
          textAlign: TextAlign.end,
          tipoImput: TextInputType.number,
          customMask: "###",
        ));
  }

  void configuraTitulo() {
    modoTela == "N"
        ? tituloTela = "Novo produto"
        : tituloTela = "Atualizar produto";
  }

  void preencherCampos() {
    _quantidadeProdutoController.text = "1";
    _dataCompraController.text = getDataHoje();
    if (modoTela == "E") {
      _nomeController.text = widget.produto.nome;
      _descricaoController.text = widget.produto.descricao;
      _dataCompraController.text = widget.produto.dataCompra;
      _valorCompraController.text =
          widget.produto.valorCompra.convertDoubleToRealCurrency(true);
      _valorVendaPrevisaoController.text =
          widget.produto.valorVendaPrevisao.convertDoubleToRealCurrency(true);
      _quantidadeProdutoController.text = widget.produto.quantidade.toString();
    }
  }

  void salvarFormulario() {
    if (_formKey.currentState!.validate()) {
      try {
        Produto produto = Produto(
            usuarioId: usuarioId,
            nome: _nomeController.text,
            codigoProduto: "",
            descricao: _descricaoController.text,
            valorCompra:
                _valorCompraController.text.convertRealCurrencyToDouble(),
            valorVendaPrevisao: _valorVendaPrevisaoController.text
                .convertRealCurrencyToDouble(),
            quantidade: int.parse(_quantidadeProdutoController.text),
            dataCompra: _dataCompraController.text,
            ativo: 1);

        if (modoTela == "N") {
          insertProduto(produto);
          exibirMensagemSucesso(context, "Produto registrado com sucesso.");
        } else {
          exibirMensagemSucesso(context, "Produto atualizado com sucesso.");
          produto.id = widget.produto.id;
          updateProduto(produto);
        }
        Navigator.pop(context);
      } catch (e) {
        exibirMensagemFalha(context, e.toString());
      }
    }
  }

  insertProduto(Produto produto) async {
    int id = await ProdutoDAO().insertProduto(produto);
    setState(() {
      produto.id = id;
    });
  }

  updateProduto(Produto produto) async {
    await ProdutoDAO().updateProduto(produto);
    setState(() {});
  }
}
