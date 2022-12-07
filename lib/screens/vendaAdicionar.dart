import 'package:flutter/material.dart';
import 'package:makuna/components/dropdown_form.dart';
import 'package:makuna/components/input_form.dart';
import 'package:makuna/daos/cliente_dao.dart';
import 'package:makuna/daos/produto_dao.dart';
import 'package:makuna/daos/venda_dao.dart';
import 'package:makuna/models/cliente.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/models/venda.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/customWidgets.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class VendaAdicionarScreen extends StatefulWidget {
  const VendaAdicionarScreen({super.key});

  @override
  State<VendaAdicionarScreen> createState() => _VendaAdicionarScreenState();
}

class _VendaAdicionarScreenState extends State<VendaAdicionarScreen> {
  final _formKey = GlobalKey<FormState>();
  //final _produtoIdController = TextEditingController();
  final _clienteIdController = TextEditingController();
  final _valorVendaCompraController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _dataVendaController = TextEditingController();
  Produto produtoSelecionado = Produto(
      id: 9999,
      nome: "nome",
      descricao: "descricao",
      dataCompra: "02/02/2022",
      valorCompra: 0,
      valorVendaPrevisao: 0);

  Cliente clienteSelecionado =
      Cliente(id: 9999, nome: "nome", telefone: "telefone");

  List<Produto> produtos = <Produto>[
    Produto(
        id: 9999,
        nome: "nome",
        descricao: "descricao",
        dataCompra: "02/02/2022",
        valorCompra: 0,
        valorVendaPrevisao: 0)
  ];

  List<Cliente> clientes = <Cliente>[
    Cliente(id: 9999, nome: "nome", telefone: "telefone")
  ];

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

  @override
  Widget build(BuildContext context) {
    var produtosMap = produtos.map((e) {
      return {"id": e.id, "nome": e.nome};
    }).toList();

    return Scaffold(
        appBar: AppBar(title: const Text("Nova Venda")),
        body: Padding(
            padding: cardPadding,
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormHelper.dropDownWidgetWithLabel(
                        context,
                        "Selecione o produto",
                        "Nome do produto",
                        "",
                        produtosMap,
                        (onChangedVal) {
                          produtoSelecionado = onChangedVal;
                          
                        },
                        (onValidateVal) {
                          if (onValidateVal == null) {
                            return "Por favor, selecione um produto";
                          }

                          return null;
                        },
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderColor: Theme.of(context).primaryColor,
                        borderRadius: 10,
                        optionValue: "id",
                        optionLabel: "nome",
                      ),
                      InputForm(
                          hint: "Digite o id do cliente",
                          label: "ID do cliente",
                          validationMsg: "Insira o ID do cliente",
                          controller: _clienteIdController),
                      InputForm(
                          hint: "Digite o valor da venda",
                          label: "Valor de venda",
                          validationMsg: "Insira o valor da venda",
                          controller: _valorVendaCompraController),
                      InputForm(
                          hint: "Digite uma descrição da venda",
                          label: "Descrição do produto",
                          validationMsg: "Insira a descrição do produto",
                          controller: _descricaoController),
                      InputForm(
                          hint: "Digite a data da venda",
                          label: "Data da venda",
                          validationMsg: "Insira a data da venda",
                          controller: _dataVendaController),
                      Padding(
                          padding: cardPadding,
                          child: ElevatedButton(
                              onPressed: (() {
                                if (_formKey.currentState!.validate()) {
                                  Venda venda = Venda(
                                    produtoId: produtoSelecionado.id!,
                                    clienteId:
                                        int.parse(_clienteIdController.text),
                                    valorVenda: double.parse(
                                        _valorVendaCompraController.text),
                                    descricao: _descricaoController.text,
                                    dataVenda: _dataVendaController.text,
                                  );
                                  insertVenda(venda);
                                  Navigator.pop(context);
                                }
                              }),
                              child: salvarText))
                    ]))));
  }
}
