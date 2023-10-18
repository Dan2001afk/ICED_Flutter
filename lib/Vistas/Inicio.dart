import 'package:flutter/material.dart';
import 'package:iced/PantallasAdmin/LoginAdmin.dart';
import 'package:iced/PantallasUsuario/LoginUsuario.dart';
import 'package:iced/PantallasUsuario/AcercaDeNosotros.dart';

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
            const SizedBox(width: 8),
            Text(
              'ICED-SENA',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'YourCustomFont',
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black87,
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
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            child: Text(
              'ADMIN',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'YourCustomFont',
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.indigo],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bienvenido a ICED',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'YourCustomFont',
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'imagenes/iced_logo.png',
                    width: 250,
                    height: 250,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'ICED versión Móvil',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'YourCustomFont',
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Aquí puedes ver cuántos dispositivos hay disponibles en el centro de Mosquera. Inicia sesión para ver más.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'YourCustomFont',
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginUsuario(userType: 'Usuario'),
                      ),
                    );
                  },
                  icon: Icon(Icons.person, color: Colors.white),
                  label: Text(
                    'Iniciar como Usuario',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    elevation: 8,
                  ),
                ),
                const SizedBox(height: 30),
                Image.asset(
                  'imagenes/pc.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AcercaDeNosotros(),
                      ),
                    );
                  },
                  child: Text(
                    'Conoce a los Desarrolladores de ICED',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 10,
                  ),
                ),
                const SizedBox(height: 50),
                // Nueva sección con la ubicación de la aplicación
                Text(
                  'Desarrollado en Mosquera CBA',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontFamily: 'YourCustomFont',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

