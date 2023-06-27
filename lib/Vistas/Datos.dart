import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ConsultarApi());
}

class ConsultarApi extends StatefulWidget {
  const ConsultarApi({Key? key}) : super(key: key);

  @override
  State<ConsultarApi> createState() => _ConsultarApiState();
}

class _ConsultarApiState extends State<ConsultarApi> {
  List<dynamic> Datos=[];
  Future<void>ConsultarDatos()async{
    final url = Uri.parse("http://192.168.0.107/ListarEquipos");
    final Respuesta = await http.get(url);
    if(Respuesta.statusCode==200){
      print("La Api se consulto correctamente");
      final jsonResponse =json.decode(Respuesta.body);
      setState(() {
        Datos=List.from(jsonResponse);
        print(Datos);
      });
    }else{
      print("Error: No se consulto la Api");
    }
  }
  @override
  void initState(){
    super.initState();
    ConsultarDatos();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Datos Equipos")),
        ),
        body: ListView.builder(
          itemCount: Datos.length,
          itemBuilder: (context, index) {
            final item = Datos[index];
            return ListTile(
              title: Text(item['Equ_id']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['Equi_tipo']),
                  Text(item['Equi_modelo']),
                  Text(item['Equi_color']),
                  Text(item['Equi_serial']),
                  Text(item['Equi_estado']),
                  Text(item['equi_especialidad']),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


