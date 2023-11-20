import 'package:flutter/material.dart';
import '/clientes/model.dart';
import '/clientes/actions.dart';
import '/clientes/pantalla_agregar.dart';
import '/clientes/pantalla_editar.dart';
import '/main.dart';

class AdministracionClientesScreen extends StatefulWidget {
  @override
  _AdministracionClientesScreenState createState() =>
      _AdministracionClientesScreenState();
}

class _AdministracionClientesScreenState
    extends State<AdministracionClientesScreen> {
  List<Cliente> Clientes = [];
  String selectedFilter = 'Nombre';
  bool mostrarSoloDoctores = false;

  @override
  void initState() {
    super.initState();
    getClientes();
  }

  Future<void> getClientes() async {
    final listaClientes = await ClienteDatabaseProvider().getAllClientes();
    setState(() {
      Clientes = listaClientes;
    });
  }

  Future<void> insertCliente() async {
    final nuevoCliente = Cliente(
      idPersona: null,
      nombre: 'Nuevo Nombre',
      apellido: 'Nuevo Apellido',
      ruc: 'Nuevo Ruc',
      email: 'Nuevo Email',
    ); // Ajusta los valores según tu caso

    await ClienteDatabaseProvider().insertCliente(nuevoCliente);
    getClientes();
  }

  Future<void> updateCliente(Cliente Cliente) async {
    await ClienteDatabaseProvider().updateCliente(Cliente);
    getClientes();
  }

  Future<void> deleteCliente(int? idPersona) async {
    if (idPersona != null) {
      await ClienteDatabaseProvider().deleteCliente(idPersona);
      getClientes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administración de Clientes'),
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
                  return AgregarClienteForm();
                }));
              },
              child: Text('Agregar Cliente'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(200, 48)),
              ),
            ),

            // Aquí puedes mostrar la lista de pacientes y doctores.
            ListView.builder(
              shrinkWrap: true,
              itemCount: Clientes.length,
              itemBuilder: (context, index) {
                final Cliente = Clientes[index];
                return ListTile(
                  title: Text(
                    '${Cliente.nombre} ${Cliente.apellido}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => EditarClienteScreen(
                                cliente: Cliente,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteCliente(Cliente.idPersona);
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
