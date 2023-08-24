import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ConsultarPrestamosApi());
}

class ConsultarPrestamosApi extends StatefulWidget {
  const ConsultarPrestamosApi({Key? key}) : super(key: key);

  @override
  State<ConsultarPrestamosApi> createState() => _ConsultarPrestamosApiState();
}

class _ConsultarPrestamosApiState extends State<ConsultarPrestamosApi> {
  List<dynamic> DatosPrestamos = [];

  Future<void> ConsultarDatosPrestamos() async {
    final url = Uri.parse("http://10.190.80.127/ListarPrestamos");
    final Respuesta = await http.get(url);
    if (Respuesta.statusCode == 200) {
      print("La Api se consultó correctamente");
      final jsonResponse = json.decode(Respuesta.body);
      setState(() {
        DatosPrestamos = List.from(jsonResponse);
        print(DatosPrestamos);
      });
    } else {
      print("Error: No se consultó la Api");
    }
  }

  @override
  void initState() {
    super.initState();
    ConsultarDatosPrestamos();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Datos Prestamos"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView.builder(
          itemCount: DatosPrestamos.length,
          itemBuilder: (context, index) {
            final item = DatosPrestamos[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        item['Pres_Id'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(child: Text('Fecha Entrega: ${item['Pres_Fec_Entrega']}')),
                    Center(child: Text('Hora Entrega: ${item['Pres_Hora_Entrega']}')),
                    Center(child: Text('Tiempo Limite: ${item['Pres_Tiempo_Limite']}')),
                    Center(child: Text('Observaciones: ${item['Pres_Observaciones_entrega']}')),
                    Center(child: Text('Equipo ID: ${item['Pres_Equipos_id']}')),
                    Center(child: Text('Usuario Documento: ${item['Pres_Usuarios_Documento_id']}')),
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