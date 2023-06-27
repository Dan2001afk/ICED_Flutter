import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Datos.dart';

class InsertarEquipo extends StatefulWidget {
  const InsertarEquipo({Key? key}) : super(key: key);

  @override
  State<InsertarEquipo> createState() => _InsertarEquipoState();
}

class _InsertarEquipoState extends State<InsertarEquipo> {
  final  GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final TextEditingController _Equ_idcontroller=TextEditingController();
  final TextEditingController _Equi_tipocontroller=TextEditingController();
  final TextEditingController _Equi_modelocontroller=TextEditingController();
  final TextEditingController _Equi_colorcontroller=TextEditingController();
  final TextEditingController _Equi_serialcontroller=TextEditingController();
  final TextEditingController _Equi_estadocontroller=TextEditingController();
  final TextEditingController _equi_especialidadcontroller=TextEditingController();

  void _EnviarFormulario() async {
    if (_formKey.currentState!.validate()) {
      final String ApiUrl = "http://192.168.0.107/insertar/";
      final Map<String, dynamic> requestBody = {
        'Equ_id': _Equ_idcontroller.text.toString(),
        'Equi_tipo': _Equi_tipocontroller.text,
        'Equi_modelo': _Equi_modelocontroller.text,
        'Equi_color': _Equi_colorcontroller.text,
        'Equi_serial': _Equi_serialcontroller.text,
        'Equi_estado': _Equi_estadocontroller.text,
        'equi_especialidad': _equi_especialidadcontroller.text
      };
      final Respuesta = await http.post(
        Uri.parse(ApiUrl),
        headers: {'Content-type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (Respuesta.statusCode == 200) {
        print('Datos enviados correctamente');

        // Esperar un poco antes de navegar a la pantalla de consulta
        await Future.delayed(Duration(seconds: 1));

        // Actualizar la lista de datos en la pantalla de consulta
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ConsultarApi(),
          ),
        );
      } else {
        print('Error al enviar los datos');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Insertar Datos")),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _Equ_idcontroller,
                decoration: InputDecoration(labelText: 'Equ_id'),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Ingrese el id';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _Equi_tipocontroller,
                decoration: InputDecoration(labelText: 'Equi_tipo'),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Ingrese el tipo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _Equi_modelocontroller,
                decoration: InputDecoration(labelText: 'Equi_modelo'),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Ingrese el modelo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _Equi_colorcontroller,
                decoration: InputDecoration(labelText: 'Equi_color'),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Ingrese el color';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _Equi_serialcontroller,
                decoration: InputDecoration(labelText: 'Equi_serial'),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Ingrese el serial';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _Equi_estadocontroller,
                decoration: InputDecoration(labelText: 'Equi_estado'),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Ingrese el estado';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _equi_especialidadcontroller,
                decoration: InputDecoration(labelText: 'equi_especialidad'),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Ingrese la especialidad';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: _EnviarFormulario,
                child: Text('Guardar Datos'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
