import 'package:flutter/material.dart';
import 'package:iced/Vistas/Inicio.dart';
import 'package:iced/PantallasAdmin/LoginAdmin.dart';
import 'package:lottie/lottie.dart';
import 'package:iced/Vistas/PrincipalAdmin.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Inicio()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 200,
              child: Lottie.asset("imagenes/datos.json"),
            ),
            SizedBox(height: 20),
            Text(
              "ICED-SENA",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
