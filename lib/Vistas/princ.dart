import 'package:flutter/material.dart';
import 'package:iced/Vistas/Datos.dart';
import 'package:iced/Vistas/Insertar.dart';

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
              child: const Text('Registro'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConsultarApi(),
                  ),
                );
              },
              child: const Text('Datos'),
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
