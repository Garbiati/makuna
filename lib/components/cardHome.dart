import 'package:flutter/material.dart';
import 'package:makuna/utils/customStyles.dart';

class CardHomeWidget extends StatelessWidget {
  const CardHomeWidget(
      {super.key,
      required this.titulo,
      required this.desc1,
      required this.desc2});

  final String titulo;
  final String desc1;
  final String desc2;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {},
          child: SizedBox(
            width: 350,
            height: 100,
            child: Column(children: [
              Text(
                titulo,
                style: tituloCardTextStyle,
              ),
              Text(
                desc1,
                style: descCardTextStyle,
              ),
              Text(
                desc2,
                style: descCardTextStyle,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
