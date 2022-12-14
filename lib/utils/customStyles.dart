import 'package:flutter/material.dart';

const cardPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);

const listaVaziaTituloTextStyle = TextStyle(
  fontFamily: "Biennale",
  fontSize: 24,
  color: Colors.pinkAccent,
);

const listaVaziaDescTextStyle =
    TextStyle(fontFamily: "Biennale", fontSize: 16, color: Colors.black);

const dialogMessageTituloTextStyle = TextStyle(
  fontFamily: "Biennale",
  fontSize: 28,
  color: Colors.black,
);

const dialogMessageTextStyle = TextStyle(
  fontFamily: "Biennale",
  fontSize: 22,
  color: Colors.black,
);

const tituloCardTextStyle = TextStyle(fontSize: 20);
const descCardTextStyle = TextStyle(fontSize: 16, color: Colors.grey);

const tituloMenuTextStyle = TextStyle(fontSize: 20);
const descMenuTextStyle = TextStyle(fontSize: 18);

BoxDecoration cardBoxStyle() => BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(5));
