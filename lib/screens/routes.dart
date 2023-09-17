import 'package:flutter/material.dart';
import 'package:visitas/screens/Index.dart';
import 'package:visitas/screens/RVisita.dart';
import 'package:visitas/screens/settings.dart';

class Routes extends StatelessWidget {
  final int index;
  final int userId; // Agrega userId aquí

  const Routes({required this.index, required this.userId});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const Index();
      case 1:
        return RVisita(userId: userId);
      case 2:
        return const Settings();
      default:
        return Container(); // Manejar cualquier otro caso según tus necesidades
    }
  }
}
