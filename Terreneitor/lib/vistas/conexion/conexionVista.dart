import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:terreneitor/vistas/providers/config_provider.dart';

class conexionVista extends StatefulWidget {
  const conexionVista({super.key});

  @override
  State<conexionVista> createState() => _conexionVistaState();
}
  
class _conexionVistaState extends State<conexionVista> {
  TextEditingController ipController = TextEditingController();
  String ipAddress = '';
  bool request = false;
  void mostrarMensaje(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }
  void conectar() async {
    setState(() {
      request = true;
    });
    String url = 'http://$ipAddress/';
    try {
      final response = await http.post(Uri.parse(url)).timeout(
            const Duration(seconds: 15),
          );
      print(response.body);
      Provider.of<ConfigProvider>(context, listen: false).setIp(ipAddress);
      if (response.statusCode == 200) {
        // La solicitud fue exitosa
        
        mostrarMensaje(context, "Conexion exitosa");
        print('Solicitud enviada con éxito.');
      } else {
        // Hubo un error en la solicitud
        mostrarMensaje(context, "Error al enviar la solicitud.");
        
      }
    } catch (e) {
       mostrarMensaje(context, "${e.toString()}");
      print(e);
    }
    setState(() {
      request = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              SizedBox(height: 26),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: ipController,
                  onChanged: (value) {
                    ipAddress = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xff93479b),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'IP',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  conectar();
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    border: Border.all(
                      color: Color(0xff93479b),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      size: 50,
                      color: Color(0xff93479b),
                    ),
                  ),
                ),
              ),

             
              SizedBox(height: 26),
              Text(
                "CONECTAR",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 26),
              if (request == true) Text("CONECTANDO...", style: TextStyle(color: Colors.white, fontSize: 18),),

            ],
          ),
        ),
      ),
    );
  }
}
