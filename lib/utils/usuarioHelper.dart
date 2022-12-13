import 'package:makuna/models/usuario.dart';

const int usuarioId = 1;

Usuario GetUsuario(int usuarioId) {
  return Usuario(
      nome: "Alessandro",
      email: "a.garbiati@gmail.com",
      usuario: "agarbiati",
      senha: "123",
      ativo: 1);
}
