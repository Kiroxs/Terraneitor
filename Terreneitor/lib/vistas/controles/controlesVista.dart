import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  String _imageUrl = '';
  bool _isLoading = false;

  @override
  void sendCommand(String url) async {
    final response = await http
        .post(
          Uri.parse("${url}"),
        )
        .timeout(
          const Duration(seconds: 15),
        );

    if (response.statusCode == 200) {
      // La solicitud fue exitosa
      print('Solicitud enviada con éxito.');
    } else {
      // Hubo un error en la solicitud
      print('Error al enviar la solicitud.');
    }
  }

  void _fetchImage() async {
    setState(() {
      _isLoading = true;
    });

    String ipAddress =
        Provider.of<ConfigProvider>(context, listen: true).getIp();

    final url = 'http://${ipAddress}/camera';
    try {
      final response = await http.get(Uri.parse(url)).timeout(
            const Duration(seconds: 15),
          );

      if (response.statusCode == 200) {
        setState(() {
          _imageUrl = url;
        });
      } else {
        _showErrorDialog(
            'Failed to load image. Status code: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      _showErrorDialog('Failed to load image. Error: $e');
      setState(() {
        _isLoading = false;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  String getDirection(double x, double y) {
    double angle = atan2(y, x); // Ángulo en radianes
    String ipAddress =
        Provider.of<ConfigProvider>(context, listen: true).getIp();

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
              if (!Provider.of<ConfigProvider>(context, listen: true)
                  .getIp()
                  .isNotEmpty)
                Text(
                  'Necesitas introducir la IP',
                  style: TextStyle(fontSize: 30),
                ),
              if (Provider.of<ConfigProvider>(context, listen: true)
                  .getIp()
                  .isNotEmpty)
                Column(
                  children: [
                    _imageUrl.isNotEmpty ? Image.network(_imageUrl) : Text(''),
                    ElevatedButton(
                      onPressed: _fetchImage,
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text('Fetch Image'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            value: _currentSliderValue,
                            min: 0,
                            max: 9,
                            divisions: 9,
                            label: _currentSliderValue
                                .round()
                                .toString(), // Muestra valores redondeados.
                            onChanged: (double value) {
                              setState(() {
                                String ipAddress = Provider.of<ConfigProvider>(
                                        context,
                                        listen: true)
                                    .getIp();
                                _currentSliderValue = value
                                    .roundToDouble(); // Almacena valores como enteros redondeados.
                                sendCommand(
                                    "http://$ipAddress/?State=$_currentSliderValue");
                              });
                            },
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                          ),
                          onPressed: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              border: Border.all(
                                color: Color(0xff93479b),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.highlight,
                                size: 50,
                                color: Color(0xff93479b),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text('Velocidad : ${_currentSliderValue.round()}'),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Joystick(
                          base: Container(
                            width: 200,
                            height: 200,
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
            ],
          ),
        ),
      ),
    );
  }
}
