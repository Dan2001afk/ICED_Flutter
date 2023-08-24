import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'DatosEquipos.dart';


class InsertarEquipo extends StatefulWidget {
  const InsertarEquipo({Key? key}) : super(key: key);

  @override
  State<InsertarEquipo> createState() => _InsertarEquipoState();
}

class _InsertarEquipoState extends State<InsertarEquipo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _Equ_idcontroller = TextEditingController();
  final TextEditingController _Equi_tipocontroller = TextEditingController();
  final TextEditingController _Equi_modelocontroller = TextEditingController();
  final TextEditingController _Equi_colorcontroller = TextEditingController();
  final TextEditingController _Equi_serialcontroller = TextEditingController();
  final TextEditingController _Equi_estadocontroller = TextEditingController();
  final TextEditingController _equi_especialidadcontroller = TextEditingController();

  void _EnviarFormulario() async {
    if (_formKey.currentState!.validate()) {
      final String ApiUrl = "http://192.168.1.18/insertar/";
      final Map<String, dynamic> requestBody = {
        'Equ_id': _Equ_idcontroller.text,
        'Equi_tipo': _Equi_tipocontroller.text,
        'Equi_modelo': _Equi_modelocontroller.text,
        'Equi_color': _Equi_colorcontroller.text,
        'Equi_serial': _Equi_serialcontroller.text,
        'Equi_estado': _Equi_estadocontroller.text,
        'equi_especialidad': _equi_especialidadcontroller.text
      };

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ConsultarEquiposApi()));

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
                controller: _Equ_idcontroller,
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
                controller: _Equi_tipocontroller,
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
                controller: _Equi_modelocontroller,
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
                controller: _Equi_colorcontroller,
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
                controller: _Equi_estadocontroller,
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
                controller: _equi_especialidadcontroller,
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
