import 'package:makuna/daos/scripts.dart';
import 'package:makuna/models/cliente.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

class ClienteDAO {
  Future<Database> getDatabase() async {
    Database db = await openDatabase(
        join(await getDatabasesPath(), 'cliente_database.db'),
        onCreate: ((db, version) {
      return db.execute(createTableCliente);
    }), version: 1);
    return db;
  }

  Future<List<Cliente>> readAll() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query("Cliente");

    final result = List.generate(maps.length, (index) {
      return Cliente(
        id: maps[index]['id'],
        nome: maps[index]['nome'],
        telefone: maps[index]['telefone'],
        email: maps[index]['email'],
        urlAvatar: maps[index]['urlAvatar'],
        dataCadastro: maps[index]['dataCadastro'],
      );
    });

    return result;
  }

  Future<Cliente> getOneById(int id) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.query("Cliente", where: ' id = ? ', whereArgs: [id]);

    final result = List.generate(maps.length, (index) {
      return Cliente(
        id: maps[index]['id'],
        nome: maps[index]['nome'],
        telefone: maps[index]['telefone'],
        email: maps[index]['email'],
        urlAvatar: maps[index]['urlAvatar'],
        dataCadastro: maps[index]['dataCadastro'],
      );
    }).first;

    return result;
  }

  Future<int> insertCliente(Cliente cliente) async {
    final db = await getDatabase();
    return db.insert("Cliente", cliente.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future deleteCliente(int id) async {
    final db = await getDatabase();
    return db.delete("Cliente", where: ' id = ? ', whereArgs: [id]);
  }
}
