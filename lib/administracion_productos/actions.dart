import '/administracion_productos/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductoDatabaseProvider {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path =
        join(await getDatabasesPath(), 'productos_database.db');
    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) {
        db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE productos(
            idProducto INTEGER PRIMARY KEY AUTOINCREMENT,
            codigo TEXT,
            nombre_producto TEXT,
            idCategoria INTEGER,
            categoria_nombre TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertProducto(Producto Producto) async {
    final db = await database;
    await db.insert('productos', Producto.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Producto>> getAllProductos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('productos');
    return List.generate(maps.length, (index) {
      return Producto.fromJson(maps[index]);
    });
  }

  Future<void> updateProducto(Producto Producto) async {
    final db = await database;
    await db.update(
      'productos',
      Producto.toJson(),
      where: 'idProducto = ?',
      whereArgs: [Producto.idProducto],
    );
  }

  Future<void> deleteProducto(int idProducto) async {
    final db = await database;
    await db.delete(
      'productos',
      where: 'idProducto = ?',
      whereArgs: [idProducto],
    );
  }
}
