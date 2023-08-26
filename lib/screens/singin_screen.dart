import 'package:flutter/material.dart';
import 'package:visitas/database/database.dart';
import 'package:visitas/screens/Home_Screen.dart';
import 'package:visitas/utils/color_utils.dart';
import '../reusable/reusable_widget.dart';
import 'signup_screen.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final _passwordTextController = TextEditingController();
  final _userNameTextController = TextEditingController();

// Validacion de credenciales ingresadas

  void _handleSignIn(String username, String password) async {
    Map<String, dynamic>? user =
        await Datavisit.getUserByUsernameAndPassword(username, password);

    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Credenciales incorrectas. Por favor, intenta de nuevo.'),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context)
            .size
            .width, //Ajustamos en toda la pantalla el color y el logo
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
              hexStringToColor("#05BCCB"),
              hexStringToColor("#010101"),
            ],
                begin: Alignment.topCenter,
                end: Alignment
                    .bottomCenter)), //Ajusta el degradado verticalmente
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/29766.png"), //llamas la variable
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Ingrese su usuario", Icons.person_outline,
                    false, _userNameTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Ingrese su contraseña", Icons.lock_outline,
                    true, _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _handleSignIn(_userNameTextController.text,
                        _passwordTextController.text);
                  },
                  child: Text(
                    'Ingresar',
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black26;
                        }
                        return Colors.white;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)))),
                ),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("¿No tienes cuenta?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Ingresa aqui",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
