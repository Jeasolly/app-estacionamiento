import 'package:flutter/material.dart';

class RecuperarContrasenaVista extends StatefulWidget {
  @override
  _RecuperarContrasenaVistaState createState() => _RecuperarContrasenaVistaState();
}

class _RecuperarContrasenaVistaState extends State<RecuperarContrasenaVista> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nuevaPassController = TextEditingController();
  bool _mostrarPassword = false;
  bool _aceptoTerminos = false;

  void _recuperar() {
    // Por ahora solo navegamos a /inicio_sesion u otra ruta
    Navigator.pushNamed(context, '/inicio_sesion');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Fondo con degradado (azul oscuro a azul medio)
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
              // Logo en la parte superior
              Image.asset(
                'assets/images/logo.png', // Ajusta la ruta según tu proyecto
                height: 80,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              // Título principal
              Text(
                'Recuperar contraseña',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Ingresa tu correo electrónico \ny tu nueva contraseña',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 30),
              // Campo de texto para el email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.email, color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 15),
              // Campo de texto para la nueva contraseña
              TextField(
                controller: _nuevaPassController,
                obscureText: !_mostrarPassword,
                decoration: InputDecoration(
                  labelText: 'Nueva contraseña',
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.white70),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _mostrarPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      setState(() {
                        _mostrarPassword = !_mostrarPassword;
                      });
                    },
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              // Checkbox de términos (opcional, si tu diseño lo requiere)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: Colors.green,
                    value: _aceptoTerminos,
                    onChanged: (valor) {
                      setState(() {
                        _aceptoTerminos = valor ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      'Acepto los Términos de Servicio y la Política de Privacidad.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Botón para recuperar
              ElevatedButton(
                onPressed: _aceptoTerminos ? _recuperar : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Continuar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 15),
              // Opción de volver a Iniciar Sesión
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/inicio_sesion');
                },
                child: Text(
                  '¿Ya tienes cuenta? Iniciar Sesión',
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
