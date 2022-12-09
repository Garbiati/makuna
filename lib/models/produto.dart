class Produto {
  int? id;
  final int usuarioId;
  final String codigoProduto;
  final String nome;
  final String descricao;
  final double valorCompra;
  final double valorVendaPrevisao;
  final int quantidade;
  final String dataCompra;
  final int ativo;

  Produto({
    this.id,
    required this.usuarioId,
    required this.codigoProduto,
    required this.nome,
    required this.descricao,
    required this.valorCompra,
    required this.valorVendaPrevisao,
    required this.quantidade,
    required this.dataCompra,
    required this.ativo,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "usuarioId": usuarioId,
      "codigoProduto": codigoProduto,
      "nome": nome,
      "descricao": descricao,
      "valorCompra": valorCompra,
      "valorVendaPrevisao": valorVendaPrevisao,
      "quantidade": quantidade,
      "dataCompra": dataCompra,
      "ativo": ativo,
    };
  }
}
