import 'package:flutter/material.dart';

class FiguraPrincipal extends StatelessWidget {
  const FiguraPrincipal({Key? key}) : super(key: key);

  // Método para cargar la imagen desde la carpeta de assets
  Widget _imagenLogo() {
    return Image.asset(
      'imagenes/iced_logo.png', // Asegúrate de que la ruta sea correcta
      width: 190,
      height: 190,
      fit: BoxFit.contain, // Puedes ajustar esto según tus necesidades
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 200,
            height: 200,
            margin: EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
              color: Color.fromRGBO(250, 248, 248, 1.0), // Color rgb
              shape: BoxShape.circle,
            ),
            child: _imagenLogo(),
          ),
        ),
      ],
    );
  }
}
