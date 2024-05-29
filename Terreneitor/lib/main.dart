import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terreneitor/vistas/conexion/conexionVista.dart';
import 'package:terreneitor/vistas/controles/controlesVista.dart';
import 'package:terreneitor/vistas/login.dart';
import 'package:terreneitor/vistas/providers/config_provider.dart';


/// Flutter code sample for [NavigationBar].

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ConfigProvider()),
    ], child: const App()),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.dark()),
      home: const AppMain(),
    );
  }
}

class AppMain extends StatefulWidget {
  const AppMain({super.key});

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  

  @override
  Widget build(BuildContext context) {
    
    return Login();
  }
}
