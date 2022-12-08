import 'package:flutter/material.dart';
import 'package:makuna/components/brasilFields.dart';
import 'package:makuna/components/input_form.dart';
import 'package:makuna/daos/cliente_dao.dart';
import 'package:makuna/daos/produto_dao.dart';
import 'package:makuna/daos/venda_dao.dart';
import 'package:makuna/models/cliente.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/models/venda.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/extension.dart';
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
  final _descricaoController = TextEditingController();
  final _dataVendaController = TextEditingController();

  int produtoIdSelecionado = 0;
  int clienteIdSelecionado = 0;

  List<Produto> produtos = [];
  List<Cliente> clientes = [];

  @override
  void initState() {
    getAllProdutos();
    getAllClientes();
    super.initState();
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

  insertVenda(Venda venda) async {
    int id = await VendaDAO().insertVenda(venda);
    setState(() {
      venda.id = id;
    });
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldProduto(),
                      fieldCliente(),
                      fieldValorVenda(),
                      fieldObservacao(),
                      fieldDataVenda(),
                    ]))));
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
      "",
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
        context, "Cliente", "[Lista de Clientes]", "", clientesMap,
        (onChangedVal) {
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
      controller: _descricaoController,
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
      _descricaoController.text = widget.venda.descricao;
      _dataVendaController.text = widget.venda.dataVenda;
      _valorVendaCompraController.text =
          widget.venda.valorVenda.convertDoubleToRealCurrency();
    }
  }

//Persistencias
  void salvarFormulario() {
    if (_formKey.currentState!.validate()) {
      Venda venda = Venda(
        produtoId: produtoIdSelecionado,
        clienteId: clienteIdSelecionado,
        valorVenda: double.parse(_valorVendaCompraController.text),
        descricao: _descricaoController.text,
        dataVenda: _dataVendaController.text,
      );
      insertVenda(venda);
      Navigator.pop(context);
    }
  }
}
