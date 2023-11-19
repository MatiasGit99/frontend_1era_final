import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '/detalle_venta/model.dart';


class DetalleVentaDatabaseProvider {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path =
        join(await getDatabasesPath(), 'detalle_ventas_database.db');
    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) {
        db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE detalle_ventas(
            idDetalleVenta INTEGER PRIMARY KEY AUTOINCREMENT,
            idVenta INTEGER,
            cantidad INTEGER,
            idProducto INTEGER,
            nombre_producto TEXT,
            precioProducto REAL
          )
        ''');
      },
    );
  }

  Future<void> insertDetalleVenta(DetalleVenta detalleVenta) async {
    final db = await database;
    await db.insert('detalle_ventas', detalleVenta.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<DetalleVenta>> getAllDetalleVentas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('detalle_ventas');
    return List.generate(maps.length, (index) {
      return DetalleVenta.fromJson(maps[index]);
    });
  }



  Future<void> updateDetalleVenta(DetalleVenta detalleVenta) async {
    final db = await database;
    await db.update(
      'detalle_ventas',
      detalleVenta.toJson(),
      where: 'idDetalleVenta = ?',
      whereArgs: [detalleVenta.idDetalleVenta],
    );
  }

  Future<void> deleteDetalleVenta(int idDetalleVenta) async {
    final db = await database;
    await db.delete(
      'detalle_ventas',
      where: 'idDetalleVenta = ?',
      whereArgs: [idDetalleVenta],
    );
  }
}
