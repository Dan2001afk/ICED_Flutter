import 'package:flutter/material.dart';
import 'package:iced/Vistas/DatosEquipos.dart';
import 'package:iced/Vistas/InsertarEquipos.dart';
import 'package:iced/Vistas/InsertarUsuarios.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InsertarEquipo(),
                  ),
                );
              },
              child: const Text('Registro Equipos'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConsultarApiEquipos(),
                  ),
                );
              },
              child: const Text('Datos Equipos'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConsultarApiEquipos(),
                  ),
                );
              },
              child: const Text('Datos Usuario'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InsertarUsuarios(),
                  ),
                );
              },
              child: const Text('Registro Usuarios'),
            ),
          ],
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