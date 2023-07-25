import 'package:flutter/material.dart';
import '../Botones/BotonesLogin.dart';
import '../Figuras/IconoLogin.dart';
import 'Principal.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

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
          'Inicio de Sesión',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 715,
          decoration: const BoxDecoration(
              gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.3,
                  colors: [
                    Color(0xFFB1A8F5),
                    Color(0xFF0B0320),
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
