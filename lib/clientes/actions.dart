import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '/clientes/model.dart';

class ClienteDatabaseProvider {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path =
        join(await getDatabasesPath(), 'clientes_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
    CREATE TABLE clientes(
      idPersona INTEGER PRIMARY KEY AUTOINCREMENT,
      nombre TEXT,
      apellido TEXT,
      ruc TEXT,
      email TEXT
    )
  ''');
      },
    );
  }



  Future<List<Cliente>> getAllClientes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('clientes');
    return List.generate(maps.length, (index) {
      return Cliente.fromJson(maps[index]);
    });
  }

  Future<void> insertCliente(Cliente Cliente) async {
    final db = await database;
    print(Cliente.idPersona);
    await db.insert('clientes', Cliente.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Cliente>> getAllPacientesDoctores() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('clientes');
    return List.generate(maps.length, (index) {
      return Cliente.fromJson(maps[index]);
    });
  }

  Future<Cliente?> getClienteById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'clientes',
      where: 'idPersona = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Cliente.fromJson(maps.first);
    } else {
      return null; // Si no se encontró ningún Cliente con ese ID
    }
  }

  Future<void> updateCliente(Cliente Cliente) async {
    final db = await database;
    await db.update(
      'clientes',
      Cliente.toJson(),
      where: 'idPersona = ?',
      whereArgs: [Cliente.idPersona],
    );
  }

  Future<void> deleteCliente(int idPersona) async {
    final db = await database;
    await db.delete(
      'clientes',
      where: 'idPersona = ?',
      whereArgs: [idPersona],
    );
  }
}
