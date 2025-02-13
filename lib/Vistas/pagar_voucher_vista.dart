import 'package:flutter/material.dart';

class PagarVoucherVista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true, // Centra el título
        title: Text(
          'Pagar Voucher',
          style: TextStyle(
            fontSize: 24,            // Más grande
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      // Contenido
      body: Container(
        color: Colors.grey.shade100,
        width: double.infinity,          // Ocupar ancho completo
        padding: EdgeInsets.all(20),
        // Centrar el contenido tanto vertical como horizontalmente
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Texto explicativo
            Text(
              'Escanea tu voucher de estacionamiento para\nconocer el monto a cancelar',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 30),

            // Ícono central simulando el QR
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.qr_code_scanner,
                size: 100,         // Ícono más grande
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 30),

            // Botón Validar
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de cuenta
                Navigator.pushNamed(context, '/cuenta');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Validar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
