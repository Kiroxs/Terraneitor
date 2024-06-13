import 'package:flutter/material.dart';

class ComoControlar extends StatefulWidget {
  const ComoControlar({super.key});

  @override
  State<ComoControlar> createState() => _ComoControlarState();
}

class _ComoControlarState extends State<ComoControlar> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // Asegúrate de ajustar esto
      children: [
        Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
                "PASO 1: Verifica que el terraneitor se encuentra conectado correctamente, en caso contrario te recomendamos revisar el apartado de Conexión con terraneitor en el apartado de ayuda.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left),
          ),
        ),
        Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
                "PASO 2: Ve al apartado de control en el menú principal.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left),
          ),
        ),
        Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
                "PASO 3:  Dentro del circulo gris, arrastra el círculo violeta hacia la dirección que desees mover el terraneitor, mantenlo en esa posición en caso de querer realizar un movimiento continuo.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left),
          ),
        ),
        Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: TextStyle(
                    fontSize: 18,
                    ), // Define el color como parte del estilo base
                children: <InlineSpan>[
                  TextSpan(
                      text:
                          "PASO 4: Para detener el movimiento del terraneitor de manera controlada, pulsa el centro del círculo gris. "),
                  TextSpan(
                      text:
                          "Si deseas encender las luces altas del terraneitor, pulsa el ícono "),
                  WidgetSpan(
                    child: Icon(Icons.highlight,
                        size: 30), // Cambia el ícono como necesites
                  ),
                  TextSpan(
                      text:
                          ", si te las deseas apagar, pulsa el ícono nuevamente. Para ajustar el nivel de velocidad, desliza la barra situada sobre el texto 'Velocidad'."),
                  
                  
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
