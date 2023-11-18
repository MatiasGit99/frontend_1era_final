import 'package:flutter/material.dart';
import '/administracion_productos/actions.dart';
import '/administracion_productos/model.dart';
import '/administracion_productos/pantalla_agregar.dart';

class ProductoScreen extends StatefulWidget {

  @override
  _ProductoScreenState createState() => _ProductoScreenState();
}

class _ProductoScreenState extends State<ProductoScreen> {
  List<Producto> Productos = [];

  @override
  void initState() {
    super.initState();
    getProductos();
  }

  Future<void> getProductos() async {
    final listaProductos = await ProductoDatabaseProvider().getAllProductos();
    setState(() {
      Productos = listaProductos;
    });
  }

  Future<void> updateProducto(Producto Producto) async {
    await ProductoDatabaseProvider().updateProducto(Producto);
    getProductos();
  }

  Future<void> deleteProducto(int? idProducto) async {
    if (idProducto != null) {
      await ProductoDatabaseProvider().deleteProducto(idProducto);
      getProductos();
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fichas Clínicas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return AgregarProductoForm();
                }));
              },
              child: Text('Agregar Producto'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(200, 48)),
              ),
            ),
           
            ListView.builder(
              shrinkWrap: true,
              itemCount: Productos.length,
              itemBuilder: (BuildContext context, index) {
                final Producto = Productos[index];
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Código: ${Producto.codigo}'),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nombre: ${Producto.nombre_producto}'),
                      Text(
                          'Categoría: ${Producto.categoria_nombre}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteProducto(Producto.idProducto);
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
