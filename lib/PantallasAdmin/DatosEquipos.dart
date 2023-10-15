import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const ConsultarEquiposApi());
}

class ConsultarEquiposApi extends StatefulWidget {
  const ConsultarEquiposApi({Key? key}) : super(key: key);

  @override
  State<ConsultarEquiposApi> createState() => _ConsultarEquiposApiState();
}

class _ConsultarEquiposApiState extends State<ConsultarEquiposApi> {
  List<dynamic> datos = [];
  TextEditingController equipoIdController = TextEditingController();
  TextEditingController nuevoTipoController = TextEditingController();
  TextEditingController nuevoModeloController = TextEditingController();
  TextEditingController nuevoColorController = TextEditingController();
  TextEditingController nuevoSerialController = TextEditingController();
  TextEditingController nuevoEstadoController = TextEditingController();
  TextEditingController nuevaEspecialidadController = TextEditingController();

  Future<void> consultarDatos() async {
    final url = Uri.parse("http://192.168.1.44/ListarEquipos");
    final respuesta = await http.get(url);
    if (respuesta.statusCode == 200) {
      final jsonResponse = json.decode(respuesta.body);
      setState(() {
        datos = List.from(jsonResponse);
      });
    } else {
      print("Error: No se consultó la API");
    }
  }

  Future<void> buscarEquipo(int equipoId) async {
    final url = Uri.parse("http://192.168.1.44/BuscarEquipoID/$equipoId");
    final respuesta = await http.get(url);
    if (respuesta.statusCode == 200) {
      final jsonResponse = json.decode(respuesta.body);
      setState(() {
        datos = [jsonResponse];
      });
    } else {
      print("Error: No se encontró el equipo");
    }
  }

  Future<void> eliminarEquipo(int equipoId) async {
    final url = Uri.parse("http://192.168.1.44/EliminarEquipo/$equipoId");
    final respuesta = await http.delete(url);
    if (respuesta.statusCode == 200) {
      final jsonResponse = json.decode(respuesta.body);
      Fluttertoast.showToast(msg: jsonResponse['Mensaje']);
      consultarDatos();
    } else {
      print("Error: No se pudo eliminar el equipo");
    }
  }

  Future<void> actualizarEquipo(
      int equipoId,
      String nuevoTipo,
      String nuevoModelo,
      String nuevoColor,
      String nuevoSerial,
      String nuevoEstado,
      String nuevaEspecialidad,
      ) async {
    final url = Uri.parse("http://192.168.1.44/ActualizarEquipo/$equipoId");
    final respuesta = await http.post(
      url,
      body: jsonEncode({
        "Equ_id": equipoId,
        "Equi_tipo": nuevoTipo,
        "Equi_modelo": nuevoModelo,
        "Equi_color": nuevoColor,
        "Equi_serial": nuevoSerial,
        "Equi_estado": nuevoEstado,
        "equi_especialidad": nuevaEspecialidad,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (respuesta.statusCode == 200) {
      final jsonResponse = json.decode(respuesta.body);
      Fluttertoast.showToast(msg: jsonResponse['Mensaje']);
      consultarDatos();
    } else {
      print("Error: No se pudo actualizar el equipo");
    }
  }

  @override
  void initState() {
    super.initState();
    consultarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.purple,
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Acciones Equipos"),
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
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: equipoIdController,
                      decoration: InputDecoration(
                        labelText: 'ID del Equipo',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      final equipoId = int.tryParse(equipoIdController.text);
                      if (equipoId != null) {
                        buscarEquipo(equipoId);
                      }
                    },
                    icon: Icon(Icons.search),
                    label: Text('Buscar'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton.icon(
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
                                    await actualizarEquipo(
                                      equipoId!,
                                      nuevoTipoController.text,
                                      nuevoModeloController.text,
                                      nuevoColorController.text,
                                      nuevoSerialController.text,
                                      nuevoEstadoController.text,
                                      nuevaEspecialidadController.text,
                                    );
                                  },
                                  child: Text('Actualizar Equipo'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    icon: Icon(Icons.update),
                    label: Text('Editar Equipo'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton.icon(
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
                                    eliminarEquipo(equipoId);
                                  },
                                  child: Text('Eliminar'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    icon: Icon(Icons.delete),
                    label: Text('Eliminar Equipo'),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Expanded(
                child: datos.isEmpty
                    ? Center(
                  child: Text(
                    'No hay datos disponibles',
                    style: TextStyle(fontSize: 18),
                  ),
                )
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text(
                          'ID',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Tipo',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Modelo',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Color',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Serial',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Estado',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Especialidad',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: datos.map((item) {
                      return DataRow(
                        cells: [
                          DataCell(Text(item['Equ_id'].toString())),
                          DataCell(Text(item['Equi_tipo'])),
                          DataCell(Text(item['Equi_modelo'])),
                          DataCell(Text(item['Equi_color'])),
                          DataCell(Text(item['Equi_serial'])),
                          DataCell(Text(item['Equi_estado'])),
                          DataCell(Text(item['equi_especialidad'])),
                        ],
                      );
                    }).toList(),
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
