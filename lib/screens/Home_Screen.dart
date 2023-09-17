import 'package:flutter/material.dart';
import 'package:visitas/reusable/BNavigator.dart';
import 'package:visitas/screens/routes.dart';

class HomeScreen extends StatefulWidget {
  final int userId; // Agrega el parámetro userId

  const HomeScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BNavigator(
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
        userId: widget.userId, // Pasa userId a BNavigator
      ),
      body: Routes(index: index, userId: widget.userId),
    );
  }
}

