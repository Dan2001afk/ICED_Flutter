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

  @override
  void initState() {
    super.initState();
    ConsultarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue, // Color principal de la aplicación
         // Color de acento
        fontFamily: 'Roboto', // Fuente de texto
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
                  }
                },
                child: const Text('Buscar Equipo'),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: Datos.length,
                  itemBuilder: (context, index) {
                    final item = Datos[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      elevation: 4, // Sombra del card
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
