import 'package:flutter/material.dart';
import '/detalle_venta/model.dart';
import '/detalle_venta/actions.dart';
import '/detalle_venta/pantalla_agregar.dart';
import '/main.dart';

class DetalleVentaScreen extends StatefulWidget {
  late int idVenta; // Variable para almacenar idVenta
  DetalleVentaScreen(this.idVenta); // Constructor para recibir idVenta

  @override
  _DetalleVentaScreenState createState() => _DetalleVentaScreenState();
}

class _DetalleVentaScreenState extends State<DetalleVentaScreen> {
  late int idVenta; // Variable para almacenar idVenta
  List<DetalleVenta> detallesVenta = [];

  @override
  void initState() {
    idVenta = widget.idVenta; // Obtener el valor de idVenta desde widget
    super.initState();
    getDetallesVenta(idVenta);
  }

  Future<void> getDetallesVenta(int idVenta) async {
    final listaDetallesVenta =
        await DetalleVentaDatabaseProvider().getAllDetalleVentas();
    setState(() {
      detallesVenta = listaDetallesVenta
          .where((detalle) => detalle.idVenta == idVenta)
          .toList();
      ;
    });
  }

  Future<void> updateDetalleVenta(DetalleVenta detalleVenta) async {
    await DetalleVentaDatabaseProvider().updateDetalleVenta(detalleVenta);
    getDetallesVenta(idVenta);
  }

  Future<void> deleteDetalleVenta(int? idDetalleVenta) async {
    if (idDetalleVenta != null) {
      await DetalleVentaDatabaseProvider().deleteDetalleVenta(idDetalleVenta);
      getDetallesVenta(idVenta);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de Venta'),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return AgregarDetalleVentaForm(idVenta);
                }));
              },
              child: Text('Agregar Detalle de Venta'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(250, 48)),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: detallesVenta.length,
              itemBuilder: (BuildContext context, index) {
                final detalleVenta = detallesVenta[index];
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Nombre del Producto: ${detalleVenta.nombre_producto}'),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cantidad: ${detalleVenta.cantidad}'),
                      Text(
                          'Precio del Producto: ${detalleVenta.precioProducto}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteDetalleVenta(detalleVenta.idDetalleVenta);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Implement logic for editing the DetalleVenta
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
