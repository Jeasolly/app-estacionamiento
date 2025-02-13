import 'package:flutter/material.dart';
import 'dart:async';

class BienvenidaVista extends StatefulWidget {
  @override
  _BienvenidaVistaState createState() => _BienvenidaVistaState();
}

class _BienvenidaVistaState extends State<BienvenidaVista> {
  bool _mostrarTexto = true;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _mostrarTexto = !_mostrarTexto;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/codigo_licencia');
        },
        child: Stack(
          children: [
            // Fondo con imagen
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/fondo_bienvenida.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Texto superior "Bienvenido"
            Positioned(
              top: 40,
              left: 20,
              child: Text(
                'Bienvenido',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // Texto inferior "Toca para comenzar" con efecto de parpadeo
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedOpacity(
                  opacity: _mostrarTexto ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'Toca para comenzar >',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

