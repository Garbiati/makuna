import 'package:flutter/material.dart';
import 'package:makuna/components/brasilFields.dart';
import 'package:makuna/components/input_form.dart';
import 'package:makuna/daos/cliente_dao.dart';
import 'package:makuna/daos/produto_dao.dart';
import 'package:makuna/daos/vendaProduto_dao.dart';
import 'package:makuna/daos/venda_dao.dart';
import 'package:makuna/models/cliente.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/models/venda.dart';
import 'package:makuna/models/vendaProduto.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/extension.dart';
import 'package:makuna/utils/usuarioHelper.dart';
import 'package:makuna/utils/util.dart';

import 'package:snippet_coder_utils/FormHelper.dart';

class VendaCadastroScreen extends StatefulWidget {
  const VendaCadastroScreen({super.key, required this.venda});

  final Venda venda;

  @override
  State<VendaCadastroScreen> createState() => _VendaCadastroScreenState();
}

class _VendaCadastroScreenState extends State<VendaCadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _valorVendaCompraController = TextEditingController();
  final _detailController = TextEditingController();
  final _dataVendaController = TextEditingController();

  int produtoIdSelecionado = 0;
  int clienteIdSelecionado = 0;

  List<Produto> produtos = [];
  List<Cliente> clientes = [];
  List<VendaProduto> vendaProdutos = [];

  @override
  void initState() {
    getAllProdutos();
    getAllClientes();
    super.initState();
  }

// N= Novo E = Editando
  String modoTela = '';
  String tituloTela = '';

  @override
  Widget build(BuildContext context) {
    modoTela = validaModoTela(widget.venda.id);
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
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fieldCliente(),
                        fieldProduto(),
                        fieldValorVenda(),
                        fieldObservacao(),
                        fieldDataVenda(),
                      ]),
                ))));
  }

  Widget fieldProduto() {
    var produtosMap = produtos.map((e) {
      return {
        "id": e.id,
        "nome":
            "${e.nome} (${e.valorVendaPrevisao.convertDoubleToRealCurrency()})"
      };
    }).toList();

    return FormHelper.dropDownWidgetWithLabel(
      context,
      "Produto",
      "[Lista de Produtos]",
      vendaProdutos.isNotEmpty ? vendaProdutos.first.produtoId : "",
      produtosMap,
      (onChangedVal) {
        produtoIdSelecionado = int.parse(onChangedVal);
      },
      (onValidateVal) {
        if (onValidateVal == null) {
          return "Por favor, selecione um produto";
        }

        return null;
      },
      borderFocusColor: Theme.of(context).primaryColor,
      borderColor: Theme.of(context).primaryColor,
      borderRadius: 5,
      labelFontSize: 15,
      paddingRight: 0,
      paddingLeft: 0,
      paddingBottom: 0,
      paddingTop: 0,
      prefixIconPaddingBottom: 0,
      prefixIconPaddingTop: 0,
      prefixIconPaddingLeft: 0,
      prefixIconPaddingRight: 0,
      showPrefixIcon: true,
      prefixIcon: const Icon(
        Icons.diamond,
        color: Colors.black,
      ),
      optionValue: "id",
      optionLabel: "nome",
    );
  }

  Widget fieldCliente() {
    var clientesMap = clientes.map((e) {
      return {"id": e.id, "nome": e.nome};
    }).toList();

    return FormHelper.dropDownWidgetWithLabel(
        context,
        "Cliente",
        "[Lista de Clientes]",
        widget.venda.clienteId > 0 ? widget.venda.clienteId : "",
        clientesMap, (onChangedVal) {
      clienteIdSelecionado = int.parse(onChangedVal);
    }, (onValidateVal) {
      if (onValidateVal == null) {
        return "Por favor, selecione um cliente";
      }

      return null;
    },
        borderFocusColor: Theme.of(context).primaryColor,
        borderColor: Theme.of(context).primaryColor,
        borderRadius: 5,
        labelFontSize: 15,
        paddingRight: 0,
        paddingLeft: 0,
        paddingBottom: 0,
        paddingTop: 0,
        optionValue: "id",
        optionLabel: "nome",
        showPrefixIcon: true,
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.black,
        ),
        prefixIconPaddingBottom: 0,
        prefixIconPaddingTop: 0,
        prefixIconPaddingLeft: 0,
        prefixIconPaddingRight: 0);
  }

  Widget fieldValorVenda() {
    return InputRealForm(
        hint: "Ex.: R\$ 15.000,00",
        label: "Valor real da venda",
        validationMsg: "Valor real da venda",
        controller: _valorVendaCompraController);
  }

  Widget fieldObservacao() {
    return InputForm(
      hint: "Ex.: Embrulhar para presente...",
      label: "Observação",
      validationMsg: "Insira uma observação",
      controller: _detailController,
      maxLength: 50,
    );
  }

  Widget fieldDataVenda() {
    return InputDataForm(
        hint: "Ex.: 25/10/2022",
        label: "Data de compra",
        validationMsg: "Insira a data da venda",
        controller: _dataVendaController);
  }

