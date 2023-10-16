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
  TextEditingController prestamoIdController = TextEditingController();

  Future<void> ConsultarDatosPrestamos() async {
    final url = Uri.parse("http://192.168.1.44/ListarPrestamos");
    final Respuesta = await http.get(url);
    if (Respuesta.statusCode == 200) {
      final jsonResponse = json.decode(Respuesta.body);
      setState(() {
        DatosPrestamos = List.from(jsonResponse);
      });
    } else {
      print("Error: No se consultó la API");
    }
  }

  Future<void> BuscarPrestamo(int Pres_Id) async {
    final url = Uri.parse("http://192.168.1.44/BuscarPrestamo/$Pres_Id");
    final Respuesta = await http.get(url);
    if (Respuesta.statusCode == 200) {
      final jsonResponse = json.decode(Respuesta.body);
      setState(() {
        DatosPrestamos = [jsonResponse];
      });
    } else {
      print("Error: No se encontró el Préstamo");
    }
  }

  Future<void> EliminarPrestamo(int Pres_Id) async {
    final url = Uri.parse("http://192.168.1.44/EliminarPrestamo/$Pres_Id");
    final Respuesta = await http.delete(url);
    if (Respuesta.statusCode == 200) {
      final jsonResponse = json.decode(Respuesta.body);
      print(jsonResponse['Mensaje']);
      ConsultarDatosPrestamos();
    } else {
      print("Error: No se pudo eliminar el Préstamo");
    }
  }

  @override
  void initState() {
    super.initState();
    ConsultarDatosPrestamos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Datos Préstamos"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.purple, // Color púrpura para el encabezado
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: prestamoIdController,
                decoration: InputDecoration(
                  labelText: 'ID del Préstamo',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final prestamoID = int.tryParse(prestamoIdController.text);
                        if (prestamoID != null) {
                          BuscarPrestamo(prestamoID);
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.purple),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Buscar', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // Espacio entre los botones
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final prestamoID = int.tryParse(prestamoIdController.text);
                        if (prestamoID != null) {
                          // Mostrar el diálogo de confirmación
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Eliminar'),
                                content: Text('¿ESTÁS SEGURO DE ELIMINAR EL PRÉSTAMO?'),
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
                                      EliminarPrestamo(prestamoID);
                                    },
                                    child: Text('Eliminar'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.purple),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Eliminar ', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
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
            ],
          ),
        ),
      ),
    );
  }
}
