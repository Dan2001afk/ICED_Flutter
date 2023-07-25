import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'DatosPrestamos.dart';


class InsertarPrestamo extends StatefulWidget {
  const InsertarPrestamo({Key? key}) : super(key: key);

  @override
  State<InsertarPrestamo> createState() => _InsertarPrestamoState();
}

class _InsertarPrestamoState extends State<InsertarPrestamo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _Pres_idcontroller = TextEditingController();
  final TextEditingController _Pres_Fec_Entregacontroller = TextEditingController();
  final TextEditingController _Pres_Tiempo_Limitecontroller = TextEditingController();
  final TextEditingController _Pres_observaciones_entregacontroller = TextEditingController();
  final TextEditingController _Equi_serialcontroller = TextEditingController();
  final TextEditingController _Pres_Equipos_idcontroller = TextEditingController();
  final TextEditingController _Pres_Usuarios_Documento_idcontroller = TextEditingController();

  void _EnviarFormulario() async {
    if (_formKey.currentState!.validate()) {
      final String ApiUrl = "http://172.20.10.9/insertarPrestamo/";
      final Map<String, dynamic> requestBody = {
        'Equ_id': _Pres_idcontroller.text,
        'Equi_tipo': _Pres_Fec_Entregacontroller.text,
        'Equi_modelo': _Pres_Tiempo_Limitecontroller.text,
        'Equi_color': _Pres_observaciones_entregacontroller.text,
        'Equi_serial': _Equi_serialcontroller.text,
        'Equi_estado': _Pres_Equipos_idcontroller.text,
        'equi_especialidad': _Pres_Usuarios_Documento_idcontroller.text
      };

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ConsultarPrestamosApi()));

      final Respuesta = await http.post(Uri.parse(ApiUrl),
          headers: {'Content-type': 'application/json'},
          body: json.encode(requestBody));

      if (Respuesta.statusCode == 200) {
        print('Datos enviados correctamente');
      } else {
        print('Error al enviar los datos');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Equipos"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _Pres_idcontroller,
                decoration: InputDecoration(
                  labelText: 'ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el id';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Pres_Fec_Entregacontroller,
                decoration: InputDecoration(
                  labelText: 'Tipo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el tipo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Pres_Tiempo_Limitecontroller,
                decoration: InputDecoration(
                  labelText: 'Modelo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el modelo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Pres_observaciones_entregacontroller,
                decoration: InputDecoration(
                  labelText: 'Color',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el color';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Equi_serialcontroller,
                decoration: InputDecoration(
                  labelText: 'Serial',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el serial';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Pres_Equipos_idcontroller,
                decoration: InputDecoration(
                  labelText: 'Estado',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el estado';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Pres_Usuarios_Documento_idcontroller,
                decoration: InputDecoration(
                  labelText: 'Especialidad',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese la especialidad';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _EnviarFormulario,
                child: const Text('Guardar Datos'),
              )
            ],
          ),
        ),
      ),
    );
  }
}