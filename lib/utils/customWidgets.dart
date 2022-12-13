import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makuna/utils/customStyles.dart';

Widget divisorList() => const Divider(
      height: 2,
      color: Colors.black12,
    );

Widget buildSvgIcon(String path) =>
    SvgPicture.asset(path, width: 48, height: 48);

Widget exibirListaVazia(BuildContext context, String titulo) => Padding(
    padding: cardPadding,
    child: Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("images/Vectorvazio.svg", width: 70, height: 70),
            Text(titulo,
                style: listaVaziaTituloTextStyle, overflow: TextOverflow.clip),
            Row(
              children: [
                const Text("Dúvidas? clique aqui:",
                    style: listaVaziaDescTextStyle),
                IconButton(
                  icon: const Icon(Icons.help),
                  iconSize: 30,
                  onPressed: () => exibirMensagem(context, "Novo cadastro",
                      "Para criar um novo registro, utilize o botão + no canto superior direito da tela."),
                )
              ],
            )
          ],
        )
      ],
    )));

Future<void> exibirMensagem(
    BuildContext context, String titulo, String conteudo) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Text(
            titulo,
            style: dialogMessageTituloTextStyle,
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: 450,
            height: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/criarRegistro.png",
                    width: 200, height: 200),
                Text(
                  conteudo,
                  style: dialogMessageTextStyle,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

const addIcon = Icon(Icons.add);
const salvarText = Text("Salvar");
const voltarText = Text("Voltar");
