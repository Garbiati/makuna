class Venda {
  int? id;
  final int usuarioId;
  final String orderNumber;
  final int clienteId;
  final String detail;
  final double valorTotalVenda;
  final String dataVenda;
  final int ativo;

  Venda({
    this.id,
    required this.usuarioId,
    required this.orderNumber,
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
      "orderNumber": orderNumber,
      "clienteId": clienteId,
      "detail": detail,
      "dataVenda": dataVenda,
      "valorTotalVenda": valorTotalVenda,
      "ativo": ativo
    };
  }
}
