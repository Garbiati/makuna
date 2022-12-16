import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makuna/components/brasilFields.dart';
import 'package:makuna/components/input_form.dart';
import 'package:makuna/components/resumoVenda.dart';
import 'package:makuna/daos/cliente_dao.dart';
import 'package:makuna/daos/produto_dao.dart';
import 'package:makuna/daos/vendaProduto_dao.dart';
import 'package:makuna/daos/venda_dao.dart';
import 'package:makuna/models/cliente.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/models/venda.dart';
import 'package:makuna/models/vendaProduto.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/customWidgets.dart';
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
  final _quantidadeController = TextEditingController();
  int produtoIdSelecionado = 0;
  int clienteIdSelecionado = 0;

  List<Produto> produtos = [];
  List<Cliente> clientes = [];
  List<VendaProduto> vendaProdutos = [];

  String orderNumber = generateOS().toUpperCase();

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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: buildScreen()),
                ))));
  }

  List<Widget> buildScreen() {
    List<Widget> result = [];

    _dataVendaController.text = getDataHoje();

    //result.add(fieldOrderNumber());
    //result.add(fieldDataVenda());
    result.add(rowDataAndOS());
    result.add(fieldCliente());

    result.add(Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
            onPressed: () {
              exibirModalProdutos(context);
            },
            icon: const Icon(Icons.search),
            label: const Text("Produtos")),
      ],
    ));

    vendaProdutos.isEmpty
        ? result.add(fieldListaVazia())
        : result.add(fieldResumo());

    return result;
  }

  Widget fieldListaVazia() {
    return const SizedBox(
      child: Text(
        "Para adicionar produtos, clique no botão acima.",
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget fieldResumo() {
    List<Widget> result = [];
    result.add(const Padding(padding: EdgeInsets.only(top: 10)));
    result.add(getHeader());
    result.add(divisorResumo());
    double valortotal = 0;
    for (VendaProduto produto in vendaProdutos) {
      if (valortotal > 0) result.add(const MySeparator());
      String desc = produtos.where((p) => p.id == produto.produtoId).first.nome;
      valortotal += produto.valorVenda;

      result.add(getProdutoRow(produto.quantidade.toString(), desc,
          produto.valorVenda.convertDoubleToRealCurrency(false)));
    }

    result.add(divisorResumo());
    result.add(paddingBott10());
    result.add(getValorTotal(valortotal.convertDoubleToRealCurrency(true)));

    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Column(children: result),
    );
  }

  double calcularValorTotal() {
    double valortotal = 0;
    for (VendaProduto produto in vendaProdutos) {
      valortotal += produto.valorVenda;
    }

    return valortotal;
  }

  Future<void> exibirModalProdutos(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.only(bottom: 15),
            title: const Text(
              "Lista de produtos",
              style: dialogMessageTituloTextStyle,
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
              width: 450,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  fieldProduto(),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      fieldQuantidade(),
                      fieldValorVenda(),
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _valorVendaCompraController.text =
                      double.parse("0").convertDoubleToRealCurrency(true);
                  _quantidadeController.text = "1";
                  produtoIdSelecionado = 0;
                },
              ),
              ElevatedButton(
                child: const Text('Adicionar'),
                onPressed: () {
                  int quantidade = int.parse(_quantidadeController.text);

                  double valorVendaUnidade = _valorVendaCompraController.text
                      .convertRealCurrencyToDouble();

                  bool existeVendaProduto = vendaProdutos.any((vp) =>
                      vp.produtoId == produtoIdSelecionado &&
                      (vp.valorVenda / vp.quantidade) == valorVendaUnidade);

                  if (existeVendaProduto) {
                    var vp = vendaProdutos.firstWhere((vp) =>
                        vp.produtoId == produtoIdSelecionado &&
                        (vp.valorVenda / vp.quantidade) == valorVendaUnidade);

                    vp.quantidade += quantidade;
                    vp.valorVenda = valorVendaUnidade * vp.quantidade;
                  } else {
                    vendaProdutos.add(VendaProduto(
                        produtoId: produtoIdSelecionado,
                        quantidade: quantidade,
                        usuarioId: usuarioId,
                        valorVenda: valorVendaUnidade,
                        vendaId: 0));
                  }

                  Navigator.of(context).pop();
                  _valorVendaCompraController.text =
                      double.parse("0").convertDoubleToRealCurrency(true);
                  _quantidadeController.text = "1";
                  setState(() {
                    produtoIdSelecionado = 0;
                  });
                },
              ),
            ],
          );
        });
  }

  Widget rowDataAndOS() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        fieldOrderNumber(),
        fieldDataVenda(),
      ],
    );
  }

  Widget fieldOrderNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Código da venda:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          orderNumber,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget fieldDataVenda() {
    return InputDataForm(
        hint: "Ex.: 25/10/2022",
        label: "Data da venda",
        validationMsg: "Insira a data da venda",
        controller: _dataVendaController);
  }

  Widget fieldCliente() {
    var clientesMap = clientes.map((e) {
      return {"id": e.id, "nome": e.nome};
    }).toList();

    return FormHelper.dropDownWidgetWithLabel(
        context,
        "Lista de clientes",
        "Selecione...",
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

  Widget fieldProduto() {
    var produtosMap = produtos.map((e) {
      return {
        "id": e.id,
        "nome":
            "${e.nome} (${e.valorVendaPrevisao.convertDoubleToRealCurrency(true)})"
      };
    }).toList();

    return FormHelper.dropDownWidgetWithLabel(
      context,
      "Lista de produto",
      "Selecione...",
      produtoIdSelecionado,
      produtosMap,
      (onChangedVal) {
        produtoIdSelecionado = int.parse(onChangedVal);
        _valorVendaCompraController.text = produtos
            .where((p) => p.id == produtoIdSelecionado)
            .first
            .valorVendaPrevisao
            .convertDoubleToRealCurrency(true);
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

  Widget fieldValorVenda() {
    _valorVendaCompraController.text =
        double.parse("0").convertDoubleToRealCurrency(true);
    return SizedBox(
      width: 150,
      child: InputRealForm(
          hint: "Ex.: R\$ 15.000,00",
          label: "Valor unitário",
          validationMsg: "Valor real da venda",
          controller: _valorVendaCompraController),
    );
  }

  Widget fieldQuantidade() {
    _quantidadeController.text = "1";
    return SizedBox(
        width: 50,
        child: InputForm(
          hint: "1",
          label: "QTD.",
          validationMsg: "Quantidade inválida",
          controller: _quantidadeController,
          maxLength: 3,
          textAlign: TextAlign.end,
        ));
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

//Telas e validações
  void configuraTitulo() {
    modoTela == "N"
        ? tituloTela = "Realizar venda"
        : tituloTela = "Atualizar venda";
  }

  void preencherCampos() {
    if (modoTela == "E") {
      orderNumber = widget.venda.orderNumber;
      getVendaProduto(widget.venda.id!);
      _detailController.text = widget.venda.detail;
      _dataVendaController.text = widget.venda.dataVenda;
      _valorVendaCompraController.text =
          widget.venda.valorTotalVenda.convertDoubleToRealCurrency(true);
    }
  }

//Persistencias
  void salvarFormulario() async {
    if (_formKey.currentState!.validate()) {
      try {
        Venda venda = Venda(
            usuarioId: usuarioId,
            orderNumber: orderNumber,
            clienteId: clienteIdSelecionado > 0
                ? clienteIdSelecionado
                : widget.venda.clienteId,
            valorTotalVenda:
                _valorVendaCompraController.text.convertRealCurrencyToDouble(),
            detail: _detailController.text,
            dataVenda: _dataVendaController.text,
            ativo: 1);

        if (modoTela == "N") {
          insertVenda(venda).then((id) async {
            venda.id = id;
            for (var vendaProduto in vendaProdutos) {
              vendaProduto.vendaId = venda.id!;
              await insertVendaProduto(vendaProduto);
            }

            venda.valorTotalVenda = calcularValorTotal();
            await updateVenda(venda);

            exibirMensagemSucesso(context, "Venda realizada com sucesso.");
            Navigator.pop(context);
          });
        } else {
          venda.id = widget.venda.id;
          updateVenda(venda);

          vendaProdutos.map((vendaProduto) => () {
                vendaProduto.vendaId = venda.id!;
                updateVendaProduto(vendaProduto);
              });

          exibirMensagemSucesso(context, "Venda atualizada com sucesso.");
          Navigator.pop(context);
        }
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

    return id;
  }

  insertVendaProduto(VendaProduto vendaProduto) async {
    await VendaProdutoDAO().insertVendaProduto(vendaProduto);
  }

  updateVenda(Venda venda) async {
    await VendaDAO().updateVenda(venda);
  }

  updateVendaProduto(VendaProduto vendaProduto) async {
    await VendaProdutoDAO().updateVendaProduto(vendaProduto);
  }
}
