class Produto {
  int? id;
  final String nome;
  final String descricao;
  final String dataCompra;
  final double valorCompra;
  final double valorVendaPrevisao;

  Produto(
      {this.id,
      required this.nome,
      required this.descricao,
      required this.dataCompra,
      required this.valorCompra,
      required this.valorVendaPrevisao});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "descricao": descricao,
      "dataCompra": dataCompra,
      "valorCompra": valorCompra,
      "valorVendaPrevisao": valorVendaPrevisao,
    };
  }
}
