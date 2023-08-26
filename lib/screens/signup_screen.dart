import 'package:flutter/material.dart';
import 'package:visitas/database/database.dart';
import 'package:visitas/screens/singin_screen.dart';
import '../reusable/reusable_widget.dart';
import '../utils/color_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  void _handleSignUp(String username, String password) async {
    // Registrar al usuario con el rol de 'user'
    await Datavisit.insertUser(username, password, 'user');
    // Mostrar un mensaje de éxito

    print('Registro exitoso. Ahora puedes iniciar sesión.');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registro exitoso. Ahora puedes iniciar sesión.'),
      ),
    );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SingInScreen()));
// Redirigir al usuario a la vista de ingreso
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Registrate",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          //Copiamos el mismo estilo de la vista principal singinscreen (linea 21 a 33)
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
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/29766.png"), //llamas la variable
                SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Ingrese su nombre de usuario", Icons.person,
                    false, _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Ingrese su Email", Icons.person_outline,
                    false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Ingrese su contraseña", Icons.lock_outline,
                    true, _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _handleSignUp(_userNameTextController.text,
                        _passwordTextController.text);
                  },
                  child: Text(
                    'Registrar',
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
              ],
            ),
          ))),
    );
  }
}
