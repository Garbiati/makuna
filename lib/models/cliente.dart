class Cliente {
  int? id;
  final int usuarioId;
  final String nome;
  final String telefone;
  final String email;
  final String urlAvatar;
  final String dataCadastro;
  final int ativo;

  Cliente(
      {this.id,
      required this.usuarioId,
      required this.nome,
      required this.telefone,
      required this.email,
      required this.urlAvatar,
      required this.dataCadastro,
      required this.ativo});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "usuarioId": usuarioId,
      "nome": nome,
      "telefone": telefone,
      "email": email,
      "urlAvatar": urlAvatar,
      "dataCadastro": dataCadastro,
      "ativo": ativo,
    };
  }
}
