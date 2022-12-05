import 'package:makuna/models/venda.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

class VendaDAO {
  Future<Database> getDatabase() async {
    Database db =
        await openDatabase(join(await getDatabasesPath(), 'venda_database.db'),
            onCreate: ((db, version) {
      return db.execute(
          "CREATE TABLE Venda(id INTEGER PRIMARY KEY, clienteId INT, produtoId INT, dataCompra DATETIME, valorCompra DOUBLE, valorVendaPrevisao DOUBLE, dataVenda DATETIME)");
    }), version: 1);
    return db;
  }

  Future<List<Venda>> readAll() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query("Produto");

    final result = List.generate(maps.length, (index) {
      return Venda(
        id: maps[index]['id'],
        clienteId: maps[index]['clienteId'],
        produtoId: maps[index]['produtoId'],
        valorVenda: maps[index]['valorVenda'],
        descricao: maps[index]['telefone'],
        dataVenda: maps[index]['dataVenda'],
      );
    });

    return result;
  }

  Future<int> insertVenda(Venda produto) async {
    final db = await getDatabase();
    return db.insert("Venda", produto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future deleteVenda(int id) async {
    final db = await getDatabase();
    return db.delete("Venda", where: ' id = ? ', whereArgs: [id]);
  }
}
