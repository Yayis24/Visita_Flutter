import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../database/database.dart';

//VISTA PARA AGREGAR REGISTROS

class AddVisitScreen extends StatefulWidget {
  final String appBarTitle;
  final int userId;

  AddVisitScreen({required this.appBarTitle, required this.userId});

  @override
  _AddVisitScreenState createState() => _AddVisitScreenState();
}

class _AddVisitScreenState extends State<AddVisitScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  void saveVisit() async {
    // Abre la base de datos
    Database database = await Datavisit.openDB();

    // Crea un mapa con los datos de la visita
    Map<String, dynamic> visitData = {
      'name': titleController.text,
      'date': dateController.text,
      'amount': int.parse(numberController.text),
    };

    // Inserta los datos en la tabla
    await database.insert('visit', visitData);

    // Cierra la base de datos
    database.close();

    // Regresa a la pantalla anterior (lista de visitas)
    Navigator.pop(context);

    // Puedes notificar a la pantalla de lista para que se actualice si es necesario
    // Por ejemplo, usando Provider o algún otro método de estado global
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de visitas'),
        titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 7, 7, 7),
            fontSize: 25,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 3, 155, 147),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration:
                  InputDecoration(labelText: 'Nombre de la institucion'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: dateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: 'Fecha',
                hintText: 'YYYY-MM-DD', // Agrega este marcador de posición
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Cantidad'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveVisit,
              child: Text('Guardar Visita'),
            ),
          ],
        ),
      ),
    );
  }
}
