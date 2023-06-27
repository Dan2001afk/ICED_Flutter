import 'package:flutter/material.dart';

import 'Vistas/Insertar.dart';

void main() {
  runApp(const IcedInventory());
}

class IcedInventory extends StatelessWidget {
  const IcedInventory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home:InsertarEquipo(),
    );
  }
}
