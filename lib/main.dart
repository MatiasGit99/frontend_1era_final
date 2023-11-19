import 'package:flutter/material.dart';
import '/administracion_productos/pantalla_principal.dart';
import '/clientes/pantalla_principal.dart';
import 'administracion_categorias/pantalla_principal.dart';
import 'venta/pantalla_principal.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ventas de Productos',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: VentasListScreen(),
    );
  }
}

class VentasListScreen extends StatefulWidget {
  @override
  _VentasListScreenState createState() => _VentasListScreenState();
}

class _VentasListScreenState extends State<VentasListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sistema de ventas de productos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return AdministracionCategoriasScreen(); // Navegar a la nueva pantalla
                }));
              },
              child: Text('Administración de categorías'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return ProductoScreen(); // Navegar a la nueva pantalla
                }));
               // Acción para 'Administración de pacientes y doctores'
              },
              child: Text('Administración de productos'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return AdministracionClientesScreen(); // Navegar a la nueva pantalla
                })); // Acción para 'Reserva de turnos'
              },
              child: Text('Administracion de clientes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return VentaScreen(); // Navegar a la nueva pantalla
                })); // Acción para 'Reserva de turnos'
              },
              child: Text('Ventas'),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      //       return AddClientScreen();
      //     }));
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}