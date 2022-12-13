import 'package:makuna/daos/scripts.dart';
import 'package:makuna/models/venda.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

class VendaDAO {
  Future<Database> getDatabase() async {
    Database db =
        await openDatabase(join(await getDatabasesPath(), 'venda_database.db'),
            onCreate: ((db, version) {
      return db.execute(createTableVenda);
    }), version: 1);
    return db;
  }

  Future<List<Venda>> readAll() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query("Venda");

    final result = List.generate(maps.length, (index) {
      return Venda(
        id: maps[index]['id'],
        usuarioId: maps[index]['usuarioId'],
        orderNumber: maps[index]['orderNumber'],
        clienteId: maps[index]['clienteId'],
        detail: maps[index]['detail'],
        dataVenda: maps[index]['dataVenda'],
        valorTotalVenda: maps[index]['valorTotalVenda'],
        ativo: maps[index]['ativo'],
      );
    });

    return result;
  }

  Future<int> insertVenda(Venda produto) async {
    final db = await getDatabase();
    return db.insert("Venda", produto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateVenda(Venda produto) async {
    final db = await getDatabase();
    return db.update("Venda", produto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: ' id = ? ',
        whereArgs: [produto.id]);
  }

  Future deleteVenda(int id) async {
    final db = await getDatabase();
    return db.delete("Venda", where: ' id = ? ', whereArgs: [id]);
  }
}
