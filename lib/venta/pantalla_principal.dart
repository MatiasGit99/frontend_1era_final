import 'package:flutter/material.dart';
import '/venta/actions.dart';
import '/venta/model.dart';
import '/venta/pantalla_agregar.dart';
import '/venta/pantalla_principal.dart';
import '/detalle_venta/pantalla_principal.dart';

class VentaScreen extends StatefulWidget {
  @override
  _VentaScreenState createState() => _VentaScreenState();
}

class _VentaScreenState extends State<VentaScreen> {
  List<Venta> ventas = [];

  @override
  void initState() {
    super.initState();
    getVentas();
  }

  Future<void> getVentas() async {
    final listaVentas = await VentaDatabaseProvider().getAllVentas();
    setState(() {
      ventas = listaVentas;
    });
  }

  Future<void> updateVenta(Venta venta) async {
    await VentaDatabaseProvider().updateVenta(venta);
    getVentas();
  }

  Future<void> deleteVenta(int? idVenta) async {
    if (idVenta != null) {
      await VentaDatabaseProvider().deleteVenta(idVenta);
      getVentas();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ventas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return AgregarVentaForm();
                }));
              },
              child: Text('Agregar Venta'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(200, 48)),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: ventas.length,
              itemBuilder: (BuildContext context, index) {
                final venta = ventas[index];
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Número de Factura: ${venta.numeroFactura}'),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Agrega aquí los otros detalles de la venta que deseas mostrar en la lista
                      Text('Precio de Venta: ${venta.precioVenta}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteVenta(venta.idVenta);
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return DetalleVentaScreen(venta.idVenta!);
                          }));
                        },
                        child: Text('Detalle'),
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
