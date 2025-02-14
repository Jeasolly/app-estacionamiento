import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'inicio_sesion_vista.dart';

class CodigoLicenciaVista extends StatefulWidget {
  @override
  _CodigoLicenciaVistaState createState() => _CodigoLicenciaVistaState();
}

class _CodigoLicenciaVistaState extends State<CodigoLicenciaVista> {
  final TextEditingController _codigoController = TextEditingController();
  String _message = "";
  bool _isLoading = false;
  final String _apiUrl = 'https://gamarracode.parkinventario.com/token.php';

  @override
  void initState() {
    super.initState();
    _verificarLicenciaGuardada();
  }

  Future<Database> _obtenerDB() async {
    return openDatabase(
      p.join(await getDatabasesPath(), 'licencia.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS licencia (id INTEGER PRIMARY KEY, codigo TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> _guardarLicenciaEnDB(String licencia) async {
    final Database db = await _obtenerDB();
    await db.insert(
      'licencia',
      {'id': 1, 'codigo': licencia},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> _obtenerLicenciaDesdeDB() async {
    final Database db = await _obtenerDB();
    final List<Map<String, dynamic>> maps = await db.query('licencia');
    if (maps.isNotEmpty) {
      return maps.first['codigo'];
    }
    return null;
  }

  Future<void> _verificarLicenciaGuardada() async {
    String? licenciaGuardada = await _obtenerLicenciaDesdeDB();
    print("Licencia guardada en SQLite: $licenciaGuardada");

    if (licenciaGuardada != null && licenciaGuardada.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InicioSesionVista()),
      );
    }
  }

  Future<void> _saveAndValidateLicense() async {
    setState(() {
      _isLoading = true;
      _message = "";
    });

    try {
      String deviceId = await _getDeviceId();

      if (deviceId.isEmpty || _codigoController.text.isEmpty) {
        setState(() {
          _isLoading = false;
          _message = "Error: Device ID o licencia vacíos";
        });
        return;
      }

      Map<String, dynamic> body = {
        'validar': true,
        'licencia': _codigoController.text,
        'device_id': deviceId,
      };

      print("Enviando solicitud a la API: ");
      print(jsonEncode(body));

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final responseData = jsonDecode(response.body);
      print("Respuesta del servidor: $responseData");

      setState(() {
        _isLoading = false;
      });

      if (responseData['status'] == 'success') {
        await _guardarLicenciaEnDB(_codigoController.text);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => InicioSesionVista()),
        );
      } else {
        setState(() {
          _message = "Error del servidor: ${responseData['message']}";
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _message = "Error en la validación: ${e.toString()}";
      });
      print("Error en la validación: ${e.toString()}");
    }
  }

  Future<String> _getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 80,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Text(
                'Hola',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Ingresa el código de licencia',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _codigoController,
                decoration: InputDecoration(
                  labelText: 'Licencia',
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _saveAndValidateLicense,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Ingresar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Text(
                _message,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
