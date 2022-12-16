import 'package:flutter/material.dart';
import 'package:makuna/utils/customStyles.dart';

class CardHomeWidget extends StatelessWidget {
  const CardHomeWidget({
    super.key,
    required this.titulo,
    required this.desc1,
    required this.desc2,
    required this.icon,
    required this.iconColor,
  });

  final String titulo;
  final String desc1;
  final String desc2;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: const Color(0x802196F3),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {},
          child: SizedBox(
            width: 350,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 190,
                      child: Text(
                        titulo,
                        style: tituloCardTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Material(
                          color: iconColor,
                          borderRadius: BorderRadius.circular(24.0),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(icon, color: Colors.white, size: 20.0),
                          ))),
                    )
                  ],
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
      ),
    );
  }
}
