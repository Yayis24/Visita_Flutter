import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:visitas/screens/addvisit.dart';
import '../database/database.dart';

//VISTA DE REGISTROS REALIZADOS

class RVisita extends StatefulWidget {
  final int userId; // Agrega userId como parámetro

  const RVisita({Key? key, required this.userId}) : super(key: key);

  @override
  State<RVisita> createState() => _RVisitaState(userId: userId);
}

class _RVisitaState extends State<RVisita> {
  int count = 0;
  List<Map<String, dynamic>> visits = []; // Lista para almacenar las visitas
  int userId; // Agrega userId como variable miembro

  _RVisitaState({required this.userId}); // Constructor que recibe userId

  Future<void> fetchVisits() async {
    Database database = await Datavisit.openDB();
    visits = await database.query('visit');
    database.close();
  }

  @override
  void initState() {
    super.initState();
    fetchVisits().then((_) {
      setState(() {
        count = visits.length;
      });
    });
  }

// Método para actualizar las visitas
  void updateVisits() {
    fetchVisits().then((_) {
      setState(() {
        count = visits.length;
      });
    });
  }

  Future<void> deleteVisit(int id) async {
    await Datavisit.deleteVisit(id);
    setState(() {
      // Actualiza la lista de visitas después de eliminar
      fetchVisits();
    });
  }

//MODAL DETALLES DE VISITA
  void _showVisitDetailsModal(Map<String, dynamic> visit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles del registro'),
          titleTextStyle: TextStyle(
              color: const Color.fromARGB(255, 7, 7, 7),
              fontSize: 25,
              fontWeight: FontWeight.bold),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20), // Espacio entre el título y el contenido
              Text('Nombre: ${visit['name']}'),
              SizedBox(height: 10),
              Text('Fecha: ${visit['date']}'),
              SizedBox(height: 10),
              Text('Cantidad: ${visit['amount']}'),
              SizedBox(
                  height:
                      15), // Espacio adicional entre el contenido y el botón
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cerrar'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

//CONFIRMACION DE ELIMINACION

  void _showDeleteConfirmationDialog(BuildContext context, int visitId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Eliminación'),
          titleTextStyle: TextStyle(
              color: const Color.fromARGB(255, 7, 7, 7),
              fontSize: 25,
              fontWeight: FontWeight.bold),
          content: Text('¿Estás seguro de que deseas eliminar esta visita?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cierra el diálogo
                  },
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    // Elimina la visita y cierra el diálogo
                    deleteVisit(visitId);
                    Navigator.of(context).pop();
                  },
                  child: Text('Eliminar', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

//MODAL EDITAR REGISTROS
  void _showEditModal(BuildContext context, Map<String, dynamic> visit) {
    late TextEditingController titleController =
        TextEditingController(text: visit['name']);
    late TextEditingController dateController =
        TextEditingController(text: visit['date']);
    late TextEditingController numberController =
        TextEditingController(text: visit['amount'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar registro'),
          titleTextStyle: TextStyle(
              color: const Color.fromARGB(255, 7, 7, 7),
              fontSize: 25,
              fontWeight: FontWeight.bold),
          contentPadding:
              EdgeInsets.fromLTRB(16, 0, 16, 0), // Ajusta el padding aquí
          content: Column(
            children: [
              TextField(
                controller: titleController,
                decoration:
                    InputDecoration(labelText: 'Nombre de la institución'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: dateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(labelText: 'Fecha'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: numberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Cantidad'),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () async {
                    // Abre la base de datos
                    Database database = await Datavisit.openDB();

                    // Crea un mapa con los datos de la visita editada
                    Map<String, dynamic> updatedVisitData = {
                      'name': titleController.text,
                      'date': dateController.text,
                      'amount': int.parse(numberController.text),
                    };

                    // Actualiza los datos en la tabla usando el ID de la visita
                    await database.update(
                      'visit',
                      updatedVisitData,
                      where: 'id = ?',
                      whereArgs: [visit['id']],
                    );

                    // Cierra la base de datos
                    database.close();

                    // Cierra el modal
                    Navigator.of(context).pop();
                    updateVisits(); //Actualiza los datos despues de editarlos
                  },
                  child: Text('Guardar'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String getStatusText(String status) {
    if (status == 'Aprobada') {
      return 'Aprobada';
    } else if (status == 'Rechazada') {
      return 'Rechazada';
    } else {
      return 'Pendiente';
    }
  }

  ListView getNoteListView() {
    TextStyle titleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return ListView.builder(
      itemCount: visits.length,
      itemBuilder: (BuildContext context, int position) {
        final visit = visits[position];
        String status = visit['status'];
        String statusText = getStatusText(status);
        // Declarar la variable statusColor aquí con un valor por defecto
        Color statusColor = Colors.black; // Color por defecto

        if (status == 'pendiente') {
          statusColor = Colors.blue;
        } else if (status == 'aprobado') {
          statusColor = Colors.green;
          statusText = 'Aprobado';
        } else if (status == 'rechazado') {
          statusColor = Colors.red;
          statusText = 'Rechazado';
        }

        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 230, 172, 240),
              child: Icon(Icons.people_alt_outlined),
            ),
            title: Text(
              visit['name'],
              style: titleStyle,
            ),
            subtitle: Text(
              'Estado: $statusText',
              style: TextStyle(color: statusColor),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit_document),
                  color: Color.fromARGB(255, 216, 197, 25),
                  onPressed: () {
                    _showEditModal(context, visit);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, visit['id']);
                  },
                ),
              ],
            ),
            onTap: () {
              _showVisitDetailsModal(visit);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitas'),
        titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 7, 7, 7),
            fontSize: 25,
            fontWeight: FontWeight.bold),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 3, 155, 147),
      ),
      body: FutureBuilder<void>(
        future: fetchVisits(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (visits.isEmpty) {
            return Text('No hay visitas registradas.');
          } else {
            return getNoteListView();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navega a la pantalla de agregar visita y espera hasta que se cierre
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddVisitScreen(
                appBarTitle: 'Nueva Visita',
                userId: userId,
              ),
            ),
          );

          // Después de cerrar la pantalla de agregar visita, actualiza la lista
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
