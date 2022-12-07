import 'package:makuna/daos/cliente_dao.dart';
import 'package:makuna/models/cliente.dart';

String buscarNomeClientePorId(int id) {
  String nome = "a";

  ClienteDAO().getOneById(id).then((value) {
      nome = value.nome;
  });
  return nome;
}
