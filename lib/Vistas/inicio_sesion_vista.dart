import 'package:flutter/material.dart';

class InicioSesionVista extends StatefulWidget {
  @override
  _InicioSesionVistaState createState() => _InicioSesionVistaState();
}

class _InicioSesionVistaState extends State<InicioSesionVista> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _mostrarPassword = false;

  void _iniciarSesion() {
    // De momento solo navegará, sin lógica de autenticación
    // Ajusta la ruta según tu configuración (p.e. '/home')
    Navigator.pushNamed(context, '/home');
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
                'assets/images/logo.png', // Ajusta la ruta de tu logo
                height: 80,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              // Texto de bienvenida
              Text(
                'Hola!\nEs bueno saber de ti!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Ingresa con tu correo y contraseña',
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
              // Campo de texto para la contraseña
              TextField(
                controller: _passwordController,
                obscureText: !_mostrarPassword,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
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
                      _mostrarPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
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
              // Botón de Ingresar
              ElevatedButton(
                onPressed: _iniciarSesion,
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
              // Enlaces para recuperar contraseña o registro
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navegar a recuperar contraseña
                      Navigator.pushNamed(context, '/recuperar_contrasena');
                    },
                    child: Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(color: Colors.greenAccent, fontSize: 14),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navegar a pantalla de registro
                      Navigator.pushNamed(context, '/registro');
                    },
                    child: Text(
                      'Registrarse',
                      style: TextStyle(color: Colors.greenAccent, fontSize: 14),
                    ),
                  ),
                ],
              ),
              // Opcional: icons de redes sociales
              SizedBox(height: 10),
              Text(
                'O usa una de tus redes sociales:',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.g_mobiledata, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.facebook, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.account_circle_outlined, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
