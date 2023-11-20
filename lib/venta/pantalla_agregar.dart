import 'package:flutter/material.dart';
import '/venta/model.dart';
import '/venta/actions.dart';
import '/venta/pantalla_principal.dart';
import 'package:intl/intl.dart';

class AgregarVentaForm extends StatefulWidget {
  @override
  _AgregarVentaFormState createState() => _AgregarVentaFormState();
}

class _AgregarVentaFormState extends State<AgregarVentaForm> {
  final TextEditingController numeroFacturaController = TextEditingController();
  final TextEditingController precioVentaController = TextEditingController();
  DateTime fechaSeleccionada = DateTime.now();

  // Agrega controladores u otros campos si es necesario para el resto de los detalles de la venta
  Future<void> _seleccionarFechaHasta(BuildContext context) async {
    final seleccionada = await showDatePicker(
      context: context,
      initialDate: fechaSeleccionada,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (seleccionada != null && seleccionada != fechaSeleccionada) {
      setState(() {
        fechaSeleccionada = seleccionada;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Venta'),
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
              controller: numeroFacturaController,
              decoration: InputDecoration(labelText: 'Número de Factura'),
            ),
            Row(
              children: [
                Text('Fecha Hasta: '),
                Text(DateFormat('dd/MM/yyyy').format(fechaSeleccionada)),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _seleccionarFechaHasta(context),
                  child: Text('Seleccionar Fecha'),
                ),
              ],
            ),
            // Agrega campos adicionales si es necesario para el resto de los detalles de la venta

            ElevatedButton(
              onPressed: () {
                // Guardar la nueva venta en la base de datos
                final nuevaVenta = Venta(
                  numeroFactura: numeroFacturaController.text,
                  fecha: fechaSeleccionada,
                  precioVenta: 0.0,
                  // Asignación del precioVenta como double
                );

                VentaDatabaseProvider().insertVenta(nuevaVenta);

                // Después de la inserción, navega a la pantalla principal de ventas
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return VentaScreen(); // Reemplaza PantallaPrincipalVenta con tu pantalla principal de ventas
                }));
              },
              child: Text('Guardar Venta'),
            ),
          ],
        ),
      ),
    );
  }
}
