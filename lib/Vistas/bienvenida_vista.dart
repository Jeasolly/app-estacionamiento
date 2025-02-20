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

  late AnimationController _animacionController;
  late Animation<double> _fadeIn;
  late AnimationController _parpadeoController;
  late Animation<double> _parpadeoAnim;
  late AnimationController _fadeOutController;
  late Animation<double> _fadeOutAnim;

  @override
  void initState() {
    super.initState();

    _animacionController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _animacionController, curve: Curves.easeIn);

    _parpadeoController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _parpadeoAnim = Tween(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _parpadeoController,
        curve: Curves.easeInOut,
      ),
    );

    _fadeOutController = AnimationController(
      duration: Duration(milliseconds: 600), // Duración de fade-out
      vsync: this,
    );

    _fadeOutAnim = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _fadeOutController,
      curve: Curves.easeOut,
    ));

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
      _mostrarAnimacionCarga = false;
    });

    await Future.delayed(Duration(milliseconds: 500));

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

  void _onTapParaComenzar() async {
    _fadeOutController.forward(); // Inicia el efecto de desvanecimiento

    await Future.delayed(Duration(milliseconds: 600)); // Espera a que termine el fade-out

    String? licenciaGuardada = await _obtenerLicenciaDesdeDB();
    Widget siguienteVista = (licenciaGuardada != null && licenciaGuardada.isNotEmpty)
        ? InicioSesionVista()
        : CodigoLicenciaVista();

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
          opacity: animation,
          child: siguienteVista,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animacionController.dispose();
    _parpadeoController.dispose();
    _fadeOutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeOutAnim,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bienvenido2.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

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
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [Shadow(blurRadius: 5, color: Colors.black, offset: Offset(2, 2))],
                      ),
                    ),
                  ),
                ),
              ),
            ),

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
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [Shadow(blurRadius: 6, color: Colors.black, offset: Offset(2, 2))],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Parking System v1.0.2",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [Shadow(blurRadius: 6, color: Colors.black, offset: Offset(2, 2))],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [Shadow(blurRadius: 4, color: Colors.black, offset: Offset(2, 2))],
                      ),
                    ),
                  ],
                ),
              ),

            if (_pantallaLista && _mostrarTextoInicio)
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: FadeTransition(
                    opacity: _parpadeoAnim,
                    child: GestureDetector(
                      onTap: _onTapParaComenzar,
                      child: Text(
                        'Toca para comenzar >',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [Shadow(blurRadius: 4, color: Colors.black, offset: Offset(2, 2))],
                        ),
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
