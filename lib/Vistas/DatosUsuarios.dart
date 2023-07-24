import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main(){
  runApp(const ConsultarApiUsuarios());
}


class ConsultarApiUsuarios extends StatefulWidget {
  const ConsultarApiUsuarios({Key? key}) : super(key: key);

  @override
  State<ConsultarApiUsuarios> createState() => _ConsultarApiUsuariosState();
}

class _ConsultarApiUsuariosState extends State<ConsultarApiUsuarios> {
  List<dynamic> DatosUsuario = [];
  Future<void> ConsultarDatos() async {
    final url = Uri.parse("http://172.20.10.9/ListarUsuarios");
    final Respuesta = await http.get(url);
    if (Respuesta.statusCode == 200) {
      print("La Api se consultó correctamente");
      final jsonResponse = json.decode(Respuesta.body);
      setState(() {
        DatosUsuario = List.from(jsonResponse);
        print(DatosUsuario);
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
          title: const Text("Datos Usuario"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView.builder(
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
    );
  }
}
