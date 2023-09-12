import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int cantidadEquipos = 0;

  @override
  void initState() {
    super.initState();
    _fetchCantidadEquipos(); // Llama a la función para obtener la cantidad de equipos al iniciar la pantalla
  }

  Future<void> _fetchCantidadEquipos() async {
    final response = await http.get(
        Uri.parse('http://10.190.82.210/ContarEquipos'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final cantidadEquipos = jsonData['cantidad_equipos'];
      setState(() {
        this.cantidadEquipos = cantidadEquipos;
      });
    } else {
      throw Exception('Error al cargar la cantidad de equipos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1C0A4F),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Pantalla Usuario',
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
                    Color(0xFFB1A8F5),
                    Color(0xFF1C0A4F),
                  ])),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.computer_sharp,  // Reemplaza con el icono que desees
                      color: Colors.pink,  // Cambia el color del ícono según tus preferencias
                      size: 80,  // Cambia el tamaño del ícono según tus preferencias
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Equipos $cantidadEquipos', // Muestra la cantidad de equipos obtenida
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              // ... otros widgets de columnas ...
            ],
          ),
        ),
      ),
    );
  }
}
