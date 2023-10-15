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
  TextEditingController usuarioIdController = TextEditingController();
  TextEditingController nuevoNombreController = TextEditingController();
  TextEditingController nuevoApellidoController = TextEditingController();
  TextEditingController nuevoTipoController = TextEditingController();
  TextEditingController nuevoCelularController = TextEditingController();
  TextEditingController nuevoCorreoController = TextEditingController();
  TextEditingController nuevaFichaController = TextEditingController();

  Future<void> ConsultarDatos() async {
    final url = Uri.parse("http://192.168.1.44/ListarUsuarios");
    final Respuesta = await http.get(url);
    if (Respuesta.statusCode == 200) {
      final jsonResponse = json.decode(Respuesta.body);
      setState(() {
        DatosUsuario = List.from(jsonResponse);
      });
    } else {
      print("Error en la solicitud: ${Respuesta.statusCode}");
      print("Cuerpo de la respuesta: ${Respuesta.body}");
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
      print("Error en la solicitud: ${Respuesta.statusCode}");
      print("Cuerpo de la respuesta: ${Respuesta.body}");
      print("Error: No se encontró el Usuario");
    }
  }

  Future<void> EliminarUsuario(int usuarioId) async {
    final url = Uri.parse("http://192.168.1.44/EliminarUsuario/$usuarioId");
    final Respuesta = await http.delete(url);
    if (Respuesta.statusCode == 200) {
      final jsonResponse = json.decode(Respuesta.body);
      print(jsonResponse['Mensaje']);
      ConsultarDatos();
    } else {
      print("Error en la solicitud: ${Respuesta.statusCode}");
      print("Cuerpo de la respuesta: ${Respuesta.body}");
      print("Error: No se pudo eliminar el Usuario");
    }
  }

  Future<void> ActualizarUsuario(
      int usuarioId,
      String nuevoNombre,
      String nuevoApellido,
      String nuevoTipo,
      String nuevoCelular,
      String nuevoCorreo,
      String nuevaFicha,
      ) async {
    final url = Uri.parse("http://192.168.1.44/ActualizarUsuario/$usuarioId");

    // Verifica si usuarioId no es nulo antes de incluirlo en el cuerpo de la solicitud
    final requestBody = {
      "Usu_Nombre": nuevoNombre,
      "Usu_Apellido": nuevoApellido,
      "Usu_tipo": nuevoTipo,
      "Usu_Celular": nuevoCelular,
      "Usu_Correo": nuevoCorreo,
      "Usu_Ficha": nuevaFicha,
    };

    if (usuarioId != null) {
      requestBody["Usu_Documento"] = usuarioId.toString();
    }

    final Respuesta = await http.post(
      url,
      body: jsonEncode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (Respuesta.statusCode == 200) {
      final jsonResponse = json.decode(Respuesta.body);
      print(jsonResponse['Mensaje']);
      ConsultarDatos(); // Actualizar la lista de usuarios después de la actualización
    } else {
      print("Error en la solicitud: ${Respuesta.statusCode}");
      print("Cuerpo de la respuesta: ${Respuesta.body}");
      print("Error: No se pudo actualizar el usuario");
    }
  }

  Future<void> cargarDatosUsuario(int index) async {
    if (DatosUsuario.isNotEmpty && index < DatosUsuario.length) {
      final item = DatosUsuario[index];
      if (item['Usu_Documento'] != null) {
        usuarioIdController.text = item['Usu_Documento'].toString();
        nuevoNombreController.text = item['Usu_Nombre'] ?? '';
        nuevoApellidoController.text = item['Usu_Apellido'] ?? '';
        nuevoTipoController.text = item['Usu_tipo'] ?? '';
        nuevoCelularController.text = item['Usu_Celular'] ?? '';
        nuevoCorreoController.text = item['Usu_Correo'] ?? '';
        nuevaFichaController.text = item['Usu_Ficha'] ?? '';
      } else {
        print("Error: El campo 'Usu_Documento' es nulo");
      }
    } else {
      print("Error: DatosUsuario está vacía o el índice es inválido");
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
          backgroundColor: Colors.purple, // Color púrpura para el encabezado
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
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple, // Color púrpura para el botón
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.search),
                    SizedBox(width: 8),
                    Text('Buscar Usuario'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final usuarioId = int.tryParse(usuarioIdController.text);
                      if (usuarioId != null) {
                        // Mostrar el diálogo de confirmación
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Eliminar'),
                              content: Text('¿ESTÁS SEGURO DE ELIMINAR EL USUARIO?'),
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
                                    EliminarUsuario(usuarioId);
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
                      primary: Colors.purple, // Color púrpura para el botón
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.delete),
                        SizedBox(width: 8),
                        Text('Eliminar '),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final usuarioId = int.tryParse(usuarioIdController.text);
                      if (usuarioId != null) {
                        cargarDatosUsuario(0);
                        // Mostrar el diálogo de actualización
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Actualizar Usuario'),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: usuarioIdController,
                                      decoration: InputDecoration(labelText: 'Nuevo ID'),
                                    ),
                                    TextField(
                                      controller: nuevoNombreController,
                                      decoration: InputDecoration(labelText: 'Nuevo Nombre'),
                                    ),
                                    TextField(
                                      controller: nuevoApellidoController,
                                      decoration: InputDecoration(labelText: 'Nuevo Apellido'),
                                    ),
                                    TextField(
                                      controller: nuevoTipoController,
                                      decoration: InputDecoration(labelText: 'Nuevo Tipo'),
                                    ),
                                    TextField(
                                      controller: nuevoCelularController,
                                      decoration: InputDecoration(labelText: 'Nuevo Celular'),
                                    ),
                                    TextField(
                                      controller: nuevoCorreoController,
                                      decoration: InputDecoration(labelText: 'Nuevo Correo'),
                                    ),
                                    TextField(
                                      controller: nuevaFichaController,
                                      decoration: InputDecoration(labelText: 'Nueva Ficha'),
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
                                    await ActualizarUsuario(
                                      usuarioId,
                                      nuevoNombreController.text,
                                      nuevoApellidoController.text,
                                      nuevoTipoController.text,
                                      nuevoCelularController.text,
                                      nuevoCorreoController.text,
                                      nuevaFichaController.text,
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
                      primary: Colors.purple, // Color púrpura para el botón
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text('Actualizar Usuario'),
                      ],
                    ),
                  ),
                ],
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

