import 'package:flutter/material.dart';
import 'package:frontend_1era_final/administracion_productos/model.dart';
import 'package:frontend_1era_final/venta/model.dart';
import 'package:frontend_1era_final/venta/actions.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '/factura/model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import '/factura/actions.dart';
import '/administracion_productos/actions.dart';
import '/venta/pantalla_principal.dart';
import '/venta/actions.dart';
import '/detalle_venta/pantalla_principal.dart';
import '/detalle_venta/actions.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:io'; // Asegúrate de importar 'dart:io' para acceder a la clase File

class AgregarFacturaForm extends StatefulWidget {
  late int idVenta; // Variable para almacenar idVenta
  AgregarFacturaForm(this.idVenta); // Constructor para recibir idVenta

  @override
  _AgregarFacturaFormState createState() => _AgregarFacturaFormState();
}

class _AgregarFacturaFormState extends State<AgregarFacturaForm> {
  late int idVenta; // Variable para almacenar idVenta
  Producto? productoSeleccionado;
  List<Producto> listaProductos = [];
  // Puedes agregar controladores o campos adicionales si es necesario para el resto de los detalles del detalle de la venta
  @override
  void initState() {
    super.initState();
    idVenta = widget.idVenta; // Obtener el valor de idVenta desde widget
    crearFactura(idVenta);
  }

  Future<void> crearFactura(int idVenta) async {
    final venta = await VentaDatabaseProvider().getVenta(idVenta);

    final nuevoFactura = Factura(
      idVenta: idVenta,
      numeroFactura: venta!.numeroFactura!,
      fecha: venta!.fecha,
      precioVenta: venta.precioVenta,
    );
    // sendMail();
    exportToPDF(idVenta);
    FacturaDatabaseProvider().insertFactura(nuevoFactura);

    // Después de la inserción, navegar a la pantalla principal de detalle de ventas
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return VentaScreen();
    }));

    final productos = await ProductoDatabaseProvider().getAllProductos();
    setState(() {
      listaProductos = productos;
    });
  }


  void exportToPDF(int idVenta) async {
    //obtener la venta
    //obtner los detalles de la venta

    // Agrega un título
    final pdf = pw.Document();

    final ventaProvider =
        VentaDatabaseProvider(); // Crear una instancia de VentaDatabaseProvider
    final ventaValor = await ventaProvider.getVenta(
        idVenta); // Llamar al método getVenta usando la instancia creada
         final venta_detalle_Provider =
        DetalleVentaDatabaseProvider(); // Crear una instancia de VentaDatabaseProvider
    final venta_detalleValor =
        await venta_detalle_Provider.getDetalleVentasByIdVenta(
            idVenta); // Llamar al método getVenta usando la instancia creada

  pdf.addPage(
  pw.Page(
    build: (context) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            margin: pw.EdgeInsets.only(top: 20),
            child: pw.Text(
              'Factura',
              style: pw.TextStyle(fontSize: 24),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Text('Número de Factura: ${ventaValor!.numeroFactura}'),
          pw.Text('Fecha: ${ventaValor.fecha.toString()}'),
          pw.Text('Cliente: ${ventaValor.email}'),
          pw.Text(
            'Total Gs.: \$${ventaValor.precioVenta.toString()}',
          ),
          // Aquí agregar los detalles de la venta
          for (final detalle in venta_detalleValor)
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Producto: ${detalle.nombre_producto}'),
                pw.Text('Cantidad: ${detalle.cantidad}'),
                pw.Text('Precio del producto Gs.: ${detalle.precioProducto}'),
                pw.Divider(),
              ],
            ),
        ],
      );
    },
  ),
);


    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/factura.pdf';
    final file = await File(path).writeAsBytes(await pdf.save());
    sendMail(file, ventaValor!.email);
  }

  void sendMail(File file, String email) async {
    String username =
        'sanchezmatias968@gmail.com'; // Coloca tu dirección de Gmail
    String password = 'ofey hwuy okpk sbzq'; // Coloca tu contraseña de Gmail

    final smtpServer = gmail(username, password);

    final message = Message()
  
      ..from = Address(username)
      ..recipients.add(email) // Correo del destinatario
      ..subject = 'Archivo PDF Adjunto'
      ..text = 'Factura generada.'
      ..attachments.add(FileAttachment(file));

    try {
      final sendReport = await send(message, smtpServer);
      print('Correo enviado: ${sendReport.toString()}');
    } catch (e) {
      print('Error al enviar el correo: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Detalle Venta'),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     children: [
      //       TextField(
      //         controller: cantidadController,
      //         decoration: InputDecoration(labelText: 'Cantidad'),
      //         keyboardType: TextInputType.number,
      //       ),
      //       DropdownButtonFormField<Producto>(
      //         value: productoSeleccionado,
      //         onChanged: (Producto? newValue) {
      //           setState(() {
      //             productoSeleccionado = newValue;
      //           });
      //         },
      //         items: listaProductos.map((Producto producto) {
      //           return DropdownMenuItem<Producto>(
      //             value: producto,
      //             child: Text(
      //                 '${producto.nombre_producto} ${producto.precioVenta}'),
      //           );
      //         }).toList(),
      //         decoration: InputDecoration(labelText: 'Producto y precio'),
      //       ),
      //       // Puedes agregar más campos según los detalles de tu Factura

      //       ElevatedButton(
      //         onPressed: () {
      //           // Guardar el nuevo detalle de venta en la base de datos
      //           final nuevoFactura = Factura(
      //             idVenta: idVenta,
      //             numeroFactura: numeroFacturaController.text,
      //             fecha: fechaSeleccionada,
      //             precioVenta: 0.0,
      //           );
      //           // final result = (nuevoFactura.cantidad! *
      //           //     nuevoFactura.precioProducto);

      //           // VentaDatabaseProvider().updateCost(idVenta, result);
      //           sendMail();
      //           FacturaDatabaseProvider().insertFactura(nuevoFactura);

      //           // Después de la inserción, navegar a la pantalla principal de detalle de ventas
      //           Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      //             return VentaScreen();
      //           }));
      //         },
      //         child: Text('Guardar Detalle Venta'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
