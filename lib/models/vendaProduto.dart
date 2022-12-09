class VendaProduto {
  int? id;
  final int usuarioId;
  int vendaId;
  final int produtoId;
  final int quantidade;

  VendaProduto(
      {this.id,
      required this.usuarioId,
      required this.vendaId,
      required this.produtoId,
      required this.quantidade});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "usuarioId": usuarioId,
      "vendaId": vendaId,
      "produtoId": produtoId,
      "quantidade": quantidade,
    };
  }
}
