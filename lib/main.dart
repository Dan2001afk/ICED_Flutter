import 'package:flutter/material.dart';
import 'package:iced/Vistas/Splash.dart';

void main() {
  runApp(const IcedInventory());
}

class IcedInventory extends StatelessWidget {
  const IcedInventory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Splash(),
    );
  }
}
