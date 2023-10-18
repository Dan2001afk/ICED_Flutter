import 'package:flutter/material.dart';

class AcercaDeNosotros extends StatelessWidget {
  const AcercaDeNosotros({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desarrolladores de ICED '),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          _buildParticipantCard(
            name: 'Nicolas Garzon',
            description:
            'Rol: Encargado del desarrollo en la parte móvil y del Frontend de la página web.  Desarrollo de la aplicación móvil y sus funcionalidades, asegurando una experiencia de usuario coherente en la aplicación móvil. Integración de características específicas del dispositivo móvil y participación en la recopilación de información para el proyecto. Además, colaboro en la adaptación del Backend para la Aplicación Móvil de ICED.',
            imageUrl: 'imagenes/nicolas.jpeg',
          ),
          _buildParticipantCard(
            name: 'Camilo Cubides',
            description:
            'Rol: Responsable de tanto el desarrollo del Backend como del Frontend. Contribuciones: participación activa en el diseño y desarrollo de la arquitectura del sistema implementación de funcionalidades tanto en el lado del servidor como en el lado del cliente coordinación entre los equipos de Backend y Frontend para garantizar la coherencia del sistema, contribuciones de diseño en el área de la Aplicación móvil.',
            imageUrl: 'imagenes/camilo.jpeg',
          ),
          _buildParticipantCard(
            name: 'Justin Daniel',
            description:
            'Rol: Encargado del desarrollo del Frontend del software contribuciones: creación de la interfaz de usuario y experiencia de usuario implementación de las funcionalidades del cliente en la interfaz de usuario colaboración con el equipo de diseño para asegurar una interfaz atractiva y fácil de usar participación en la recolección de información para el proyecto, coordinación entre los equipos de Backend y Frontend para garantizar la coherencia del sistema, contribuciones de diseño en el área de la Aplicación móvil.',
            imageUrl: 'imagenes/Justin.jpeg',
          ),
          _buildParticipantCard(
            name: 'Daniel Gonzalez',
            description:
            'Rol: Encargado del desarrollo del Backend del software. Contribuciones: Diseño e implementación de la arquitectura del servidor Desarrollo de la lógica del servidor para gestionar la lógica empresarial y los datos, Integración de servicios y API necesarios para el funcionamiento del sistema, coordinación entre los equipos de Backend y Frontend para garantizar la coherencia del sistema, contribuciones del Backend en el área de la Aplicación móvil.',
            imageUrl: 'imagenes/Daniel.jpeg',
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantCard({required String name, required String description, required String imageUrl}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      elevation: 8.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 10 / 9, // Puedes ajustar esta relación de aspecto según tus necesidades
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              child: Image.asset(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AcercaDeNosotros(),
  ));
}
