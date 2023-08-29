import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ConsultarUsuariosApi());
}

class ConsultarUsuariosApi extends StatefulWidget {
  const ConsultarUsuariosApi({Key? key}) : super(key: key);

  @override
  State<ConsultarUsuariosApi> createState() => _ConsultarUsuariosApiState();
}

class _ConsultarUsuariosApiState extends State<ConsultarUsuariosApi> {
  List<dynamic> DatosUsuario = [];
  TextEditingController usuarioIdController= TextEditingController();

  Future<void> ConsultarDatos() async {
    final url = Uri.parse("http://192.168.238.223/ListarUsuarios");
    final Respuesta = await http.get(url);
    if (Respuesta.statusCode == 200) {
      final jsonResponse = json.decode(Respuesta.body);
      setState(() {
        DatosUsuario = List.from(jsonResponse);
      });
    } else {
      print("Error: No se consultó la Api");
    }
  }

  Future<void> BuscarUsuario(int usuarioId) async {
    final url = Uri.parse("http://192.168.1.44/BuscarUsuario/$usuarioId");
    final Respuesta = await http.get(url);
    if (Respuesta.statusCode == 200) {
      final jsonResponse = json.decode(Respuesta.body);
      setState(() {
        DatosUsuario = [jsonResponse];
      });
    } else {
      print("Error: No se encontró el Usuario");
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
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Datos Usuario"),
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
                controller: usuarioIdController,
                decoration: InputDecoration(
                  labelText: 'ID del Usuario',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final usuarioId = int.tryParse(usuarioIdController.text);
                  if (usuarioId != null) {
                    BuscarUsuario(usuarioId);
                  }
                },
                child: const Text('Buscar Usuario'),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: DatosUsuario.length,
                  itemBuilder: (context, index) {
                    final item = DatosUsuario[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                item['Usu_Documento'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Center(child: Text('Nombre: ${item['Usu_Nombre']}')),
                            Center(child: Text('Apellido: ${item['Usu_Apellido']}')),
                            Center(child: Text('Tipo: ${item['Usu_tipo']}')),
                            Center(child: Text('Celular: ${item['Usu_Celular']}')),
                            Center(child: Text('Correo: ${item['Usu_Correo']}')),
                            Center(child: Text('Ficha: ${item['Usu_Ficha']}')),
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
