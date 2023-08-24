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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Administrador '),
        backgroundColor: Color(0xFFB1A8F5),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB1A8F5), Color(0xFF0B0320)],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20, // Agrega un espacio desde la parte superior
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFF3B2B69), // Cambia el color a 0xFFE1D7FF (RGB)
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(

                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topCenter, // Centrar en la parte superior
                            child: Text(
                              'Acciones Equipos', // Título del primer card
                              style: TextStyle(
                                color: Colors.white, // Color del texto blanco
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8), // Espacio entre el título y el botón
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InsertarEquipo(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF5EDAEA), // Cambia el color a 0xFFE1D7FF (RGB)
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add_circle_outline),
                              SizedBox(width: 8),
                              Text('Registro Equipos'),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConsultarEquiposApi(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFA6EA5E), // Cambia el color a 0xFFE1D7FF (RGB)
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.list),
                              SizedBox(width: 8),
                              Text('Datos Equipos'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFF3B2B69), // Cambia el color a 0xFFE1D7FF (RGB)
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(

                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topCenter, // Centrar en la parte superior
                            child: Text(
                              'Acciones Usuarios', // Título del segundo card
                              style: TextStyle(
                                color: Colors.white, // Color del texto blanco
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8), // Espacio entre el título y el botón
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InsertarUsuarios(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF5EDAEA), // Cambia el color a 0xFFE1D7FF (RGB)
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add_circle_outline),
                              SizedBox(width: 8),
                              Text('Registro Usuarios'),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConsultarUsuariosApi(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFA6EA5E), // Cambia el color a 0xFFE1D7FF (RGB)
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.list),
                              SizedBox(width: 8),
                              Text('Datos Usuario'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFF3B2B69), // Cambia el color a 0xFFE1D7FF (RGB)
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(

                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topCenter, // Centrar en la parte superior
                            child: Text(
                              'Acciones Prestamos', // Título del segundo card
                              style: TextStyle(
                                color: Colors.white, // Color del texto blanco
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8), // Espacio entre el título y el botón
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InsertarPrestamo()
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFB00606), // Cambia el color a 0xFFE1D7FF (RGB)
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add_circle_outline),
                              SizedBox(width: 8),
                              Text('Registro Prestamos'),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>ConsultarPrestamosApi(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFA6EA5E), // Cambia el color a 0xFFE1D7FF (RGB)
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.list),
                              SizedBox(width: 8),
                              Text('Datos Prestamo'),
                            ],
                          ),
                        ),
                      ],
                    ),
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