import 'package:flutter/material.dart';
import '/clientes/actions.dart';
import '/clientes/model.dart';
import '/clientes/pantalla_principal.dart';

class EditarClienteScreen extends StatefulWidget {
  final Cliente cliente;

  EditarClienteScreen({required this.cliente});

  @override
  _EditarClienteScreenState createState() => _EditarClienteScreenState();
}

class _EditarClienteScreenState extends State<EditarClienteScreen> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController rucController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nombreController.text = widget.cliente.nombre;
    apellidoController.text = widget.cliente.apellido;
    rucController.text = widget.cliente.ruc;
    emailController.text = widget.cliente.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Paciente/Doctor'),
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
              decoration: InputDecoration(labelText: 'Ruc'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            ElevatedButton(
              onPressed: () {
                // Guardar los cambios en el paciente/doctor en la base de datos.
                final clienteActualizado = Cliente(
                  idPersona: widget.cliente.idPersona,
                  nombre: nombreController.text,
                  apellido: apellidoController.text,
                  ruc: rucController.text,
                  email: emailController.text,
                );

                // Update the paciente/doctor in the database.
                ClienteDatabaseProvider().updateCliente(clienteActualizado);

                // After the update, navigate back to the main screen or any other screen you want.
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return AdministracionClientesScreen(); // Navigate to the desired screen
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
