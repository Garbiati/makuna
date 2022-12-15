import 'package:makuna/daos/scripts.dart';
import 'package:makuna/models/produto.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

class ProdutoDAO {
  Future<Database> getDatabase() async {
    Database db = await openDatabase(
        join(await getDatabasesPath(), 'produto_database.db'),
        onCreate: ((db, version) {
      return db.execute(createTableProduto);
    }), version: 1);
    return db;
  }

  Future<List<Produto>> readAll() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query("Produto");

    final result = List.generate(maps.length, (index) {
      return Produto(
        id: maps[index]['id'],
        usuarioId: maps[index]['usuarioId'],
        codigoProduto: maps[index]['codigoProduto'],
        nome: maps[index]['nome'],
        descricao: maps[index]['descricao'],
        valorCompra: maps[index]['valorCompra'],
        valorVendaPrevisao: maps[index]['valorVendaPrevisao'],
        quantidade: maps[index]['quantidade'],
        dataCompra: maps[index]['dataCompra'],
        ativo: maps[index]['ativo'],
      );
    });

    return result;
  }



  Future readProduto(int id) async {
    final db = await getDatabase();
    return db.query("Produto", where: ' id = ? ', whereArgs: [id]);
  }

  Future<int> insertProduto(Produto produto) async {
    final db = await getDatabase();
    return db.insert("Produto", produto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateProduto(Produto produto) async {
    final db = await getDatabase();
    return db.update(
      "Produto",
      produto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: ' id = ? ',
      whereArgs: [produto.id],
    );
  }

  Future deleteProduto(int id) async {
    final db = await getDatabase();
    return db.delete("Produto", where: ' id = ? ', whereArgs: [id]);
  }
}
