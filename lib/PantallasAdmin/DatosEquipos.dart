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
  List<dynamic> DatosFiltrados = [];

  Future<void> ConsultarDatos() async {
    final url = Uri.parse("http://10.190.80.127/ListarEquipos");
    final Respuesta = await http.get(url);
    if (Respuesta.statusCode == 200) {
      print("La Api se consultó correctamente");
      final jsonResponse = json.decode(Respuesta.body);
      setState(() {
        Datos = List.from(jsonResponse);
        DatosFiltrados = Datos; // Inicialmente, los datos filtrados son los mismos que los datos originales
        print(Datos);
      });
    } else {
      print("Error: No se consultó la Api");
    }
  }

  void _filtrarPorId(int id) {
    setState(() {
      DatosFiltrados = Datos.where((item) {
        final itemId = item['Equ_id'] as int;
        return itemId == id;
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    ConsultarDatos();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Datos"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                final String? query = await showSearch(
                  context: context,
                  delegate: DataSearch(),
                );
                if (query != null && query.isNotEmpty) {
                  _filtrarPorId(int.parse(query));
                }
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: DatosFiltrados.length,
          itemBuilder: (context, index) {
            final item = DatosFiltrados[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        item['Equ_id'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(child: Text('Tipo: ${item['Equi_tipo']}')),
                    Center(child: Text('Modelo: ${item['Equi_modelo']}')),
                    Center(child: Text('Color: ${item['Equi_color']}')),
                    Center(child: Text('Serial: ${item['Equi_serial']}')),
                    Center(child: Text('Estado: ${item['Equi_estado']}')),
                    Center(child: Text('Especialidad: ${item['equi_especialidad']}')),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // No se necesita implementar resultados en este ejemplo
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); // No se necesita implementar sugerencias en este ejemplo
  }
}
