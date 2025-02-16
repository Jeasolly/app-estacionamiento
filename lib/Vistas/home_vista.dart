import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import '../controladores/codigo_licencia_controlador.dart';
import 'servicios_vista.dart';
import 'inicio_sesion_vista.dart';
import '../Vistas/perfil/perfil_vista.dart';

class HomeVista extends StatefulWidget {
  @override
  _HomeVistaState createState() => _HomeVistaState();
}

class _HomeVistaState extends State<HomeVista> {
  final LicenciaController _controller = LicenciaController();
  int _indiceActual = 0;

  final List<Widget> _vistas = [
    PaginaHome(),
    ServiciosVista(),
    PerfilVista(), // Pantalla de perfil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _vistas[_indiceActual],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        currentIndex: _indiceActual,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: (indice) {
          setState(() {
            _indiceActual = indice;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.miscellaneous_services),
            label: 'Servicios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

// ---------------- PÁGINA HOME ----------------
class PaginaHome extends StatefulWidget {
  @override
  _PaginaHomeState createState() => _PaginaHomeState();
}

class _PaginaHomeState extends State<PaginaHome> {
  final double _saldo = 2.0;
  bool _ocultarSaldo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Para evitar tener 2 AppBars, se deja en blanco y se usa la parte superior decorada
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          // Encabezado con degradado
          _buildEncabezado(),
          // Sección de Saldo en tarjeta semitransparente
          _buildTarjetaSaldo(),
          // Grid de opciones
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                // Ajusta si quieres más o menos children
                children: [
                  BotonCircular(
                    titulo: 'Pagar Voucher',
                    imagen: 'assets/images/pagar_voucher.png',
                    onTap: () {
                      Navigator.pushNamed(context, '/pagar_voucher');
                    },
                  ),
                  BotonCircular(
                    titulo: 'Estacionamientos',
                    imagen: 'assets/images/estacionamientos.png',
                    onTap: () {
                      Navigator.pushNamed(context, '/mapa');
                    },
                  ),
                  BotonCircular(
                    titulo: 'EnLínea 1',
                    imagen: 'assets/images/enlinea1.png',
                    onTap: () {},
                  ),
                  BotonCircular(
                    titulo: 'Próximamente ...',
                    imagen: 'assets/images/proximamente.png',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Construye el encabezado con degradado y logo
  Widget _buildEncabezado() {
    return Container(
      width: double.infinity,
      height: 140,
      // Degradado azul oscuro a un tono más claro
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade900, Colors.blue.shade700],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: 80,
          ),
        ),
      ),
    );
  }

  /// Tarjeta sobre el saldo
  Widget _buildTarjetaSaldo() {
    final icono = _ocultarSaldo ? Icons.visibility_off : Icons.visibility;
    final textoBoton = _ocultarSaldo ? 'Mostrar Saldo' : 'Ocultar Saldo';

    return Container(
      // Ajuste de posición "sobre" el contenedor de arriba
      transform: Matrix4.translationValues(0, -20, 0),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.white.withOpacity(0.9),
          child: Row(
            children: [
              IconButton(
                icon: Icon(icono, color: Colors.blueGrey),
                onPressed: () {
                  setState(() {
                    _ocultarSaldo = !_ocultarSaldo;
                  });
                },
              ),
              SizedBox(width: 10),
              Text(
                textoBoton,
                style: TextStyle(color: Colors.blueGrey, fontSize: 16),
              ),
              Spacer(),
              Text(
                _ocultarSaldo ? 'S/ ****' : 'S/ ${_saldo.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.blueGrey, fontSize: 16),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- BOTÓN CIRCULAR ----------------
class BotonCircular extends StatelessWidget {
  final String titulo;
  final String imagen;
  final VoidCallback onTap;

  const BotonCircular({
    Key? key,
    required this.titulo,
    required this.imagen,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Para un look más "material" podemos envolver en un Card
          Material(
            elevation: 3,
            shape: CircleBorder(),
            child: Container(
              height: 100, // Ajusta según prefieras
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(imagen),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            titulo,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
