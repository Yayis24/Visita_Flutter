import 'package:flutter/material.dart';

//VISTA PRINCIPAL

class Index extends StatelessWidget {
  const Index({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
        titleTextStyle: TextStyle(color: const Color.fromARGB(255, 7, 7, 7), fontSize: 25, fontWeight: FontWeight.bold),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 3, 155, 147),
      ),
      body: SingleChildScrollView(
        child: Center( // Agregado el Center widget
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/SENA.png',
                width: 450,
                height: 350,
              ),
              SizedBox(height: 10),
              Text(
                'Sobre nosotros',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Agenda tu visita en el Centro de Formación Agroindustrial La Angostura de manera sencilla y rápida. Descubre un lugar maravilloso en un entorno único.\n\nSolo ingresa a la sección de visitas y elige el día que mejor te convenga. ¡Te ofrecemos una experiencia enriquecedora que no querrás perderte!',
                    textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                  ),
              ),
              SizedBox(height: 20),
              Text(
                'Pie de Página - © ${DateTime.now().year} YayaV',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
