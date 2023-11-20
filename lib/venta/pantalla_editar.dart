import 'package:flutter/material.dart';
import '/venta/model.dart';
import '/venta/actions.dart';
import '/venta/pantalla_principal.dart';

class EditarVentaScreen extends StatefulWidget {
  final Venta venta;

  EditarVentaScreen({required this.venta});

  @override
  _EditarVentaScreenState createState() => _EditarVentaScreenState();
}

class _EditarVentaScreenState extends State<EditarVentaScreen> {
  TextEditingController numeroFacturaController = TextEditingController();
  TextEditingController precioVentaController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    numeroFacturaController.text = widget.venta.numeroFactura;
    precioVentaController.text = widget.venta.precioVenta.toString();
    emailController.text = widget.venta.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Venta'),
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
            TextField(
              controller: precioVentaController,
              decoration: InputDecoration(labelText: 'Precio de Venta'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
              keyboardType: TextInputType.emailAddress,
            ),
            ElevatedButton(
              onPressed: () {
                // Guardar los cambios de la venta en la base de datos.
                final ventaActualizada = Venta(
                  idVenta: widget.venta.idVenta,
                  numeroFactura: numeroFacturaController.text,
                  precioVenta: double.parse(precioVentaController.text),
                  idCliente: widget.venta.idCliente,
                  email: emailController.text,
                  fecha: widget.venta.fecha, // La fecha no se actualiza en esta pantalla
                );
                VentaDatabaseProvider().updateVenta(ventaActualizada);

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