//Telas e validações
  void configuraTitulo() {
    modoTela == "N"
        ? tituloTela = "Realizar venda"
        : tituloTela = "Atualizar venda";
  }

  void preencherCampos() {
    if (modoTela == "E") {
      _detailController.text = widget.venda.detail;
      _dataVendaController.text = widget.venda.dataVenda;
      _valorVendaCompraController.text =
          widget.venda.valorTotalVenda.convertDoubleToRealCurrency();
    }
  }

//Persistencias
  void salvarFormulario() async {
    if (_formKey.currentState!.validate()) {
      try {
        Venda venda = Venda(
            usuarioId: usuarioId,
            orderNumber: "O00001",
            clienteId: clienteIdSelecionado > 0
                ? clienteIdSelecionado
                : widget.venda.clienteId,
            valorTotalVenda:
                _valorVendaCompraController.text.convertRealCurrencyToDouble(),
            detail: _detailController.text,
            dataVenda: _dataVendaController.text,
            ativo: 1);

        VendaProduto vendaProduto = VendaProduto(
            usuarioId: usuarioId,
            vendaId: widget.venda.id!,
            produtoId: produtoIdSelecionado,
            valorVenda:
                _valorVendaCompraController.text.convertRealCurrencyToDouble(),
            quantidade: 1);

        if (modoTela == "N") {
          insertVenda(venda).then((value) {
            venda.id = value;
            vendaProduto.vendaId = venda.id!;
            insertVendaProduto(vendaProduto);
            exibirMensagemSucesso(context, "Venda realizada com sucesso.");
            Navigator.pop(context);
          });
        } else {
          venda.id = widget.venda.id;
          updateVenda(venda);

          exibirMensagemSucesso(context, "Venda atualizada com sucesso.");
        }
        Navigator.pop(context);
      } catch (e) {
        exibirMensagemFalha(context, "Falha ao salvar as informações");
      }
    }
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

  getVendaProduto(int vendaId) async {
    List<VendaProduto> result = await VendaProdutoDAO().readByVendaId(vendaId);
    setState(() {
      vendaProdutos = result;
    });
  }

  Future<int> insertVenda(Venda venda) async {
    int id = await VendaDAO().insertVenda(venda);
    setState(() {
      venda.id = id;
    });

    return id;
  }

  insertVendaProduto(VendaProduto vendaProduto) async {
    int id = await VendaProdutoDAO().insertVendaProduto(vendaProduto);
    setState(() {
      vendaProduto.id = id;
    });
  }

  updateVenda(Venda venda) async {
    await VendaDAO().updateVenda(venda);
    setState(() {});
  }

  updateVendaProduto(VendaProduto vendaProduto) async {
    await VendaProdutoDAO().updateVendaProduto(vendaProduto);
    setState(() {});
  }
}
