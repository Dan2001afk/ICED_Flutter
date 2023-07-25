import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'DatosUsuarios.dart';

class InsertarUsuarios extends StatefulWidget {
  const InsertarUsuarios({Key? key}) : super(key: key);

  @override
  State<InsertarUsuarios> createState() => _InsertarUsuariosState();
}

class _InsertarUsuariosState extends State<InsertarUsuarios> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _Usu_Documentocontroller = TextEditingController();
  final TextEditingController _Usu_Nombrecontroller = TextEditingController();
  final TextEditingController _Usu_Apellidocontroller = TextEditingController();
  final TextEditingController _Usu_tipocontroller = TextEditingController();
  final TextEditingController _Usu_Celularcontroller = TextEditingController();
  final TextEditingController _Usu_Correocontroller = TextEditingController();
  final TextEditingController _Usu_Fichacontroller = TextEditingController();

  void _EnviarFormulario() async {
    if (_formKey.currentState!.validate()) {
      final String ApiUrl = "http://172.20.10.9/insertarUsuario/";
      final Map<String, dynamic> requestBody = {
        'Usu_Documento': _Usu_Documentocontroller.text,
        'Usu_Nombre': _Usu_Nombrecontroller.text,
        'Usu_Apellido': _Usu_Apellidocontroller.text,
        'Usu_tipo': _Usu_tipocontroller.text,
        'Usu_Celular': _Usu_Celularcontroller.text,
        'Usu_Correo': _Usu_Correocontroller.text,
        'Usu_Ficha': _Usu_Fichacontroller.text
      };

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ConsultarUsuariosApi()));

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
        title: const Text("Registro de Usuarios"),
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
                controller: _Usu_Documentocontroller,
                decoration: InputDecoration(
                  labelText: 'Documento',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el Documento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Usu_Nombrecontroller,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el Nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Usu_Apellidocontroller,
                decoration: InputDecoration(
                  labelText: 'Apellido',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el apellido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Usu_tipocontroller,
                decoration: InputDecoration(
                  labelText: 'Tipo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tipo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Usu_Celularcontroller,
                decoration: InputDecoration(
                  labelText: 'Celular',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el Celular';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Usu_Correocontroller,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Correo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Usu_Fichacontroller,
                decoration: InputDecoration(
                  labelText: 'Fecha',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese la Fecha';
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