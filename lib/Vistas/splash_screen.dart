import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'codigo_licencia_vista.dart';
import 'home_vista.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkStoredLicense();
  }

  Future<void> _checkStoredLicense() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedLicense = prefs.getString('license');
    await Future.delayed(Duration(seconds: 2));
    if (storedLicense != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeVista()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CodigoLicenciaVista()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Verificando licencia...", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
