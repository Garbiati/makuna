import 'package:makuna/daos/cliente_dao.dart';

String buscarNomeClientePorId(int id) {
  String nome = "a";

  ClienteDAO().getOneById(id).then((value) {
      nome = value.nome;
  });
  return nome;
}
