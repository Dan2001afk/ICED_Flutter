import 'package:flutter/material.dart';

class figura_principal extends StatelessWidget {
  const figura_principal({Key? key}) : super(key: key);


  //icono y estilos del icono menu
  Widget _icono(){
    return Container(
      decoration: BoxDecoration(
        //border:  Border.all(color: Colors.white, width: 2),
          shape: BoxShape.circle),
      child: const Icon(Icons.person,
          color: Colors.black,size: 200),
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
              color: Color.fromRGBO(171, 151, 215, 1.0), // Color rgb
              shape: BoxShape.circle,
            ),
            child: _icono(),
          ),
        ),
      ],
    );
  }
}