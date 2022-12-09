class Usuario {
  final int? id;
  final String nome;
  final String email;
  final String usuario;
  final String senha;
  final int ativo;

  Usuario(
      {this.id,
      required this.nome,
      required this.email,
      required this.usuario,
      required this.senha,
      required this.ativo});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "email": email,
      "usuario": usuario,
      "senha": senha,
      "ativo": ativo,
    };
  }
}
