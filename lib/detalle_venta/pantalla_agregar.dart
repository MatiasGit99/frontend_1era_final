import 'package:flutter/material.dart';
import 'package:frontend_1era_final/administracion_productos/model.dart';
import 'package:frontend_1era_final/venta/model.dart';
import '/detalle_venta/model.dart';
import '/detalle_venta/actions.dart';
import '/detalle_venta/pantalla_principal.dart';
import '/administracion_productos/actions.dart';
import '/venta/actions.dart';
import '/venta/pantalla_principal.dart';
import '/main.dart';
import 'package:intl/intl.dart';

class AgregarDetalleVentaForm extends StatefulWidget {
  late int idVenta; // Variable para almacenar idVenta
  AgregarDetalleVentaForm(this.idVenta); // Constructor para recibir idVenta

  @override
  _AgregarDetalleVentaFormState createState() =>
      _AgregarDetalleVentaFormState();
}

class _AgregarDetalleVentaFormState extends State<AgregarDetalleVentaForm> {
  late int idVenta; // Variable para almacenar idVenta
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController nombreProductoController =
      TextEditingController();
  final TextEditingController precioProductoController =
      TextEditingController();
  Producto? productoSeleccionado;
  List<Producto> listaProductos = [];
  // Puedes agregar controladores o campos adicionales si es necesario para el resto de los detalles del detalle de la venta
  @override
  void initState() {
    super.initState();
    idVenta = widget.idVenta; // Obtener el valor de idVenta desde widget
    cargarProductos();
  }

  Future<void> cargarProductos() async {
    final productos = await ProductoDatabaseProvider().getAllProductos();
    setState(() {
      listaProductos = productos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Detalle Venta'),
            leading: IconButton(
          // Agrega el botón de retroceso aquí
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return VentasListScreen();
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
            DropdownButtonFormField<Producto>(
              value: productoSeleccionado,
              onChanged: (Producto? newValue) {
                setState(() {
                  productoSeleccionado = newValue;
                });
              },
              items: listaProductos.map((Producto producto) {
                return DropdownMenuItem<Producto>(
                  value: producto,
                  child: Text(
                      '${producto.nombre_producto} ${producto.precioVenta}'),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Producto y precio Gs.'),
            ),
            // Puedes agregar más campos según los detalles de tu DetalleVenta

            ElevatedButton(
              onPressed: () {
                // Guardar el nuevo detalle de venta en la base de datos
                final nuevoDetalleVenta = DetalleVenta(
                  idVenta: idVenta,
                  cantidad: int.tryParse(cantidadController.text) ?? 1,
                  idProducto: productoSeleccionado!.idProducto!,
                  nombre_producto: productoSeleccionado!.nombre_producto!,
                  precioProducto: productoSeleccionado!.precioVenta!,
                  // Asignación del precioProducto como double
                );
                final result = (nuevoDetalleVenta.cantidad! *
                    nuevoDetalleVenta.precioProducto);

                VentaDatabaseProvider().updateCost(idVenta, result);

                DetalleVentaDatabaseProvider()
                    .insertDetalleVenta(nuevoDetalleVenta);

                // Después de la inserción, navegar a la pantalla principal de detalle de ventas
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return VentaScreen();
                }));
              },
              child: Text('Guardar Detalle Venta'),
            ),
          ],
        ),
      ),
    );
  }
}
