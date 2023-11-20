import 'package:flutter/material.dart';
import '/clientes/model.dart';
import '/clientes/actions.dart';
import '/clientes/pantalla_principal.dart';

class AgregarClienteForm extends StatefulWidget {
  @override
  _AgregarClienteFormState createState() =>
      _AgregarClienteFormState();
}

class _AgregarClienteFormState extends State<AgregarClienteForm> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController rucController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Cliente'),
        leading: IconButton(
          // Agrega el botón de retroceso aquí
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return AdministracionClientesScreen();
            }));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: apellidoController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: rucController,
              decoration: InputDecoration(labelText: 'ruc'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          
           
            ElevatedButton(
              onPressed: () {
                // Guardar el nuevo paciente o doctor en la base de datos.
                final nuevoCliente = Cliente(
                  idPersona: null,
                  nombre: nombreController.text,
                  apellido: apellidoController.text,
                  ruc: rucController.text,
                  email: emailController.text,
                );
                
                ClienteDatabaseProvider()
                    .insertCliente(nuevoCliente);

                // Después de la inserción, navega a la pantalla de administración de pacientes y doctores.
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return AdministracionClientesScreen();
                }));
              },
              child: Text('Guardar Cliente'),
            ),
          ],
        ),
      ),
    );
  }
}
