import 'package:flutter/material.dart';
import 'package:frontend_1era_final/administracion_categorias/actions.dart';
import '/administracion_categorias/model.dart';
import '/administracion_productos/actions.dart';
import '/administracion_productos/model.dart';
import '/administracion_productos/pantalla_principal.dart';

class AgregarProductoForm extends StatefulWidget {
  @override
  _AgregarProductoFormState createState() => _AgregarProductoFormState();
}

class _AgregarProductoFormState extends State<AgregarProductoForm> {
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController precioVentaController =
      TextEditingController(); // Controlador para el precioVenta

  List<Categoria> listaCategorias = [];
  Categoria? categoriaSeleccionada;

  @override
  void initState() {
    super.initState();
    cargarCategorias();
  }

  Future<void> cargarCategorias() async {
    final categorias = await CategoriaDatabaseProvider().getAllCategorias();
    setState(() {
      listaCategorias = categorias;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Producto'),
        leading: IconButton(
          // Agrega el botón de retroceso aquí
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return ProductoScreen();
            }));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<Categoria>(
              value: categoriaSeleccionada,
              onChanged: (Categoria? newValue) {
                setState(() {
                  categoriaSeleccionada = newValue;
                });
              },
              items: listaCategorias.map((Categoria categoria) {
                return DropdownMenuItem<Categoria>(
                  value: categoria,
                  child: Text('${categoria.nombre}'),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Categoría'),
            ),
            TextField(
              controller: codigoController,
              decoration: InputDecoration(labelText: 'Código del Producto'),
            ),
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre del Producto'),
            ),
            TextField(
              controller: precioVentaController,
              decoration: InputDecoration(labelText: 'Precio de Venta'),
              keyboardType: TextInputType.numberWithOptions(decimal: true), // Permitir números decimales
            ),
            ElevatedButton(
              onPressed: () {
                // Guardar el nuevo producto en la base de datos.
                int categoria = categoriaSeleccionada!.idCategoria!;
                String idCategoria_nombre = categoriaSeleccionada!.nombre!;

                final nuevoProducto = Producto(
                  codigo: codigoController.text,
                  nombre_producto: nombreController.text,
                  idCategoria: categoria,
                  categoria_nombre: idCategoria_nombre,
                  precioVenta: double.tryParse(precioVentaController.text) ?? 0.0, // Asignación del precioVenta como double
                );

                ProductoDatabaseProvider().insertProducto(nuevoProducto);

                // Después de la inserción, navega a la pantalla de administración de categorías
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return ProductoScreen(); // Navegar a la nueva pantalla
                }));
              },
              child: Text('Guardar Producto'),
            ),
          ],
        ),
      ),
    );
  }
}
