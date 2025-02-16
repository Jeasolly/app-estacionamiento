import 'package:flutter/material.dart';
import 'escaneo_qr_vista.dart';
import 'ingreso_manual_vista.dart';

class PagarVoucherVista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Fondo general

      body: Column(
        children: [
          // Encabezado degradado con botón atrás
          _buildEncabezado(context),

          // Tarjeta flotante con botones
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                transform: Matrix4.translationValues(0, -20, 0),
                padding: EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white, // Tarjeta blanca
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Selecciona una opción para continuar',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                      ),
                      SizedBox(height: 30),

                      // Botón para escanear QR
                      ElevatedButton.icon(
                        icon: Icon(Icons.qr_code_scanner),
                        label: Text("Escanear Ticket"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EscaneoQRVista()));
                        },
                      ),
                      SizedBox(height: 20),

                      // Botón para ingreso manual
                      ElevatedButton.icon(
                        icon: Icon(Icons.keyboard),
                        label: Text("Ingresar Ticket Manualmente"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => IngresoManualVista()));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Encabezado degradado con botón atrás y título centrado
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
      child: SafeArea(
        child: Row(
          children: [
            // Botón atrás
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Spacer(),
            // Título
            Text(
              'Pagar Voucher',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            // Espacio para balancear el icono de la izquierda
            SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}
