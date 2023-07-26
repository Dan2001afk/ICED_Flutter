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

  Future<void> ConsultarDatos() async {
    final url = Uri.parse("http://192.168.0.107/ListarEquipos");
    final Respuesta = await http.get(url);
    if (Respuesta.statusCode == 200) {
      print("La Api se consultó correctamente");
      final jsonResponse = json.decode(Respuesta.body);
      setState(() {
        Datos = List.from(jsonResponse);
        print(Datos);
      });
    } else {
      print("Error: No se consultó la Api");
    }
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
        ),
        body: ListView.builder(
          itemCount: Datos.length,
          itemBuilder: (context, index) {
            final item = Datos[index];
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


