import 'package:flutter/material.dart';
import '/factura/model.dart';
import '/factura/actions.dart';
import '/factura/pantalla_agregar.dart';

class FacturaScreen extends StatefulWidget {
    late int idVenta; // Variable para almacenar idVenta
    FacturaScreen(this.idVenta); // Constructor para recibir idVenta

  @override
  _FacturaScreenState createState() => _FacturaScreenState();
}

class _FacturaScreenState extends State<FacturaScreen> {
  late int idVenta; // Variable para almacenar idVenta
  List<Factura> factura = [];

  @override
  void initState() {
    idVenta = widget.idVenta; // Obtener el valor de idVenta desde widget
    super.initState();
    getFactura(idVenta);
  }

  Future<void> getFactura(int idVenta) async {
    final listaFactura =
        await FacturaDatabaseProvider().getAllFacturas();
    setState(() {
      factura = listaFactura.where((detalle) => detalle.idVenta == idVenta).toList();;
    });
  }

  Future<void> updateFactura(Factura detalleVenta) async {
    await FacturaDatabaseProvider().updateFactura(detalleVenta);
    getFactura(idVenta);
  }

  Future<void> deleteFactura(int? idFactura) async {
    if (idFactura != null) {
      await FacturaDatabaseProvider().deleteFactura(idFactura);
      getFactura(idVenta);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Factura'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return AgregarFacturaForm(idVenta);
                }));
              },
              child: Text('Agregar Factura'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(250, 48)),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: factura.length,
              itemBuilder: (BuildContext context, index) {
                final Factura = factura[index];
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Factura: ${Factura.numeroFactura}'),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cantidad: ${Factura.fecha}'),
                      Text('Total: ${Factura.precioVenta}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // IconButton(
                      //   icon: Icon(Icons.delete),
                      //   onPressed: () {
                      //     deleteFactura(detalleVenta.idFactura);
                      //   },
                      // ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Implement logic for editing the Factura
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
