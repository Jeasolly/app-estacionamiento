import 'package:flutter/material.dart';

class CuentaVista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        title: Text(
          'Mi Cuenta',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        // Permite hacer scroll si la pantalla es muy pequeña
        child: Container(
          color: Colors.grey.shade100,
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            // Centra verticalmente todo el contenido
            mainAxisAlignment: MainAxisAlignment.center,
            // Centra horizontalmente todo el contenido
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Bienvenida y nombre de usuario
              Text(
                'Bienvenido',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey, fontSize: 16),
              ),
              Text(
                'Juan Perez',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // Card para Saldo
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: 300, // Ajusta el ancho si deseas más pequeño o grande
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Saldo',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'S/. 2.00',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/metodo_pago');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          '+ Agregar Fondos',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Sección de Movimientos
              Text(
                'Movimientos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              // Card para la lista de movimientos
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: 300,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _MovimientoItem(
                        titulo: 'San Isidro',
                        detalle: 'Hoy',
                        monto: '-S/. 30.00',
                        colorMonto: Colors.red,
                      ),
                      Divider(color: Colors.grey.shade300),
                      _MovimientoItem(
                        titulo: 'Mall del Sur',
                        detalle: 'Ayer',
                        monto: '-S/. 8.00',
                        colorMonto: Colors.red,
                      ),
                      Divider(color: Colors.grey.shade300),
                      _MovimientoItem(
                        titulo: 'Real Plaza - Sta Clara',
                        detalle: '03/03/2023',
                        monto: '+S/. 40.00',
                        colorMonto: Colors.green,
                      ),
                      SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: () {
                          // Navegar a página con historial completo
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Ver Todos'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget para cada movimiento
class _MovimientoItem extends StatelessWidget {
  final String titulo;
  final String detalle;
  final String monto;
  final Color colorMonto;

  const _MovimientoItem({
    Key? key,
    required this.titulo,
    required this.detalle,
    required this.monto,
    required this.colorMonto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Nombre y fecha
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 3),
            Text(
              detalle,
              style: TextStyle(fontSize: 14, color: Colors.blueGrey),
            ),
          ],
        ),
        // Monto
        Text(
          monto,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colorMonto,
          ),
        ),
      ],
    );
  }
}
