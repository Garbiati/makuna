class Cliente {
  int? id;
  final String nome;
  final String telefone;
  final String? email;
  final String urlAvatar;
  final String dataCadastro;

  Cliente({
    this.id,
    required this.nome,
    required this.telefone,
    this.email,
    required this.urlAvatar,
    required this.dataCadastro,
  });

  Map<String, dynamic> toMap() {
    return {"id": id, 
    "nome": nome, 
    "telefone": telefone,
    "email": email,
    "urlAvatar": urlAvatar,
    "dataCadastro": dataCadastro,
    
    };
  }
}
