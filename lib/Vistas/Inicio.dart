import 'package:flutter/material.dart';
import 'package:iced/Vistas/Login.dart';

void main() {
  runApp(const Inicio());
}

class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'imagenes/senalogo.png',
              width: 40,
              height: 40,
            ),
            SizedBox(width: 8),
            Text('ICED-SENA'),
          ],
        ),
        backgroundColor: Colors.black,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(userType: 'Administrador'),
                ),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.black, // Cambia el color de fondo del botón
              padding: EdgeInsets.symmetric(horizontal:5, vertical: 5), // Ajusta el tamaño del botón
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0), // Ajusta el radio de los bordes
              ),
            ),
            child: Text(
              'Administradores',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.black87],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bienvenido a ICED',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Image.asset(
                    'imagenes/iced_logo.png',
                    width: 250,
                    height: 250,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'ICED versión Móvil',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Aquí puedes ver cuántos dispositivos hay disponibles en el centro de Mosquera inicia secion para ver mas.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(userType: 'Usuario'),
                      ),
                    );
                  },
                  icon: Icon(Icons.person),
                  label: Text('Iniciar como Usuario'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Image.asset(
                  'imagenes/pc.png',
                  width: 200,
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
