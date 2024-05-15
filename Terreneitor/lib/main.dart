import 'package:flutter/material.dart';
import 'package:terreneitor/vistas/conexion/conexionVista.dart';
import 'package:terreneitor/vistas/controles/controlesVista.dart';


/// Flutter code sample for [NavigationBar].

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.dark()),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.white,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.signal_wifi_4_bar_sharp),
            label: 'Conexión',
            selectedIcon: IconButton(onPressed: null, icon: Icon(Icons.signal_wifi_4_bar_sharp,size:35, color: Color(0xff93479b))),
          ),
          NavigationDestination(
            icon: Icon(Icons.games),
            label: 'Control',
            selectedIcon: IconButton(onPressed: null, icon: Icon(Icons.games,size:35, color: Color(0xff93479b))),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.info,
            ),
            selectedIcon: IconButton(onPressed: null, icon: Icon(Icons.info,size:35, color: Color(0xff93479b))),
            label: 'Ayuda',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        conexionVista(),
        controlesVista(),
        

        /// Notifications page

        /// Messages page
        Center(child: Text('AYUDA', style: theme.textTheme.headlineLarge)),
      ][currentPageIndex],
    );
  }
}
