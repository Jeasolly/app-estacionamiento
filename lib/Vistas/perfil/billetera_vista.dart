import 'package:flutter/material.dart';

class BilleteraVista extends StatelessWidget {
  final double montoTotal = 2.0;

  final List<Transaccion> transacciones = [
    Transaccion(
      titulo: 'Estacionamiento Leed',
      fecha: '20 ene, 11:20am',
      monto: 4.50,
      esPositivo: false,
    ),
    // ... (resto de transacciones)
    Transaccion(
      titulo: 'Agregar dinero (ICICI bank)',
      fecha: '19 ene, 09:20am',
      monto: 25.50,
      esPositivo: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo general gris claro
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          // Sección de encabezado degradado + botón back
          _buildEncabezado(context),
          // Tarjeta flotante con el monto y botones
          _buildTarjetaMonto(),
          // Lista de transacciones
          Expanded(
            child: ListView.builder(
              itemCount: transacciones.length,
              itemBuilder: (context, index) {
                final tx = transacciones[index];
                return _buildTransaccionItem(tx);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Encabezado con degradado, botón de retroceso a la izquierda y título centrado
  Widget _buildEncabezado(BuildContext context) {
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
      // SafeArea para no chocar con la barra de estado
      child: SafeArea(
        child: Row(
          children: [
            // Botón atrás
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Spacer(),
            // Título en el centro
            Text(
              'Billetera',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            // Para que el texto quede centrado, podemos meter un SizedBox
            SizedBox(width: 48), // ancho similar al iconButton
          ],
        ),
      ),
    );
  }

  /// Tarjeta flotante con el monto total y los botones
  Widget _buildTarjetaMonto() {
    return Container(
      transform: Matrix4.translationValues(0, -20, 0),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Monto total: S/ ${montoTotal.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900, // Texto en azul oscuro
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Botón "Agregar Dinero"
                  ElevatedButton(
                    onPressed: () {
                      // Acción para agregar dinero
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700, // Verde
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Agregar dinero'),
                  ),

                  // Botón "Enviar al banco" como Outlined
                  OutlinedButton(
                    onPressed: () {
                      // Acción para enviar al banco
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green.shade700,
                      side: BorderSide(
                        color: Colors.green.shade700,
                      ),
                    ),
                    child: Text('Enviar al banco'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Cada transacción en la lista
  Widget _buildTransaccionItem(Transaccion tx) {
    final colorMonto = tx.esPositivo ? Colors.green.shade800 : Colors.red.shade700;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tx.titulo,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade900, // Azul oscuro en título
            ),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Text(
                tx.fecha,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              Spacer(),
              Text(
                (tx.esPositivo ? '+S/ ' : 'S/ ') + tx.monto.toStringAsFixed(2),
                style: TextStyle(fontSize: 16, color: colorMonto),
              ),
            ],
          ),
          Divider(thickness: 0.5, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}

// Clase para simular datos de transacciones
class Transaccion {
  final String titulo;
  final String fecha;
  final double monto;
  final bool esPositivo;

  Transaccion({
    required this.titulo,
    required this.fecha,
    required this.monto,
    required this.esPositivo,
  });
}
