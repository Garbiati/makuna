import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makuna/components/cardHome.dart';
import 'package:makuna/daos/cliente_dao.dart';
import 'package:makuna/daos/produto_dao.dart';
import 'package:makuna/daos/vendaProduto_dao.dart';
import 'package:makuna/daos/venda_dao.dart';
import 'package:makuna/models/produto.dart';
import 'package:makuna/models/venda.dart';
import 'package:makuna/models/vendaProduto.dart';

import 'package:makuna/utils/usuarioHelper.dart';

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
  String totalVendasMes = '0,00';
  String totalLucroMes = '0,00';
  String valorGasto = '0,00';
  String nomeClienteMenosCompra = '';
  String nomeClienteMaisCompra = '';

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
    getInventario();
    getVendasMensal();
    getComprasClientes();
  }

  Widget _buildList() {
    return Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(fontSize: 48),
          ),
          IconButton(
            onPressed: () => {refresh()},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      const Spacer(),
      CardHomeWidget(
          titulo: "Vendas",
          desc1: "Total de vendas no mês: $totalVendasMes",
          desc2: "Total de lucro no mês: $totalLucroMes"),
      const Spacer(),
      CardHomeWidget(
          titulo: "Inventário",
          desc1: "Total em produtos: $totalEmProdutos",
          desc2: "Produto mais lucrativo: $produtoMaisLucrativo"),
      const Spacer(),
      CardHomeWidget(
          titulo: "Clientes",
          desc1: "O que mais compra: $nomeClienteMaisCompra",
          desc2: "O que menos compra: $nomeClienteMenosCompra"),
      const Spacer(),
      CardHomeWidget(
          titulo: "Previsão e médias",
          desc1: "Lucro estimado:  $lucroEstimado",
          desc2: "Valor gasto mensal: $valorGasto"),
      const Spacer(),
    ]);
  }

  getInventario() async {
    List<Produto> result = await ProdutoDAO().readAll();
    if (result.isNotEmpty) {
      double totalEmProdutosSum = result.fold(
          0, (sum, item) => sum + item.valorVendaPrevisao * item.quantidade);

      result.sort((a, b) => (a.valorVendaPrevisao - a.valorCompra)
          .compareTo(b.valorVendaPrevisao - b.valorCompra));

      final double lucroEstimadoSum = result.fold(
          0, (sum, item) => sum + (item.valorVendaPrevisao - item.valorCompra));

      final double valorGastoSum =
          result.fold(0, (sum, item) => sum + item.valorCompra);

      final numberFormatBr = NumberFormat.simpleCurrency(locale: "pt_Br");

      final String totalEmProdutosString =
          numberFormatBr.format(totalEmProdutosSum);
      final String lucroEstimadoString =
          numberFormatBr.format(lucroEstimadoSum);
      final String valorGastoString = numberFormatBr.format(valorGastoSum);

      setState(() {
        totalEmProdutos = totalEmProdutosString;
        produtoMaisLucrativo = result.last.nome;
        lucroEstimado = lucroEstimadoString;
        valorGasto = valorGastoString;
      });
    }
  }

  getVendasMensal() async {
    List<VendaProduto> vendaProduto = await VendaProdutoDAO().readAll();

    double totalVendasMesSum =
        vendaProduto.fold(0, (sum, item) => sum + item.valorVenda);
    final numberFormatBr = NumberFormat.simpleCurrency(locale: "pt_Br");

    List<Produto> produtos = await ProdutoDAO().readAll();
    final double valorTotalCompra =
        produtos.fold(0, (sum, item) => sum + item.valorCompra);

    final double lucroMensal = totalVendasMesSum - valorTotalCompra;

    String totalVendasMesString = numberFormatBr.format(totalVendasMesSum);
    String totalLucroMensal = numberFormatBr.format(lucroMensal);

    setState(() {
      totalVendasMes = totalVendasMesString;
      totalLucroMes = totalLucroMensal;
    });
  }

  getComprasClientes() async {
    List<Venda> vendaProduto = await VendaDAO().readAll();
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
