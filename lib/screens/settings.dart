import 'package:flutter/material.dart';
import 'package:visitas/screens/singin_screen.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuracion'),
        titleTextStyle: TextStyle(
            color: const Color.fromARGB(255, 7, 7, 7),
            fontSize: 25,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 3, 155, 147),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Cerrar sesion"),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SingInScreen()));
          },
        ),
      ),
    );
  }
}
