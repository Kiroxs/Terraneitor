import 'dart:async';

import 'package:flutter/material.dart';

class LiveImage extends StatefulWidget {
  final String imageUrl;
  final Duration interval;

  LiveImage({required this.imageUrl, this.interval = const Duration(milliseconds: 100)});

  @override
  _LiveImageState createState() => _LiveImageState();
}

class _LiveImageState extends State<LiveImage> {
  Timer? _timer;
  late String _imageUrl;

  @override
  void initState() {
    super.initState();
    _imageUrl = widget.imageUrl;
    _timer = Timer.periodic(widget.interval, (Timer t) {
      setState(() {
        // Agregar un timestamp a la URL para prevenir la caché
        _imageUrl = "${widget.imageUrl}?dummy=${DateTime.now().millisecondsSinceEpoch}";
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      _imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Text('No se pudo cargar la imagen', style: TextStyle(color: Colors.red));
      },
      
    );
  }
}