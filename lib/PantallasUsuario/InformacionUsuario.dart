import 'package:flutter/material.dart';

void main() {
  runApp(InicioUsuario());
}

class InicioUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
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
          'Pantalla Usuario ',
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
        ),
      ),
    );
  }
}