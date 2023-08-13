import 'package:flutter/material.dart';
import '../Botones/BotonesLogin.dart';
import '../Figuras/IconoLogin.dart';
import '../Vistas/Principal.dart';

class Login extends StatelessWidget {
  const Login({Key? key, required String userType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Inicio de Sesión Administrador',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 800,
          decoration: const BoxDecoration(
              gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.3,
                  colors: [
                    Color(0xFF580864),
                    Color(0xFF0E091A),
                  ]
              )
          ),
          child: Column(
            children: [
              figura_principal(),
              BotonesLogin(),
            ],
          ),
        ),
      ),
    );
  }
}
