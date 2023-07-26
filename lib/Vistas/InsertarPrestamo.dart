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
  final TextEditingController _Pres_Idcontroller = TextEditingController();
  final TextEditingController _Pres_Hora_Entregacontroller=TextEditingController();
  final TextEditingController _Pres_Fec_Entregacontroller = TextEditingController();
  final TextEditingController _Pres_Tiempo_Limitecontroller = TextEditingController();
  final TextEditingController _Pres_observaciones_entregacontroller = TextEditingController();
  final TextEditingController _Equi_serialcontroller = TextEditingController();
  final TextEditingController _Pres_Equipos_idcontroller = TextEditingController();
  final TextEditingController _Pres_Usuarios_Documento_idcontroller = TextEditingController();


  void _EnviarFormulario() async {
    if (_formKey.currentState!.validate()) {
      final String ApiUrl = "http://192.168.0.107/insertarPrestamo/";
      final Map<String, dynamic> requestBody = {
        'Pre_Id': _Pres_Idcontroller.text,
        'Pres_Fec_Entrega': _Pres_Fec_Entregacontroller.text,
        'Pres_Hora_Entrega': _Pres_Hora_Entregacontroller.text,
        'Pres_Tiempo_Limite': _Pres_Tiempo_Limitecontroller.text,
        'Pres_observaciones_entrega': _Pres_observaciones_entregacontroller.text,
        'Equi_serial': _Equi_serialcontroller.text,
        'Pres_Equipos_id': _Pres_Equipos_idcontroller.text,
        'Pres_Usuarios_Documento_id': _Pres_Usuarios_Documento_idcontroller.text
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
  int _formatHoraToMinutes(String hora) {
    final parts = hora.split(':');
    final horas = int.parse(parts[0]);
    final minutos = int.parse(parts[1]);
    return horas * 60 + minutos;
  }
  @override
  void initState() {
    super.initState();
    // Asignar la fecha actual al controlador al cargar la pantalla
    _Pres_Fec_Entregacontroller.text = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Asignar la hora actual al controlador al cargar la pantalla
    _setHoraActual();
  }

  void _setHoraActual() {
    final horaActual = TimeOfDay.now();
    _Pres_Hora_Entregacontroller.text =
    '${horaActual.hour.toString().padLeft(2, '0')}:${horaActual.minute.toString().padLeft(2, '0')}';
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de PRESTAMOS"),
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
                controller: _Pres_Idcontroller,
                decoration: InputDecoration(
                  labelText: 'ID ',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el id del prestamo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Pres_Hora_Entregacontroller,
                decoration: InputDecoration(
                  labelText: 'Hora Entrega',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese la hora de Entrega';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Pres_Fec_Entregacontroller,
                decoration: InputDecoration(
                  labelText: 'Fecha Entrega',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese la Fecha de Entrega';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Pres_Tiempo_Limitecontroller,
                decoration: InputDecoration(
                  labelText: 'Tiempo limite ',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tiempo limite';
                  }
                  return null;
                },
              ),


              const SizedBox(height: 16),
              TextFormField(
                controller: _Pres_observaciones_entregacontroller,
                decoration: InputDecoration(
                  labelText: 'Obsercacion',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Odservacion';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Pres_Equipos_idcontroller,
                decoration: InputDecoration(
                    labelText: 'prestamo equipo ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'prestamo equipo ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _Pres_Usuarios_Documento_idcontroller,
                decoration: InputDecoration(
                  labelText: 'Documento del usuario ',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Documento del usuario';
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