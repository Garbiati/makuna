import 'package:makuna/models/produto.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

class ProdutoDAO {
  Future<Database> getDatabase() async {
    Database db = await openDatabase(
        join(await getDatabasesPath(), 'produto_database.db'),
        onCreate: ((db, version) {
      return db.execute(
          "CREATE TABLE Produto(id INTEGER PRIMARY KEY, nome TEXT, descricao TEXT, dataCompra TEXT, valorCompra DOUBLE, valorVendaPrevisao DOUBLE)");
    }), version: 1);
    return db;
  }

  Future<List<Produto>> readAll() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query("Produto");

    final result = List.generate(maps.length, (index) {
      return Produto(
        id: maps[index]['id'],
        nome: maps[index]['nome'],
        descricao: maps[index]['descricao'],
        dataCompra: maps[index]['dataCompra'],
        valorCompra: maps[index]['valorCompra'],
        valorVendaPrevisao: maps[index]['valorVendaPrevisao'],
      );
    });

    return result;
  }

  Future<int> insertProduto(Produto produto) async {
    final db = await getDatabase();
    return db.insert("Produto", produto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future deleteProduto(int id) async {
    final db = await getDatabase();
    return db.delete("Produto", where: ' id = ? ', whereArgs: [id]);
  }
}
