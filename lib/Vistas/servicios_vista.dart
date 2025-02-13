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
    // Cambia ícono y texto según _ocultarSaldo
    final icono = _ocultarSaldo ? Icons.visibility_off : Icons.visibility;
    final textoBoton = _ocultarSaldo ? 'Mostrar Saldo' : 'Ocultar Saldo';
    // Si oculto, muestra "S/ ****", si visible, "S/ 2.00"
    final saldoMostrado = _ocultarSaldo ? 'S/ ****' : 'S/ ${_saldo.toStringAsFixed(2)}';

    return Column(
      children: [
        // Encabezado azul con el logo
        Container(
          color: Colors.blue.shade900,
          width: double.infinity,
          padding: EdgeInsets.only(top: 40, bottom: 10),
          child: Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 100,
            ),
          ),
        ),
        // Sección para Mostrar/Ocultar Saldo
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
              Spacer(), // Empuja el saldo a la derecha
              Text(
                saldoMostrado,
                style: TextStyle(color: Colors.blueGrey, fontSize: 16),
              ),
            ],
          ),
        ),
        // Área principal con íconos
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
        ),
      ],
    );
  }
}

// Botón circular reutilizable (misma clase que antes)
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
