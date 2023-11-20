import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '/factura/model.dart';


class FacturaDatabaseProvider {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path =
        join(await getDatabasesPath(), 'facturas_database.db');
    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) {
        db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE facturas(
            idFactura INTEGER PRIMARY KEY AUTOINCREMENT,
            idVenta INTEGER,
            numeroFactura TEXT,
            fecha TEXT,
            precioVenta REAL
          )
        ''');
      },
    );
  }

  Future<void> insertFactura(Factura detalleVenta) async {
    final db = await database;
    await db.insert('facturas', detalleVenta.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Factura>> getAllFacturas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('facturas');
    return List.generate(maps.length, (index) {
      return Factura.fromJson(maps[index]);
    });
  }



  Future<void> updateFactura(Factura detalleVenta) async {
    final db = await database;
    await db.update(
      'facturas',
      detalleVenta.toJson(),
      where: 'idFactura = ?',
      whereArgs: [detalleVenta.idFactura],
    );
  }

  Future<void> deleteFactura(int idFactura) async {
    final db = await database;
    await db.delete(
      'facturas',
      where: 'idFactura = ?',
      whereArgs: [idFactura],
    );
  }
}
