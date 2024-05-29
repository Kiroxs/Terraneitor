import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:terreneitor/vistas/providers/config_provider.dart';

class controlesVista extends StatefulWidget {
  const controlesVista({super.key});

  @override
  State<controlesVista> createState() => _controlesVistaState();
}

class _controlesVistaState extends State<controlesVista> {
  double _currentSliderValue = 5;
  void sendCommand(String url) async {
    final response = await http.post(
      Uri.parse("${url}"),
    );
    if (response.statusCode == 200) {
      // La solicitud fue exitosa
      print('Solicitud enviada con éxito.');
    } else {
      // Hubo un error en la solicitud
      print('Error al enviar la solicitud.');
    }
  }

  String getDirection(double x, double y) {
    String ipAddress =
        Provider.of<ConfigProvider>(context, listen: false).getIp();
    double angle = atan2(y, x); // Ángulo en radianes

    // Verificar si el joystick está cerca del centro
    if (x.abs() < 0.1 && y.abs() < 0.1) {
      return "http://$ipAddress/?State=S";
    }

    // Determinar la dirección basada en el ángulo
    if (angle > -pi / 8 && angle < pi / 8) {
      return "http://$ipAddress/?State=R";
    } else if (angle >= pi / 8 && angle <= 3 * pi / 8) {
      return "http://$ipAddress/?State=J";
    } else if (angle > 3 * pi / 8 && angle < 5 * pi / 8) {
      return "http://$ipAddress/?State=B";
    } else if (angle >= 5 * pi / 8 && angle <= 7 * pi / 8) {
      return "http://$ipAddress/?State=H";
    } else if ((angle > 7 * pi / 8 && angle <= pi) ||
        (angle < -7 * pi / 8 && angle >= -pi)) {
      return "http://$ipAddress/?State=L";
    } else if (angle < -5 * pi / 8 && angle > -7 * pi / 8) {
      return "http://$ipAddress/?State=G";
    } else if (angle <= -3 * pi / 8 && angle >= -5 * pi / 8) {
      return "http://$ipAddress/?State=F";
    } else if (angle > -3 * pi / 8 && angle < -pi / 8) {
      return "http://$ipAddress/?State=I";
    }
    return "http://$ipAddress/?State=S"; // Por defecto si no cae en ningún rango específico
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Slider(
                value: _currentSliderValue,
                min: 0,
                max: 9,
                divisions:
                    9, 
                label: _currentSliderValue
                    .round()
                    .toString(), // Muestra valores redondeados.
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value
                        .roundToDouble(); // Almacena valores como enteros redondeados.
                  });
                },
              ),
              Text('Velocidad : ${_currentSliderValue.round()}'),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Joystick(
                    base: Container(
                      width: 250,
                      height: 250,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    mode: JoystickMode.all,
                    listener: (details) {
                      setState(() {
                        sendCommand(getDirection(details.x, details.y));
                      });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
