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

  Future<void> ConsultarDatos() async {
    final url = Uri.parse("http://10.190.82.220/ListarEquipos");
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
    final url = Uri.parse("http://10.190.82.220/BuscarEquipo/$equipoId");
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
    final url = Uri.parse("http://10.190.82.220/EliminarEquipo/$equipoId");
    final Respuesta = await http.delete(url);
    if (Respuesta.statusCode == 200) {
      final jsonResponse = json.decode(Respuesta.body);
      print(jsonResponse['Mensaje']);
      ConsultarDatos();
    } else {
      print("Error: No se pudo eliminar el equipo");
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final equipoId = int.tryParse(equipoIdController.text);
                      if (equipoId != null) {
                        BuscarEquipo(equipoId);
                      }
                    },
                    child: const Text('Buscar Equipo'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final equipoId = int.tryParse(equipoIdController.text);
                      if (equipoId != null) {
                        // Mostrar el diálogo de confirmación
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Elimainar'),
                              content: Text('¿ESTAS SEGURO DE ELIMINAR EL DISPOSTIVO?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Cerrar el diálogo
                                  },
                                  child: Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Cerrar el diálogo
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
                ],
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
