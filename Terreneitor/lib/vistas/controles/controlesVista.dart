import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class controlesVista extends StatefulWidget {
  const controlesVista({super.key});

  @override
  State<controlesVista> createState() => _controlesVistaState();
}

class _controlesVistaState extends State<controlesVista> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                    mode: JoystickMode.horizontalAndVertical,
                    listener: (details) {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
