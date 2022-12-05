class Venda {
  int? id;
  final int clienteId;
  final int produtoId;
  final double valorVenda;
  final String descricao;
  final DateTime dataVenda;

  Venda(
      {this.id,
      required this.clienteId,
      required this.produtoId,
      required this.valorVenda,
      required this.descricao,
      required this.dataVenda});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "clienteId": clienteId,
      "produtoId": produtoId,
      "valorVenda": valorVenda,
      "descricao": descricao,
      "dataVenda": dataVenda
    };
  }
}
