import 'package:flutter/material.dart';

class CodigoLicenciaVista extends StatefulWidget {
  @override
  _CodigoLicenciaVistaState createState() => _CodigoLicenciaVistaState();
}

class _CodigoLicenciaVistaState extends State<CodigoLicenciaVista> {
  final TextEditingController _codigoController = TextEditingController();
  bool _mostrarCodigo = false;

  void _verificarCodigo() {
    if (_codigoController.text.isNotEmpty) {
      Navigator.pushNamed(context, '/inicio_sesion');
    }
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
                obscureText: !_mostrarCodigo,
                decoration: InputDecoration(
                  labelText: 'Licencia',
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _mostrarCodigo ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      setState(() {
                        _mostrarCodigo = !_mostrarCodigo;
                      });
                    },
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _verificarCodigo,
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
              SizedBox(height: 15),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Si no cuentas con una licencia adquiérela aquí',
                  style: TextStyle(color: Colors.greenAccent, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
