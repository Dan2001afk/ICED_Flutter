import 'package:flutter/material.dart';
import '../Botones/BotonesLogin.dart';
import '../Figuras/IconoLogin.dart';
import 'PrincipalAdmin.dart';

class Login extends StatelessWidget {
  const Login({Key? key, required String userType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 117, 30, 157),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Administrador',
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
                    Color(0xFFA914C4),
                    Color(0xFF3A1691),
                  ]
              )
          ),
          child: Column(
            children: [
              FiguraPrincipal(),
              BotonesLogin(),
            ],
          ),
        ),
      ),
    );
  }
}
