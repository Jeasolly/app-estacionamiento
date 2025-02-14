import 'package:flutter/material.dart';
import 'servicios_vista.dart';
import 'codigo_licencia_vista.dart';
import 'inicio_sesion_vista.dart';
import '../controladores/codigo_licencia_controlador.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

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
    PaginaPerfil(),
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

// ------------ PÁGINA HOME (Stateful) ------------
class PaginaHome extends StatefulWidget {
  @override
  _PaginaHomeState createState() => _PaginaHomeState();
}

class _PaginaHomeState extends State<PaginaHome> {
  final double _saldo = 2.0;
  bool _ocultarSaldo = true;

  @override
  Widget build(BuildContext context) {
    final icono = _ocultarSaldo ? Icons.visibility_off : Icons.visibility;
    final textoBoton = _ocultarSaldo ? 'Mostrar Saldo' : 'Ocultar Saldo';

    return Column(
      children: [
        Container(
          color: Colors.blue.shade900,
          padding: EdgeInsets.only(top: 40, bottom: 10),
          width: double.infinity,
          child: Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 100,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.grey.shade100,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
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
        ),
      ],
    );
  }
}

// ------------ PÁGINA PERFIL ------------
class PaginaPerfil extends StatelessWidget {
  Future<void> _cerrarSesion(BuildContext context) async {
    final Database db = await openDatabase(
      p.join(await getDatabasesPath(), 'licencia.db'),
    );
    await db.delete('licencia');
    await db.close();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => InicioSesionVista()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade50,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Perfil de Usuario', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _cerrarSesion(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Cerrar Sesión', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------ BOTÓN CIRCULAR ------------
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
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
