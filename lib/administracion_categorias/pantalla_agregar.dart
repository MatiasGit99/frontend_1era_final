import 'package:flutter/material.dart';
import '/administracion_categorias/model.dart'; // Importa el modelo de Categoría
import '/administracion_categorias/actions.dart'; // Importa el modelo de Categoría
import '/administracion_categorias/pantalla_principal.dart'; // Importa el modelo de Categoría

class AgregarCategoriaForm extends StatefulWidget {
  @override
  _AgregarCategoriaFormState createState() => _AgregarCategoriaFormState();
}

class _AgregarCategoriaFormState extends State<AgregarCategoriaForm> {
  final TextEditingController descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Categoría'),
        leading: IconButton(
          // Agrega el botón de retroceso aquí
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return AdministracionCategoriasScreen();
            }));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: descripcionController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            ElevatedButton(
              onPressed: () {
                // Guardar la nueva categoría en la base de datos.
                final nuevaCategoria = Categoria(
                  idCategoria: null,
                  nombre: descripcionController.text,
                );
                CategoriaDatabaseProvider().insertCategoria(nuevaCategoria);

                // Después de la inserción, navega a la pantalla de administración de categorías
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return AdministracionCategoriasScreen(); // Navegar a la nueva pantalla
                }));
              },
              child: Text('Guardar Categoría'),
            ),
          ],
        ),
      ),
    );
  }
}
