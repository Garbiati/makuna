import 'package:makuna/daos/scripts.dart';
import 'package:makuna/models/vendaProduto.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

class VendaProdutoDAO {
  Future<Database> getDatabase() async {
    Database db = await openDatabase(
        join(await getDatabasesPath(), 'vendaProduto_database.db'),
        onCreate: ((db, version) {
      return db.execute(createTableVendaProduto);
    }), version: 1);
    return db;
  }

  Future<List<VendaProduto>> readAll() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query("VendaProduto");

    final result = List.generate(maps.length, (index) {
      return VendaProduto(
        id: maps[index]['id'],
        usuarioId: maps[index]['usuarioId'],
        vendaId: maps[index]['vendaId'],
        produtoId: maps[index]['produtoId'],
        valorVenda: maps[index]['valorVenda'],
        quantidade: maps[index]['quantidade'],
      );
    });

    return result;
  }

  Future<List<VendaProduto>> readByVendaId(int vendaId) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db
        .query("VendaProduto", where: ' vendaId = ? ', whereArgs: [vendaId]);

    final result = List.generate(maps.length, (index) {
      return VendaProduto(
        id: maps[index]['id'],
        usuarioId: maps[index]['usuarioId'],
        vendaId: maps[index]['vendaId'],
        produtoId: maps[index]['produtoId'],
        valorVenda: maps[index]['valorVenda'],
        quantidade: maps[index]['quantidade'],
      );
    });

    return result;
  }

  Future<int> insertVendaProduto(VendaProduto vendaProduto) async {
    final db = await getDatabase();
    return db.insert("VendaProduto", vendaProduto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateVendaProduto(VendaProduto vendaProduto) async {
    final db = await getDatabase();
    return db.update("VendaProduto", vendaProduto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: ' id = ? ',
        whereArgs: [vendaProduto.id]);
  }

  Future deleteVendaProduto(int id) async {
    final db = await getDatabase();
    return db.delete("VendaProduto", where: ' id = ? ', whereArgs: [id]);
  }
}
