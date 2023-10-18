import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const DatosSanciones());
}

class DatosSanciones extends StatefulWidget {
  const DatosSanciones({Key? key}) : super(key: key);

  @override
  State<DatosSanciones> createState() => _DatosSancionesState();
}

class _DatosSancionesState extends State<DatosSanciones> {
  List<dynamic> datosSanciones = [];
  TextEditingController sancionIdController = TextEditingController();
  TextEditingController nuevoPresIdController = TextEditingController();
  TextEditingController nuevoTiempoController = TextEditingController();
  TextEditingController nuevaDescripcionController = TextEditingController();

  Future<void> consultarDatosSanciones() async {
    final url = Uri.parse("http://192.168.1.44/ListarSanciones");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        datosSanciones = List.from(jsonResponse);
      });
    } else {
      print("Error en la solicitud: ${response.statusCode}");
      print("Cuerpo de la respuesta: ${response.body}");
      print("Error: No se consultó la API de sanciones");
    }
  }

  Future<void> buscarSancion(int sancionId) async {
    final url = Uri.parse("http://192.168.1.44/BuscarSancion/$sancionId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        datosSanciones = [jsonResponse];
      });
    } else {
      print("Error en la solicitud: ${response.statusCode}");
      print("Cuerpo de la respuesta: ${response.body}");
      print("Error: No se encontró la sanción");
    }
  }

  Future<void> eliminarSancion(int sancionId) async {
    final url = Uri.parse("http://192.168.1.44/EliminarSancion/$sancionId");
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse['Mensaje']);
      consultarDatosSanciones();
    } else {
      print("Error en la solicitud: ${response.statusCode}");
      print("Cuerpo de la respuesta: ${response.body}");

      // Mostrar un diálogo de error al usuario
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error al eliminar la sanción'),
            content: Text('No se pudo eliminar la sanción. Inténtelo de nuevo más tarde.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cerrar el diálogo
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }


  Future<void> actualizarSancion(
      int sancionId,
      String nuevoPresId,
      String nuevoTiempo,
      String nuevaDescripcion,
      ) async {
    final url = Uri.parse("http://192.168.1.44/ActualizarSanciones/$sancionId");

    final requestBody = {
      'San_Pres_id': nuevoPresId,
      'San_tiempo': nuevoTiempo,
      'San_Descripcion': nuevaDescripcion,
    };

    if (sancionId != null) {
      requestBody['San_Id'] = sancionId.toString();
    }

    final response = await http.put(
      url,
      body: jsonEncode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse['Mensaje']);
      consultarDatosSanciones();
    } else {
      print("Error en la solicitud: ${response.statusCode}");
      print("Cuerpo de la respuesta: ${response.body}");
      print("Error: No se pudo actualizar la sanción");
    }
  }

  Future<void> cargarDatosSancion(int index) async {
    if (datosSanciones.isNotEmpty && index < datosSanciones.length) {
      final item = datosSanciones[index];
      if (item['San_Id'] != null) {
        sancionIdController.text = item['San_Id'].toString();
        nuevoPresIdController.text = item['San_Pres_id'] ?? '';
        nuevoTiempoController.text = item['San_tiempo'] ?? '';
        nuevaDescripcionController.text = item['San_Descripcion'] ?? '';
      } else {
        print("Error: El campo 'San_Id' es nulo");
      }
    } else {
      print("Error: DatosSanciones está vacía o el índice es inválido");
    }
  }

  @override
  void initState() {
    super.initState();
    consultarDatosSanciones();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Datos de Sanciones"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.purple, // Color rojo para el encabezado
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: sancionIdController,
                decoration: InputDecoration(
                  labelText: 'ID de la Sanción',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final sancionId = int.tryParse(sancionIdController.text);
                  if (sancionId != null) {
                    buscarSancion(sancionId);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple, // Color rojo para el botón
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.search),
                    SizedBox(width: 8),
                    Text('Buscar Sanción'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final sancionId = int.tryParse(sancionIdController.text);
                      if (sancionId != null) {
                        // Mostrar el diálogo de confirmación
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Eliminar'),
                              content: Text('¿ESTÁS SEGURO DE ELIMINAR LA SANCION?'),
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
                                    eliminarSancion(sancionId);
                                  },
                                  child: Text('Eliminar'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple, // Color rojo para el botón
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.delete),
                        SizedBox(width: 8),
                        Text('Eliminar'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final sancionId = int.tryParse(sancionIdController.text);
                      if (sancionId != null) {
                        cargarDatosSancion(0);
                        // Mostrar el diálogo de actualización
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Actualizar Sanción'),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: sancionIdController,
                                      decoration: InputDecoration(labelText: 'Nuevo ID'),
                                    ),
                                    TextField(
                                      controller: nuevoPresIdController,
                                      decoration: InputDecoration(labelText: 'Nuevo ID de Préstamo'),
                                    ),
                                    TextField(
                                      controller: nuevoTiempoController,
                                      decoration: InputDecoration(labelText: 'Nuevo Tiempo'),
                                    ),
                                    TextField(
                                      controller: nuevaDescripcionController,
                                      decoration: InputDecoration(labelText: 'Nueva Descripción'),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Cerrar el diálogo
                                  },
                                  child: Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop(); // Cerrar el diálogo
                                    await actualizarSancion(
                                      sancionId,
                                      nuevoPresIdController.text,
                                      nuevoTiempoController.text,
                                      nuevaDescripcionController.text,
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
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple, // Color rojo para el botón
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text('Actualizar'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: datosSanciones.length,
                  itemBuilder: (context, index) {
                    final item = datosSanciones[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                item['San_Id'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Center(child: Text('ID del Préstamo: ${item['San_Pres_id']}')),
                            Center(child: Text('Tiempo de Sanción: ${item['San_tiempo']}')),
                            Center(child: Text('Descripción: ${item['San_Descripcion']}')),
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