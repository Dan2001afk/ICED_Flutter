import 'package:flutter/material.dart';

class figura_principal_usuario extends StatelessWidget {
  const figura_principal_usuario({Key? key}) : super(key: key);


  //icono y estilos del icono menu
  Widget _icono_Usuario(){
    return Container(
      decoration: BoxDecoration(
        //border:  Border.all(color: Colors.white, width: 2),
          shape: BoxShape.circle),
      child: const Icon(Icons.account_circle,
          color: Colors.deepPurple,size: 200),
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
            child: _icono_Usuario(),
          ),
        ),
      ],
    );
  }
}