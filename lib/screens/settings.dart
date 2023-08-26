import 'package:flutter/material.dart';
import 'package:visitas/screens/singin_screen.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Salir"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SingInScreen()));
          },
        ),
      ),
    );
  }
}
