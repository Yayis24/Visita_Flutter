import 'package:flutter/material.dart';

class BNavigator extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BNavigator({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 7, 7, 7),
        backgroundColor: Color.fromARGB(255, 3, 155, 147),
        iconSize: 25.0,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max_outlined),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: 'Visitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuracion',
          ),
        ]);   
  }
}
