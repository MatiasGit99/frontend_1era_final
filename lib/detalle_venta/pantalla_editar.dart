import 'package:flutter/material.dart';
import '/detalle_venta/model.dart';
import '/detalle_venta/actions.dart';
import '/venta/pantalla_principal.dart';
import '/detalle_venta/pantalla_principal.dart';

class EditarDetalleVentaScreen extends StatefulWidget {
  final DetalleVenta detalleVenta;

  EditarDetalleVentaScreen({required this.detalleVenta});

  @override
  _EditarDetalleVentaScreenState createState() =>
      _EditarDetalleVentaScreenState();
}

class _EditarDetalleVentaScreenState extends State<EditarDetalleVentaScreen> {
  TextEditingController cantidadController = TextEditingController();
  TextEditingController idProductoController = TextEditingController();
  TextEditingController nombreProductoController = TextEditingController();
  TextEditingController precioProductoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cantidadController.text = widget.detalleVenta.cantidad.toString();
    idProductoController.text = widget.detalleVenta.idProducto.toString();
    nombreProductoController.text = widget.detalleVenta.nombre_producto;
    precioProductoController.text =
        widget.detalleVenta.precioProducto.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Detalle de Venta'),
           leading: IconButton(
          // Agrega el botón de retroceso aquí
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return VentaScreen();
                }));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cantidadController,
              decoration: InputDecoration(labelText: 'Cantidad'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: idProductoController,
              decoration: InputDecoration(labelText: 'ID de Producto'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: nombreProductoController,
              decoration: InputDecoration(labelText: 'Nombre de Producto'),
            ),
            TextField(
              controller: precioProductoController,
              decoration: InputDecoration(labelText: 'Precio de Producto'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                // Guardar los cambios del detalle de venta en la base de datos.
                final detalleVentaActualizado = DetalleVenta(
                  idDetalleVenta: widget.detalleVenta.idDetalleVenta,
                  idVenta: widget.detalleVenta.idVenta,
                  cantidad: int.parse(cantidadController.text),
                  idProducto: int.parse(idProductoController.text),
                  nombre_producto: nombreProductoController.text,
                  precioProducto: double.parse(precioProductoController.text),
                );
                DetalleVentaDatabaseProvider()
                    .updateDetalleVenta(detalleVentaActualizado);

                // Después de la actualización, navegar a la pantalla principal de ventas
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return VentaScreen(); // Navegar a la nueva pantalla
                }));
              },
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
