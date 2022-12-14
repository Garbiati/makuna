import 'package:makuna/daos/scripts.dart';
import 'package:makuna/models/cliente.dart';
import 'package:makuna/models/usuario.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

class UsuarioDAO {
  Future<Database> getDatabase() async {
    Database db = await openDatabase(
        join(await getDatabasesPath(), 'usuario_database.db'),
        onCreate: ((db, version) {
      return db.execute(createTableUsuario);
    }), version: 1);
    return db;
  }

  Future<List<Usuario>> readAll() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query("Usuario");

    final result = List.generate(maps.length, (index) {
      return Usuario(
        id: maps[index]['id'],
        nome: maps[index]['nome'],
        sobreNome: maps[index]['sobreNome'],
        email: maps[index]['email'],
        usuario: maps[index]['usuario'],
        senha: maps[index]['senha'],
        ativo: maps[index]['ativo'],
      );
    });

    return result;
  }

  Future<Usuario> getOneById(int id) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.query("Usuario", where: ' id = ? ', whereArgs: [id]);

    final result = List.generate(maps.length, (index) {
      return Usuario(
        id: maps[index]['id'],
        nome: maps[index]['nome'],
        sobreNome: maps[index]['sobreNome'],
        email: maps[index]['email'],
        usuario: maps[index]['usuario'],
        senha: maps[index]['senha'],
        ativo: maps[index]['ativo'],
      );
    }).first;

    return result;
  }

  Future<int> insertUsuario(Usuario usuario) async {
    final db = await getDatabase();
    return db.insert("Usuario", usuario.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateUsuario(Usuario usuario) async {
    final db = await getDatabase();
    return db.update("Usuario", usuario.toMap(),
        where: ' id = ? ', whereArgs: [usuario.id]);
  }

  Future deleteUsuario(int id) async {
    final db = await getDatabase();
    return db.delete("Usuario", where: ' id = ? ', whereArgs: [id]);
  }
}
