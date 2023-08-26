import 'package:flutter/material.dart';
import 'package:visitas/reusable/BNavigator.dart';
import 'package:visitas/screens/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
      ),
      body: Routes(index: index),
    );
  }
}
