import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:visitas/database/database.dart';
import 'package:visitas/screens/singin_screen.dart';

class AdminView extends StatefulWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  int currentIndex = 1; // Establece el índice inicial aquí
  List<Map<String, dynamic>> visits = [];

  @override
  void initState() {
    super.initState();
    // Carga todos los registros al abrir la vista
    fetchAllVisits();
  }

  Future<void> fetchAllVisits() async {
    Database database = await Datavisit.openDB();
    visits = await database.query('visit');
    database.close();
    setState(() {});
  }

  Future<void> deleteVisit(int id) async {
    await Datavisit.deleteVisit(id);
    // Vuelve a cargar los registros después de eliminar
    await fetchAllVisits();
    setState(() {});
  }

  // Función para aprobar una visita
  Future<void> approveVisit(int id) async {
    Database database = await Datavisit.openDB();

    // Actualiza el estado de aprobación a "Aprobada" en la base de datos
    await database.update(
      'visit',
      {'status': 'Aprobada'},
      where: 'id = ?',
      whereArgs: [id],
    );

    database.close();
    // Vuelve a cargar los registros después de la aprobación
    await fetchAllVisits();
    setState(() {});
  }

  // Función para rechazar una visita
  Future<void> rejectVisit(int id) async {
    Database database = await Datavisit.openDB();

    // Actualiza el estado de aprobación a "Rechazada" en la base de datos
    await database.update(
      'visit',
      {'status': 'Rechazada'},
      where: 'id = ?',
      whereArgs: [id],
    );

    database.close();
    // Vuelve a cargar los registros después del rechazo
    await fetchAllVisits();
    setState(() {});
  }

  // Función para cerrar sesión
  void signOut() {
    // Aquí puedes agregar la lógica para cerrar la sesión, como limpiar datos de autenticación, etc.
    // Luego, navega a la pantalla de inicio de sesión
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SingInScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista del Administrador'),
        titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 7, 7, 7),
            fontSize: 25,
            fontWeight: FontWeight.bold),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 3, 155, 147),
        actions: [
          // Agrega el icono de cierre de sesión en la parte superior derecha
          IconButton(
            icon: Icon(Icons.exit_to_app), // Icono de cerrar sesión
            onPressed:
                signOut, // Llama a la función de cerrar sesión al hacer clic en el icono
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: visits.length,
        itemBuilder: (BuildContext context, int position) {
          final visit = visits[position];
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text('Nombre: ${visit['name']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fecha: ${visit['date']}'),
                  Text('Cantidad: ${visit['amount']}'),
                  Text(
                      'Estado: ${visit['status']}'), // Muestra el estado de aprobación
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      deleteVisit(visit['id']);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.check),
                    color: Colors.green,
                    onPressed: () {
                      approveVisit(visit['id']); // Aprobar visita
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.cancel),
                    color: Colors.red,
                    onPressed: () {
                      rejectVisit(visit['id']); // Rechazar visita
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
