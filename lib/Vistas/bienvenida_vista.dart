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

class _BienvenidaVistaState extends State<BienvenidaVista> with TickerProviderStateMixin {
  String _estadoCarga = "";
  bool _mostrarTextoInicio = false;
  bool _mostrarAnimacionCarga = false;
  bool _pantallaLista = false;

  // Controla el fade inicial para el logo
  late AnimationController _animacionController;
  late Animation<double> _fadeIn;

  // Controla el parpadeo del texto "Toca para comenzar"
  late AnimationController _parpadeoController;
  late Animation<double> _parpadeoAnim;

  @override
  void initState() {
    super.initState();

    // Fade para el logo
    _animacionController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _animacionController, curve: Curves.easeIn);

    // Parpadeo para el texto "Toca para comenzar"
    _parpadeoController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); // Oscila entre 0.3 y 1.0

    _parpadeoAnim = Tween(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _parpadeoController,
        curve: Curves.easeInOut,
      ),
    );

    _esperarRenderPantalla();
  }

  Future<void> _esperarRenderPantalla() async {
    await Future.delayed(Duration(milliseconds: 2000));
    setState(() {
      _pantallaLista = true;
    });
    _iniciarCarga();
  }

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
      _mostrarAnimacionCarga = false; // Ocultar animación de carga
    });

    await Future.delayed(Duration(milliseconds: 500));

    // Muestra "Toca para comenzar" y arranca fade en logo
    setState(() {
      _mostrarTextoInicio = true;
      _animacionController.forward();
    });
  }

  Future<Database> _obtenerDB() async {
    return openDatabase(
      p.join(await getDatabasesPath(), 'licencia.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE licencia(id INTEGER PRIMARY KEY, codigo TEXT)");
      },
      version: 1,
    );
  }

  Future<String?> _obtenerLicenciaDesdeDB() async {
    final db = await _obtenerDB();
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
    _parpadeoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo con imagen fullscreen
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fondo_bienvenida.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Encabezado degradado (opcional semitransparente)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade900.withOpacity(0.8),
                    Colors.transparent
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black45,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Logo y subtítulo (Fade in)
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
                          shadows: [
                            Shadow(
                              blurRadius: 5,
                              color: Colors.black26,
                              offset: Offset(0, 2),
                            ),
                          ],
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

          // Animación de carga
          if (_pantallaLista && _mostrarAnimacionCarga)
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    _estadoCarga,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 3,
                          color: Colors.black26,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Texto "Toca para comenzar" con parpadeo
          if (_pantallaLista && _mostrarTextoInicio)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: FadeTransition(
                  opacity: _parpadeoAnim, // Animación de parpadeo
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
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Toca para comenzar >',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 3,
                              color: Colors.black26,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
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
