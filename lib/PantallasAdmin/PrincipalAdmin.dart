import 'package:flutter/material.dart';
import 'package:iced/PantallasAdmin/DatosEquipos.dart';
import 'package:iced/PantallasAdmin/DatosPrestamos.dart';
import 'package:iced/PantallasAdmin/DatosUsuarios.dart';
import 'package:iced/PantallasAdmin/InsertarEquipos.dart';
import 'package:iced/PantallasAdmin/InsertarPrestamo.dart';
import 'package:iced/PantallasAdmin/InsertarUsuarios.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  // Función para crear una tarjeta con un título y dos botones
  Widget _buildCard(String title, String button1Text, Widget button1Destination, String button2Text, Widget button2Destination) {
    return Center(
      child: SizedBox(
        width: 300, // Ajusta el ancho deseado de la tarjeta
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Color(0xFF000000),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Hace que la tarjeta se ajuste al contenido
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => button1Destination,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF152880),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add_circle_outline),
                      SizedBox(width: 8),
                      Text(button1Text),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => button2Destination,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF85D527),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.list),
                      SizedBox(width: 8),
                      Text(button2Text),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pantalla Administrador',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Color(0xFFA20999),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2C2FEF), Color(0xFFA20999)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 20,
                ),
                _buildCard(
                  'Acciones Equipos',
                  'Registro Equipos',
                  InsertarEquipo(),
                  'Datos Equipos',
                  ConsultarEquiposApi(),
                ),
                SizedBox(height: 10),
                _buildCard(
                  'Acciones Usuarios',
                  'Registro Usuarios',
                  InsertarUsuarios(),
                  'Datos Usuario',
                  ConsultarUsuariosApi(),
                ),
                SizedBox(height: 10),
                _buildCard(
                  'Acciones Prestamos',
                  'Registro Prestamos',
                  InsertarPrestamo(),
                  'Datos Prestamo',
                  ConsultarPrestamosApi(),
                ),
                SizedBox(height: 10),
                _buildCard(
                  'Acciones Sanciones',
                  'Registro Sanciones',
                  RegistroPage(), // Reemplaza con la página correcta para Sanciones
                  'Datos Sanciones',
                  DatosPage(), // Reemplaza con la página correcta para Datos Sanciones
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegistroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página de Registro'),
      ),
      body: const Center(
        child: Text('Contenido de la página de Registro'),
      ),
    );
  }
}

class DatosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página de Datos'),
      ),
      body: const Center(
        child: Text('Contenido de la página de Datos'),
      ),
    );
  }
}
