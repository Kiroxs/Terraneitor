import 'package:flutter/material.dart';
import 'package:terreneitor/vistas/ayuda/ayudaprincipal.dart';
import 'package:terreneitor/vistas/conexion/conexionVista.dart';
import 'package:terreneitor/vistas/controles/controlesVista.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int currentPageIndex = 2;
  
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
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
          ayudaPrincipal()
        ][currentPageIndex],
      ),
    );
  }
}