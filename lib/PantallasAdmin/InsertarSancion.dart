import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class InsertarSancion extends StatefulWidget {
  const InsertarSancion({Key? key}) : super(key: key);

  @override
  State<InsertarSancion> createState() => _InsertarSancionState();
}

class _InsertarSancionState extends State<InsertarSancion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _San_Pres_idController = TextEditingController();
  final TextEditingController _San_tiempoController = TextEditingController();
  final TextEditingController _San_DescripcionController =
  TextEditingController();

  void _enviarFormularioSanciones() async {
    if (_formKey.currentState!.validate()) {
      final String insertarSancionUrl = "http://192.168.1.44/insertarSancion/";

      final Map<String, dynamic> datos = {
        'San_Pres_id': _San_Pres_idController.text,
        'San_tiempo': _San_tiempoController.text,
        'San_Descripcion': _San_DescripcionController.text,
      };

      final jsonData = json.encode(datos);

      try {
        final response = await http.post(
          Uri.parse(insertarSancionUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonData,
        );

        if (response.statusCode == 200) {
          // Muestra mensaje de éxito
          Fluttertoast.showToast(
            msg: 'Sanción registrada exitosamente',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // Puedes agregar más lógica aquí si es necesario
        } else {
          // Muestra mensaje de error al enviar los datos
          Fluttertoast.showToast(
            msg: 'Error al enviar los datos',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } catch (error) {
        // Muestra mensaje de error general
        Fluttertoast.showToast(
          msg: 'Error: $error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Sanciones"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                label: 'ID del Préstamo',
                controller: _San_Pres_idController,
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Tiempo de Sanción',
                controller: _San_tiempoController,
                icon: Icons.timer,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Descripción de la Sanción',
                controller: _San_DescripcionController,
                icon: Icons.description,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _enviarFormularioSanciones,
                  child: const Text('Registrar Sanción'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple, // Color morado
                    onPrimary: Colors.white, // Text color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ingrese $label';
        }
        return null;
      },
    );
  }
}
