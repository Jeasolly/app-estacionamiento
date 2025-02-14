import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'inicio_sesion_vista.dart';
import 'codigo_licencia_vista.dart';

class BienvenidaVista extends StatefulWidget {
  @override
  _BienvenidaVistaState createState() => _BienvenidaVistaState();
}

class _BienvenidaVistaState extends State<BienvenidaVista> with SingleTickerProviderStateMixin {
  String _estadoCarga = "";
  bool _mostrarTextoInicio = false;
  bool _mostrarAnimacionCarga = false;
  bool _pantallaLista = false;
  late AnimationController _animacionController;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _animacionController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _animacionController, curve: Curves.easeIn);

    _esperarRenderPantalla();
  }

  /// Espera a que la pantalla se haya renderizado antes de iniciar la animación de carga
  Future<void> _esperarRenderPantalla() async {
    await Future.delayed(Duration(milliseconds: 10500)); // Espera a que cargue la pantalla
    setState(() {
      _pantallaLista = true;
    });

    _iniciarCarga();
  }

  /// Maneja la animación de carga y la verificación de licencia
  Future<void> _iniciarCarga() async {
    setState(() {
      _mostrarAnimacionCarga = true;
      _estadoCarga = "Cargando recursos...";
    });

    await Future.delayed(Duration(milliseconds: 2500));
    setState(() {
      _estadoCarga = "Conectando con el servidor...";
    });

    await Future.delayed(Duration(milliseconds: 2500));
    setState(() {
      _estadoCarga = "Verificando licencia...";
    });

    String? licenciaGuardada = await _obtenerLicenciaDesdeDB();
    print("Licencia encontrada en SQLite: $licenciaGuardada");

    await Future.delayed(Duration(milliseconds: 2500));

    setState(() {
      _mostrarAnimacionCarga = false; // Ocultar la animación de carga
    });

    await Future.delayed(Duration(milliseconds: 500)); // Pequeño delay antes de mostrar "Toca para comenzar"

    setState(() {
      _mostrarTextoInicio = true;
      _animacionController.forward();
    });
  }

  /// Obtiene la base de datos SQLite
  Future<Database> _obtenerDB() async {
    return openDatabase(
      p.join(await getDatabasesPath(), 'licencia.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE licencia(id INTEGER PRIMARY KEY, codigo TEXT)");
      },
      version: 1,
    );
  }

  /// Obtiene la licencia guardada en SQLite
  Future<String?> _obtenerLicenciaDesdeDB() async {
    final Database db = await _obtenerDB();
    final List<Map<String, dynamic>> maps = await db.query('licencia');

    print("Datos encontrados en SQLite: $maps");

    if (maps.isNotEmpty) {
      return maps.first['codigo'];
    }
    return null;
  }

  @override
  void dispose() {
    _animacionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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

          // Título "Bienvenido"
          Positioned(
            top: 40,
            left: 20,
            child: Text(
              'Bienvenido',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // Logo "Park Access" con subtítulo
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeTransition(
                  opacity: _fadeIn,
                  child: Column(
                    children: [
                      Text(
                        "PARK ACCESS",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Parking System v1.0.2",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Solo muestra la animación si la pantalla ya se ha renderizado completamente
          if (_pantallaLista && _mostrarAnimacionCarga)
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text(
                    _estadoCarga,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

          // Botón "Toca para comenzar" solo aparece después de la animación
          if (_pantallaLista && _mostrarTextoInicio)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: FadeTransition(
                  opacity: _fadeIn,
                  child: GestureDetector(
                    onTap: () async {
                      String? licenciaGuardada = await _obtenerLicenciaDesdeDB();
                      if (licenciaGuardada != null && licenciaGuardada.isNotEmpty) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => InicioSesionVista()),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => CodigoLicenciaVista()),
                        );
                      }
                    },
                    child: Text(
                      'Toca para comenzar >',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
