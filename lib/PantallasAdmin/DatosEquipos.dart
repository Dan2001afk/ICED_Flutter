import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ConsultarEquiposApi());
}

class ConsultarEquiposApi extends StatefulWidget {
  const ConsultarEquiposApi({Key? key}) : super(key: key);

  @override
  State<ConsultarEquiposApi> createState() => _ConsultarEquiposApiState();
}

class _ConsultarEquiposApiState extends State<ConsultarEquiposApi> {
  List<dynamic> Datos = [];
  TextEditingController equipoIdController = TextEditingController();
  TextEditingController nuevoTipoController = TextEditingController();
  TextEditingController nuevoModeloController = TextEditingController();
  TextEditingController nuevoColorController = TextEditingController();
  TextEditingController nuevoSerialController = TextEditingController();
  TextEditingController nuevoEstadoController = TextEditingController();
  TextEditingController nuevaEspecialidadController = TextEditingController();

  Future<void> ConsultarDatos() async {
    final url = Uri.parse("http://192.168.1.44/ListarEquipos");
    final Respuesta = await http.get(url);
    if (Respuesta.statusCode == 200) {
      final jsonResponse = json.decode(Respuesta.body);
      setState(() {
        Datos = List.from(jsonResponse);
      });
    } else {
      print("Error: No se consultó la Api");
    }
  }

  Future<void> BuscarEquipo(int equipoId) async {
    final url = Uri.parse("http://192.168.1.44/BuscarEquipo/$equipoId");
    final Respuesta = await http.get(url);
    if (Respuesta.statusCode == 200) {
      final jsonResponse = json.decode(Respuesta.body);
      setState(() {
        Datos = [jsonResponse];
      });
    } else {
      print("Error: No se encontró el equipo");
    }
  }

  Future<void> EliminarEquipo(int equipoId) async {
    final url = Uri.parse("http://192.168.1.44/EliminarEquipo/$equipoId");
    final Respuesta = await http.delete(url);
    if (Respuesta.statusCode == 200) {
      final jsonResponse = json.decode(Respuesta.body);
      print(jsonResponse['Mensaje']);
      ConsultarDatos();
    } else {
      print("Error: No se pudo eliminar el equipo");
    }
  }

  Future<void> ActualizarEquipo(
      int equipoId,
      String nuevoTipo,
      String nuevoModelo,
      String nuevoColor,
      String nuevoSerial,
      String nuevoEstado,
      String nuevaEspecialidad,
      ) async {
    final url = Uri.parse("http://192.168.1.44/ActualizarEquipo/$equipoId");
    final Respuesta = await http.post(
      url,
      body: jsonEncode({
        "Equ_id": equipoId, // Usar el ID recibido como parámetro
        "Equi_tipo": nuevoTipo,
        "Equi_modelo": nuevoModelo,
        "Equi_color": nuevoColor,
        "Equi_serial": nuevoSerial,
        "Equi_estado": nuevoEstado,
        "equi_especialidad": nuevaEspecialidad,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (Respuesta.statusCode == 200) {
      final jsonResponse = json.decode(Respuesta.body);
      print(jsonResponse['Mensaje']);
      ConsultarDatos();
    } else {
      print("Error: No se pudo actualizar el equipo");
    }
  }


  Future<void> cargarDatosExistente(int equipoId) async {
    final url = Uri.parse("http://192.168.1.44/BuscarEquipo/$equipoId");
    final Respuesta = await http.get(url);
    if (Respuesta.statusCode == 200) {
      final jsonResponse = json.decode(Respuesta.body);
      final item = jsonResponse;
      nuevoTipoController.text = item['Equi_tipo'];
      nuevoModeloController.text = item['Equi_modelo'];
      nuevoColorController.text = item['Equi_color'];
      nuevoSerialController.text = item['Equi_serial'];
      nuevoEstadoController.text = item['Equi_estado'];
      nuevaEspecialidadController.text = item['equi_especialidad'];
    } else {
      print("Error: No se pudieron cargar los datos existentes");
    }
  }

  @override
  void initState() {
    super.initState();
    ConsultarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
        fontFamily: 'Roboto',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Datos"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: equipoIdController,
                decoration: InputDecoration(
                  labelText: 'ID del Equipo',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final equipoId = int.tryParse(equipoIdController.text);
                  if (equipoId != null) {
                    BuscarEquipo(equipoId);
                    cargarDatosExistente(equipoId);
                  }
                },
                child: const Text('Buscar Equipo'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final equipoId = int.tryParse(equipoIdController.text);
                  if (equipoId != null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Actualizar Equipo'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextField(
                                  controller: nuevoTipoController,
                                  decoration: InputDecoration(labelText: 'Nuevo Tipo'),
                                ),
                                TextField(
                                  controller: nuevoModeloController,
                                  decoration: InputDecoration(labelText: 'Nuevo Modelo'),
                                ),
                                TextField(
                                  controller: nuevoColorController,
                                  decoration: InputDecoration(labelText: 'Nuevo Color'),
                                ),
                                TextField(
                                  controller: nuevoSerialController,
                                  decoration: InputDecoration(labelText: 'Nuevo Serial'),
                                ),
                                TextField(
                                  controller: nuevoEstadoController,
                                  decoration: InputDecoration(labelText: 'Nuevo Estado'),
                                ),
                                TextField(
                                  controller: nuevaEspecialidadController,
                                  decoration: InputDecoration(labelText: 'Nueva Especialidad'),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await ActualizarEquipo(
                                  equipoId,
                                  nuevoTipoController.text,
                                  nuevoModeloController.text,
                                  nuevoColorController.text,
                                  nuevoSerialController.text,
                                  nuevoEstadoController.text,
                                  nuevaEspecialidadController.text,
                                );
                              },
                              child: Text('Actualizar'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Actualizar Equipo'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final equipoId = int.tryParse(equipoIdController.text);
                  if (equipoId != null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Eliminar'),
                          content: Text('¿ESTÁS SEGURO DE ELIMINAR EL DISPOSITIVO?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                EliminarEquipo(equipoId);
                              },
                              child: Text('Eliminar'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Eliminar Equipo por ID'),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: Datos.length,
                  itemBuilder: (context, index) {
                    final item = Datos[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['Equ_id'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('Tipo: ${item['Equi_tipo']}'),
                            Text('Modelo: ${item['Equi_modelo']}'),
                            Text('Color: ${item['Equi_color']}'),
                            Text('Serial: ${item['Equi_serial']}'),
                            Text('Estado: ${item['Equi_estado']}'),
                            Text('Especialidad: ${item['equi_especialidad']}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
