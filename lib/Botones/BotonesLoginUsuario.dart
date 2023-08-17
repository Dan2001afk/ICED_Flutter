 import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iced/PantallasUsuario/InformacionUsuario.dart';

import '../Vistas/Principal.dart';
class BotonesLoginUsuario extends StatefulWidget {
  const BotonesLoginUsuario({Key? key}) : super(key: key);

  @override
  State<BotonesLoginUsuario> createState() => _BotonesLoginUsuarioState();
}

class _BotonesLoginUsuarioState extends State<BotonesLoginUsuario> {
  final Usuario = TextEditingController();
  final clave = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: loginUsuario(),
        ),
        Container(
          child: loginclave(),
        ),
        Container(
          child: Enviar_Datos(),
        )
      ],
    );
  }
  Container loginUsuario() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 100, right: 20, left: 20, bottom: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: TextFormField(
        style: TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          hintText: '',
          hintStyle: TextStyle(fontSize: 20, color: Colors.black),
          labelText: 'Correo',
          labelStyle: TextStyle(fontSize: 20, color: Colors.black),
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        controller: Usuario,
      ),
    );
  }

  Container loginclave() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: TextFormField(
        style: TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          hintText: '',
          hintStyle: TextStyle(fontSize: 20, color: Colors.black),
          labelText: 'Contraseña',
          labelStyle: TextStyle(fontSize: 20, color: Colors.black),
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        controller: clave,
      ),
    );
  }

  Container Enviar_Datos() {
    return Container(
      margin: EdgeInsets.only(top: 20,left: 20,right: 20),
      width: 400,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {
          String usu = "usuario";
          String clave1 = "0000";

          if (Usuario.text.isEmpty || clave.text.isEmpty) {
            Fluttertoast.showToast(
              msg: "Por favor complete todos los campos",
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
            );
          } else if (Usuario.text.length < 4 || clave.text.length < 4) {
            Fluttertoast.showToast(
              msg: "Correo o contraseña demasiado cortos",
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
            );
          } else if (Usuario.text == usu && clave.text == clave1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InicioUsuario()),
            );
          } else {
            Fluttertoast.showToast(
              msg: "Datos incorrectos",
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
            );
          }
        },
        icon: Icon(Icons.person,color: Color.fromRGBO(255, 255, 255, 1.0),),
        label: Text("Iniciar Sesion Usuario ",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 15
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromRGBO(88, 8, 100, 1.0), //Color
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }

}
