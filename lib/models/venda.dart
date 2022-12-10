class Venda {
  int? id;
  final int usuarioId;
  final String order;
  final int clienteId;
  final String detail;
  final double valorTotalVenda;
  final String dataVenda;
  final int ativo;

  Venda({
    this.id,
    required this.usuarioId,
    required this.order,
    required this.clienteId,
    required this.detail,
    required this.dataVenda,
    required this.valorTotalVenda,
    required this.ativo,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "usuarioId": usuarioId,
      "order": order,
      "clienteId": clienteId,
      "detail": detail,
      "dataVenda": dataVenda,
      "valorTotalVenda": valorTotalVenda,
      "ativo": ativo
    };
  }
}
