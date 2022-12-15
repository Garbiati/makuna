import 'package:flutter/material.dart';

const double widthQTD = 35;
const double widthDesc = 200;
const double widthValor = 75;

const String descHeadQTD = "QTD.";
const String descHeadDesc = "Descrição do produto.";
const String descHeadValor = "Valor R\$:";

const TextAlign alinhamentoItens = TextAlign.start;

const TextStyle valorTotalStyle = TextStyle(fontSize: 20);

Widget getValorTotal(String valorTotal) {
  return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          child: Text(
            "Valor total: $valorTotal",
            style: valorTotalStyle,
            textAlign: TextAlign.end,
          ),
        ),
      ]);
}

Widget getProdutoRow(String qtd, String desc, String valor) {
  return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 35,
          child: Text(
            qtd,
            textAlign: alinhamentoItens,
          ),
        ),
        SizedBox(
          width: 200,
          child: Text(
            desc,
            textAlign: alinhamentoItens,
          ),
        ),
        SizedBox(
          width: 75,
          child: Text(
            valor,
            textAlign: TextAlign.end,
          ),
        ),
      ]);
}

Widget getHeader() {
  return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SizedBox(
          width: widthQTD,
          child: Text(
            descHeadQTD,
            textAlign: alinhamentoItens,
          ),
        ),
        SizedBox(
          width: widthDesc,
          child: Text(
            descHeadDesc,
            textAlign: alinhamentoItens,
          ),
        ),
        SizedBox(
          width: widthValor,
          child: Text(
            descHeadValor,
            textAlign: TextAlign.end,
          ),
        ),
      ]);
}
