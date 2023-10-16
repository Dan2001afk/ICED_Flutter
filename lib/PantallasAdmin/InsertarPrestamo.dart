import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'DatosPrestamos.dart';
import 'package:intl/intl.dart';

class InsertarPrestamo extends StatefulWidget {
  const InsertarPrestamo({Key? key}) : super(key: key);

  @override
  State<InsertarPrestamo> createState() => _InsertarPrestamoState();
}

class _InsertarPrestamoState extends State<InsertarPrestamo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _Pres_Equipos_serialController =
  TextEditingController();
  final TextEditingController _Pres_Usuarios_Documento_idController =
  TextEditingController();
  final TextEditingController _Pres_Tiempo_LimiteController =
  TextEditingController();

  void _EnviarFormularioPrestamos() async {
    if (_formKey.currentState!.validate()) {
      final String verificarPrestamoUrl =
          "http://192.168.1.44/verificarPrestamo/";
      final String insertarPrestamoUrl =
          "http://192.168.1.44/insertarPrestamo/";

      final Map<String, dynamic> datos = {
        'Pres_Equipos_serial': _Pres_Equipos_serialController.text,
        'Pres_Usuarios_Documento_id':
        _Pres_Usuarios_Documento_idController.text,
        'Pres_Tiempo_Limite': _Pres_Tiempo_LimiteController.text,
      };

      final jsonData = json.encode(datos);

      try {
        // Verificar préstamo
        final response = await http.post(
          Uri.parse(verificarPrestamoUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonData,
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          if (data['error'] != null) {
            // Muestra SweetAlert con el mensaje de error recibido del servidor
            // (deberías implementar el manejo de SweetAlert o mostrar un mensaje de error en Flutter)
            print("Error: ${data['error']}");
          } else {
            // Préstamo verificado correctamente, ahora insertar el préstamo
            final responseInsertar = await http.post(
              Uri.parse(insertarPrestamoUrl),
              headers: {'Content-Type': 'application/json'},
              body: jsonData,
            );

            if (responseInsertar.statusCode == 200) {
              // Muestra SweetAlert de éxito
              print('Préstamo registrado exitosamente');
              // Puedes agregar más lógica aquí si es necesario
            } else {
              // Muestra SweetAlert de error al enviar los datos
              print('Error al enviar los datos');
            }
          }
        } else {
          // Muestra SweetAlert de error en la solicitud
          print('Error en la solicitud');
        }
      } catch (error) {
        // Muestra SweetAlert de error general
        print('Error: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Préstamos"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _Pres_Equipos_serialController,
                decoration: InputDecoration(
                  labelText: 'Número de Serie del Equipo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el número de serie del equipo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Pres_Usuarios_Documento_idController,
                decoration: InputDecoration(
                  labelText: 'Documento del Usuario',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el documento del usuario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Pres_Tiempo_LimiteController,
                decoration: InputDecoration(
                  labelText: 'Tiempo Límite del Préstamo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el tiempo límite del préstamo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _EnviarFormularioPrestamos,
                child: const Text('Registrar Préstamo'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple, // Color morado
                  onPrimary: Colors.white, // Text color
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
