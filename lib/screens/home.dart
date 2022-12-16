import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makuna/components/cardHome.dart';
import 'package:makuna/daos/cliente_dao.dart';
import 'package:makuna/daos/produto_dao.dart';
import 'package:makuna/daos/venda_dao.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/models/venda.dart';
import 'package:makuna/utils/extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final title = const Text("Makuna");
  String totalEmProdutos = '0,00';
  String produtoMaisLucrativo = '';
  String lucroEstimado = '0,00';
  String totalVendas = '0,00';
  String totalLucro = '0,00';
  String valorGasto = '0,00';
  String nomeClienteMenosCompra = '';
  String nomeClienteMaisCompra = '';
  static final List<String> opcoesDropdown = ['Todos', 'Mensal', 'Anual'];
  String itemDropdownAtual = opcoesDropdown[0];
  bool isLoading = true;

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
    await getInventario();
    await getVendasMensal();
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
      return const Center(child: CircularProgressIndicator());
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
            ),
            const Spacer(),
            CardHomeWidget(
              titulo: "Inventário",
              desc1: "Total em produtos: $totalEmProdutos",
              desc2: "Produto mais lucrativo: $produtoMaisLucrativo",
              icon: Icons.inventory_2,
              iconColor: Colors.blueAccent,
            ),
            const Spacer(),
            CardHomeWidget(
              titulo: "Clientes",
              desc1: "O que mais compra: $nomeClienteMaisCompra",
              desc2: "O que menos compra: $nomeClienteMenosCompra",
              icon: Icons.emoji_people,
              iconColor: Colors.orange,
            ),
            const Spacer(),
            CardHomeWidget(
              titulo: "Previsão e médias",
              desc1: "Lucro estimado:  $lucroEstimado",
              desc2: "Valor gasto mensal: $valorGasto",
              icon: Icons.timeline,
              iconColor: Colors.redAccent,
            ),
            const Spacer()
          ]));
    }
  }

  getInventario() async {
    List<Produto> produtos = await ProdutoDAO().readAll();
    if (produtos.isNotEmpty) {
      DateTime now = DateTime.now();

      if (itemDropdownAtual == 'Mensal') {
        produtos = produtos
            .where((element) =>
                element.dataCompra.convertToDateTime().month == now.month)
            .toList();
      } else if (itemDropdownAtual == 'Anual') {
        produtos = produtos
            .where((element) =>
                element.dataCompra.convertToDateTime().year == now.year)
            .toList();
      }

      double totalEmProdutosSum = produtos.fold(
          0, (sum, item) => sum + item.valorVendaPrevisao * item.quantidade);

      produtos.sort((a, b) => (a.valorVendaPrevisao - a.valorCompra)
          .compareTo(b.valorVendaPrevisao - b.valorCompra));

      final double lucroEstimadoSum = produtos.fold(
          0, (sum, item) => sum + (item.valorVendaPrevisao - item.valorCompra));

      final double valorGastoSum =
          produtos.fold(0, (sum, item) => sum + item.valorCompra);

      final numberFormatBr = NumberFormat.simpleCurrency(locale: "pt_Br");

      final String totalEmProdutosString =
          numberFormatBr.format(totalEmProdutosSum);
      final String lucroEstimadoString =
          numberFormatBr.format(lucroEstimadoSum);
      final String valorGastoString = numberFormatBr.format(valorGastoSum);

      setState(() {
        totalEmProdutos = totalEmProdutosString;
        produtoMaisLucrativo = produtos.last.nome;
        lucroEstimado = lucroEstimadoString;
        valorGasto = valorGastoString;
      });
    }
  }

  getVendasMensal() async {
    List<Venda> vendaProduto = await VendaDAO().readAll();

    DateTime now = DateTime.now();

    if (itemDropdownAtual == 'Mensal') {
      vendaProduto = vendaProduto
          .where((element) =>
              element.dataVenda.convertToDateTime().month == now.month)
          .toList();
    } else if (itemDropdownAtual == 'Anual') {
      vendaProduto = vendaProduto
          .where((element) =>
              element.dataVenda.convertToDateTime().year == now.year)
          .toList();
    }

    double totalVendasSum =
        vendaProduto.fold(0, (sum, item) => sum + item.valorTotalVenda);
    final numberFormatBr = NumberFormat.simpleCurrency(locale: "pt_Br");

    List<Produto> produtos = await ProdutoDAO().readAll();
    final double valorTotalCompra =
        produtos.fold(0, (sum, item) => sum + item.valorCompra);

    final double lucroMensal = totalVendasSum - valorTotalCompra;

    String totalVendasString = numberFormatBr.format(totalVendasSum);
    String totalLucroMensal = numberFormatBr.format(lucroMensal);

    setState(() {
      totalVendas = totalVendasString;
      totalLucro = totalLucroMensal;
    });
  }

  getComprasClientes() async {
    List<Venda> vendaProduto = await VendaDAO().readAll();

    DateTime now = DateTime.now();

    if (itemDropdownAtual == 'Mensal') {
      vendaProduto = vendaProduto
          .where((element) =>
              element.dataVenda.convertToDateTime().month == now.month)
          .toList();
    } else if (itemDropdownAtual == 'Anual') {
      vendaProduto = vendaProduto
          .where((element) =>
              element.dataVenda.convertToDateTime().year == now.year)
          .toList();
    }

    Map vendasMap = <int, int>{};
    for (var venda in vendaProduto) {
      vendasMap[venda.clienteId] = !vendasMap.containsKey(venda.clienteId)
          ? (1)
          : (vendasMap[venda.clienteId] + 1);
    }

    var vendasMapSorted = Map.fromEntries(vendasMap.entries.toList()
      ..sort((e1, e2) => e1.value.compareTo(e2.value)));

    final int clienteIdMenosCompra = vendasMapSorted.entries.first.key;
    final int clienteIdMaisCompra = vendasMapSorted.entries.last.key;

    final clienteMenosCompra =
        await ClienteDAO().readAllById(clienteIdMenosCompra);
    final clienteMaisCompra =
        await ClienteDAO().readAllById(clienteIdMaisCompra);

    setState(() {
      nomeClienteMenosCompra = clienteMenosCompra.first.nome;
      nomeClienteMaisCompra = clienteMaisCompra.first.nome;
    });
  }
}
