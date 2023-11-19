import '/venta/model.dart'; // Reemplaza 'administracion_ventas' con la ruta correcta de tu modelo de Venta
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class VentaDatabaseProvider {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(),
        'ventas_database.db'); // Cambia el nombre del archivo de la base de datos
    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) {
        db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE ventas(
            idVenta INTEGER PRIMARY KEY AUTOINCREMENT,
            numeroFactura TEXT,
            fecha TEXT,
            precioVenta REAL
          )
        ''');
      },
    );
  }

  Future<void> insertVenta(Venta venta) async {
    final db = await database;
    await db.insert('ventas', venta.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Venta>> getAllVentas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('ventas');
    return List.generate(maps.length, (index) {
      return Venta.fromJson(maps[index]);
    });
  }

  Future<void> updateCost(int idVenta, double precio) async {
    final db = await database;

    // Obtener el precio actual de la venta
    final List<Map<String, dynamic>> result = await db.query(
      'ventas',
      columns: ['precioVenta'],
      where: 'idVenta = ?',
      whereArgs: [idVenta],
    );

    if (result.isNotEmpty) {
      final double currentPrice = result.first['precioVenta'] as double;

      // Sumar el precio proporcionado al precio actual
      final double newPrice = currentPrice + precio;

      // Actualizar el precio en la base de datos
      await db.update(
        'ventas',
        {'precioVenta': newPrice},
        where: 'idVenta = ?',
        whereArgs: [idVenta],
      );
    }
  }

  Future<void> updateVenta(Venta venta) async {
    final db = await database;
    await db.update(
      'ventas',
      venta.toJson(),
      where: 'idVenta = ?',
      whereArgs: [venta.idVenta],
    );
  }

  Future<void> deleteVenta(int idVenta) async {
    final db = await database;
    await db.delete(
      'ventas',
      where: 'idVenta = ?',
      whereArgs: [idVenta],
    );
  }
}
