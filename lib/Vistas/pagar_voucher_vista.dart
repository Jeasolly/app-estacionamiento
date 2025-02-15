import 'package:flutter/material.dart';
import 'escaneo_qr_vista.dart';
import 'ingreso_manual_vista.dart';

class PagarVoucherVista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        title: Text(
          'Pagar Voucher',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Colors.grey.shade100,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => IngresoManualVista()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
