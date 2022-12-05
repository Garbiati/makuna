class Cliente {
  int? id;
  final String nome;
  final String telefone;

  Cliente({this.id, required this.nome, required this.telefone});

  Map<String, dynamic> toMap() {
    return {"id": id, "nome": nome, "telefone": telefone};
  }
}
