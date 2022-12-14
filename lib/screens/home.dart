import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makuna/components/cardHome.dart';
import 'package:makuna/daos/cliente_dao.dart';
import 'package:makuna/daos/produto_dao.dart';
import 'package:makuna/daos/venda_dao.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/models/venda.dart';
import 'package:makuna/utils/customStyles.dart';
import 'package:makuna/utils/extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final title = const Text(
    "Makuna",
    textAlign: TextAlign.center,
  );
  String totalEmProdutos = '0,00';
  String produtoMaisLucrativo = '';
  String lucroEstimado = '0,00';
  String totalVendas = '0,00';
  String totalLucro = '0,00';
  String valorInvestido = '0,00';
  String nomeClienteMenosCompra = '';
  String nomeClienteMaisCompra = '';
  static final List<String> opcoesDropdown = ['Todos', 'Mensal', 'Anual'];
  String itemDropdownAtual = opcoesDropdown[0];
  bool isLoading = false;
  List<Produto> produtos = <Produto>[];
  List<Venda> vendas = <Venda>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      body: _buildList(),
    );
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() async {
    setState(() {
      isLoading = true;
    });

    await getProdutos();
    await getVendas();

    await getInventario();
    await getVendasCard();
    await getComprasClientes();

    setState(() {
      isLoading = false;
    });
  }

  Widget _buildList() {
    return Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 260,
            child: DropdownButton(
                isDense: true,
                elevation: 10,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                isExpanded: true,
                value: itemDropdownAtual,
                onChanged: (String? value) => {
                      setState(() {
                        itemDropdownAtual = value!;
                      }),
                      refresh()
                    },
                items: opcoesDropdown.map((String title) {
                  return DropdownMenuItem(
                    value: title,
                    child: Text(title,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0)),
                  );
                }).toList()),
          ),
          IconButton(
            onPressed: () => {refresh()},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      _listCardHomeWidget()
    ]);
  }

  _listCardHomeWidget() {
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.only(top: 250.0),
        child: Column(
          children: const [
            CircularProgressIndicator(),
            Text(
              "Carregando...",
              style: descCardTextStyle,
            )
          ],
        ),
      );
    } else {
      return SizedBox(
          height: 550,
          child: Column(children: [
            const Spacer(),
            CardHomeWidget(
              titulo: "Vendas",
              desc1: "Total de vendas: $totalVendas",
              desc2: "Total de lucro: $totalLucro",
              icon: Icons.sell,
              iconColor: Colors.green,
              textoInformation:
                  "Total de Vendas: ?? somado o valor total de todas as vendas. \n\nTotal de lucro: Valor total das vendas - Valor de compra dos produtos.",
            ),
            const Spacer(),
            CardHomeWidget(
              titulo: "Invent??rio",
              desc1: "Total em produtos: $totalEmProdutos",
              desc2: "Produto mais lucrativo: $produtoMaisLucrativo",
              icon: Icons.inventory_2,
              iconColor: Colors.blueAccent,
              textoInformation:
                  "Total em produtos: ?? somado o valor de revenda de todos os produtos. \n\nProduto mais lucrativo: O produto com maior margem de lucro com base no c??lculo: Valor de revenda do produto - Valor de compra do produto.",
            ),
            const Spacer(),
            CardHomeWidget(
              titulo: "Clientes",
              desc1: "O que mais compra: $nomeClienteMaisCompra",
              desc2: "O que menos compra: $nomeClienteMenosCompra",
              icon: Icons.emoji_people,
              iconColor: Colors.orange,
              textoInformation:
                  "O que mais compra: Nome do cliente que mais comprou. \n\nO que menos compra: Nome do cliente que menos Comprou.\n\n\nObs: Clientes que n??o realizaram nenhuma compra n??o entram no c??lculo.",
            ),
            const Spacer(),
            CardHomeWidget(
              titulo: "Previs??o e m??dias",
              desc1: "Lucro estimado:  $lucroEstimado",
              desc2: "Valor investido: $valorInvestido",
              icon: Icons.timeline,
              iconColor: Colors.redAccent,
              textoInformation:
                  "Lucro estimado: ?? subtraido o Valor de revenda - Valor de compra de todos os produtos. \n\nValor investido: ?? somado o valor de compra de todos os produtos.",
            ),
            const Spacer()
          ]));
    }
  }

  getProdutos() async {
    produtos = await ProdutoDAO().readAll();
    if (produtos.isNotEmpty) {
      DateTime now = DateTime.now();

      if (itemDropdownAtual == 'Mensal') {
        produtos = produtos
            .where((element) =>
                element.dataCompra.convertToDateTime().month == now.month &&
                element.dataCompra.convertToDateTime().year == now.year)
            .toList();
      } else if (itemDropdownAtual == 'Anual') {
        produtos = produtos
            .where((element) =>
                element.dataCompra.convertToDateTime().year == now.year)
            .toList();
      }
    }
  }

  getVendas() async {
    vendas = await VendaDAO().readAll();

    DateTime now = DateTime.now();
    if (itemDropdownAtual == 'Mensal') {
      vendas = vendas
          .where((element) =>
              element.dataVenda.convertToDateTime().month == now.month &&
              element.dataVenda.convertToDateTime().year == now.year)
          .toList();
    } else if (itemDropdownAtual == 'Anual') {
      vendas = vendas
          .where((element) =>
              element.dataVenda.convertToDateTime().year == now.year)
          .toList();
    }
  }

  getInventario() async {
    double totalEmProdutosSum =
        produtos.fold(0, (sum, item) => sum + item.valorVendaPrevisao);

    produtos.sort((a, b) => (a.valorVendaPrevisao - a.valorCompra)
        .compareTo(b.valorVendaPrevisao - b.valorCompra));

    final double lucroEstimadoSum = produtos.fold(
        0, (sum, item) => sum + (item.valorVendaPrevisao - item.valorCompra));

    final double valorInvestidoSum =
        produtos.fold(0, (sum, item) => sum + item.valorCompra);

    final numberFormatBr = NumberFormat.simpleCurrency(locale: "pt_Br");

    final String totalEmProdutosString =
        numberFormatBr.format(totalEmProdutosSum);
    final String lucroEstimadoString = numberFormatBr.format(lucroEstimadoSum);
    final String valorInvestidoString =
        numberFormatBr.format(valorInvestidoSum);

    setState(() {
      totalEmProdutos = totalEmProdutosString;
      produtoMaisLucrativo = produtos.isEmpty ? "" : produtos.last.nome;
      lucroEstimado = lucroEstimadoString;
      valorInvestido = valorInvestidoString;
    });
  }

  getVendasCard() async {
    double totalVendasSum =
        vendas.fold(0, (sum, item) => sum + item.valorTotalVenda);
    final numberFormatBr = NumberFormat.simpleCurrency(locale: "pt_Br");

    final double valorTotalCompra =
        produtos.fold(0, (sum, item) => sum + item.valorCompra);

    final double totalLucroSum = totalVendasSum - valorTotalCompra;

    String totalVendasString = numberFormatBr.format(totalVendasSum);
    String totalLucroString = numberFormatBr.format(totalLucroSum);

    setState(() {
      totalVendas = totalVendasString;
      totalLucro = totalLucroString;
    });
  }

  getComprasClientes() async {
    if (vendas.isEmpty) {
      return;
    }

    Map vendasMap = <int, int>{};
    for (var venda in vendas) {
      vendasMap[venda.clienteId] = !vendasMap.containsKey(venda.clienteId)
          ? (1)
          : (vendasMap[venda.clienteId] + 1);
    }

    var vendasMapSorted = Map.fromEntries(vendasMap.entries.toList()
      ..sort((e1, e2) => e1.value.compareTo(e2.value)));

    final int clienteIdMenosCompra = vendasMapSorted.entries.first.key;
    final int clienteIdMaisCompra = vendasMapSorted.entries.last.key;

    final clienteMenosCompra =
        await ClienteDAO().readById(clienteIdMenosCompra);
    final clienteMaisCompra = await ClienteDAO().readById(clienteIdMaisCompra);

    setState(() {
      nomeClienteMenosCompra = clienteMenosCompra.nome == clienteMaisCompra.nome
          ? ''
          : clienteMenosCompra.nome;

      nomeClienteMaisCompra = clienteMaisCompra.nome;
    });
  }
}
