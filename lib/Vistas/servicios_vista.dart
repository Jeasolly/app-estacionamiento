import 'package:flutter/material.dart';

class ServiciosVista extends StatefulWidget {
  @override
  _ServiciosVistaState createState() => _ServiciosVistaState();
}

class _ServiciosVistaState extends State<ServiciosVista> {
  // Saldo y estado de visibilidad
  final double _saldo = 2.0;
  bool _ocultarSaldo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo general gris claro
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          // Encabezado con degradado
          _buildEncabezado(),
          // Tarjeta saldo flotante
          _buildTarjetaSaldo(),
          // Grid con los servicios
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _BotonCircular(
                    titulo: 'Abonado',
                    imagen: 'assets/images/abonado.png',
                    onTap: () {},
                  ),
                  _BotonCircular(
                    titulo: 'Soporte',
                    imagen: 'assets/images/soporte.png',
                    onTap: () {},
                  ),
                  _BotonCircular(
                    titulo: 'Reservas',
                    imagen: 'assets/images/reservas.png',
                    onTap: () {},
                  ),
                  _BotonCircular(
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

  /// Construye el encabezado con un degradado azul y logo
  Widget _buildEncabezado() {
    return Container(
      width: double.infinity,
      height: 140,
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

  /// Tarjeta semitransparente para mostrar/ocultar saldo
  Widget _buildTarjetaSaldo() {
    final icono = _ocultarSaldo ? Icons.visibility_off : Icons.visibility;
    final textoBoton = _ocultarSaldo ? 'Mostrar Saldo' : 'Ocultar Saldo';
    final saldoMostrado =
    _ocultarSaldo ? 'S/ ****' : 'S/ ${_saldo.toStringAsFixed(2)}';

    return Container(
      transform: Matrix4.translationValues(0, -20, 0), // Flotar sobre encabezado
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
                saldoMostrado,
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
class _BotonCircular extends StatelessWidget {
  final String titulo;
  final String imagen;
  final VoidCallback onTap;

  const _BotonCircular({
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
          // Usamos Material para sombra circular
          Material(
            elevation: 3,
            shape: CircleBorder(),
            child: Container(
              height: 90,
              width: 90,
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
