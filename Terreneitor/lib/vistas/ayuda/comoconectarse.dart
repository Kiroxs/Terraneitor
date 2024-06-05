import 'package:flutter/material.dart';
class ComoConectar extends StatefulWidget {
  const ComoConectar({super.key});

  @override
  State<ComoConectar> createState() => _ComoConectarState();
}

class _ComoConectarState extends State<ComoConectar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,  // Asegúrate de ajustar esto
      children: [
        Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("PASO 1: Encender el terraneitor.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left),
          ),
        ),
        
        Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("PASO 2: Buscar la red con nombre : terreneitor y contraseña: 12345678.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left),
          ),
        ),
        Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
                "PASO 3:  Ir al apartado de conexión y pulsar el botón conectar.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left),
          ),
        ),
        Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
                "PASO 4:  Esperar el mensaje del estado de la conexión, en caso de encontrar algún error, repita los pasos anteriores.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left),
          ),
        ),
      ],
    );
  }
}
