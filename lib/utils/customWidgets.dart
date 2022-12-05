import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget divisorList() => const Divider(
  height: 2,
  color: Colors.black12,
);

Widget buildSvgIcon(String path) => SvgPicture.asset(
  path, 
  width: 48, 
  height: 48);

const addIcon = Icon(Icons.add);
const salvarText = Text("Salvar");