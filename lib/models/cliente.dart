class Cliente {
  int? id;
  final int usuarioId;
  final String nome;
  final String telefone;
  final String email;
  final String urlAvatar;
  final String dataCadastro;
  final int ativo;
  final String? endereco;
  final String? numero;
  final String? bairro;
  final String? cep;
  final String? cidade;
  final String? estado;

  Cliente(
      {this.id,
      required this.usuarioId,
      required this.nome,
      required this.telefone,
      required this.email,
      required this.urlAvatar,
      required this.dataCadastro,
      required this.ativo,
      this.endereco,
      this.numero,
      this.bairro,
      this.cep,
      this.cidade,
      this.estado});

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
      "endereco": endereco,
      "numero": numero,
      "cep": cep,
      "cidade": cidade,
      "estado": estado
    };
  }
}
