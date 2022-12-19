import 'package:makuna/daos/usuario_dao.dart';
import 'package:makuna/models/usuario.dart';

const int usuarioId = 1;

void criaUsuarioInicial() async {
  List<Usuario> usuarios = [];
  usuarios = await UsuarioDAO().readAll();

  if (usuarios.isEmpty) {
    UsuarioDAO().insertUsuario(Usuario(
        nome: "Usuario",
        sobreNome: "",
        email: "usuario@usuario.com",
        usuario: "usuario",
        senha: "senha123",
        ativo: 1));
  }
}

Usuario getUsuario(int usuarioId) {
  return Usuario(
      nome: "Usuario",
      sobreNome: "",
      email: "usuario@usuario.com",
      usuario: "usuario",
      senha: "senha123",
      ativo: 1);
}
