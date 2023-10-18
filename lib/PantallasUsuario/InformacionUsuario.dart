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
    _fetchCantidadEquipos();
  }

  Future<void> _fetchCantidadEquipos() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.44/ContarEquipos'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final cantidadEquipos = jsonData['cantidad_equipos'];
        setState(() {
          this.cantidadEquipos = cantidadEquipos;
        });
      } else {
        throw Exception('Error al cargar la cantidad de equipos');
      }
    } catch (error) {
      print('Error: $error');
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
              ],
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                child: Icon(
                  Icons.computer_sharp,
                  color: Colors.pink,
                  size: 80,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Equipos $cantidadEquipos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 20),
              // Mensaje sobre el horario de atención centrado
              Center(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '¡ATENCIÓN!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'A partir de la fecha, el horario de atención será:',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text('7:00 am - 1:00 pm'),
                      Text('2:00 pm - 5:00 pm'),
                      Text('Sofía Plus'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
