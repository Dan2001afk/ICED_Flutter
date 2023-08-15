import 'package:flutter/material.dart';
import 'package:iced/Botones/BotonesLoginUsuario.dart';
import '../Botones/BotonesLogin.dart';
import '../Figuras/IconoLogin.dart';
import '../Vistas/Principal.dart';
import '../Figuras/IconoUsuario.dart';

class LoginUsuario extends StatelessWidget {
  const LoginUsuario({Key? key, required String userType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Inicio de Sesión Usuario ',
          style: TextStyle(
            color: Colors.black,
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
                    Color(0xFFB1A8F5),
                    Color(0xFF1C0A4F),
                  ]
              )
          ),
          child: Column(
            children: [
              figura_principal_usuario(),
              BotonesLoginUsuario(),
            ],
          ),
        ),
      ),
    );
  }
}
