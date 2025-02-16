import 'package:flutter/material.dart';
import '../Controladores/pagar_voucher_controlador.dart';
import 'cuenta_vista.dart';

class IngresoManualVista extends StatefulWidget {
  @override
  _IngresoManualVistaState createState() => _IngresoManualVistaState();
}

class _IngresoManualVistaState extends State<IngresoManualVista> {
  final TextEditingController _ticketController = TextEditingController();
  final PagarVoucherControlador _controlador = PagarVoucherControlador();
  bool _cargando = false;

  void _calcularMonto() async {
    if (_ticketController.text.isEmpty) return;

    setState(() {
      _cargando = true;
    });

    final montos = await _controlador.obtenerMontos(cardNo: _ticketController.text);

    setState(() {
      _cargando = false;
    });

    if (montos != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CuentaVista(
            cardNo: _ticketController.text,
            monto: montos["needAmount"] ?? 0.0,
            detallesPago: montos,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("❌ No se encontró información para el ticket ingresado."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Fondo general

      body: Column(
        children: [
          // 🟦 Encabezado degradado con botón atrás
          _buildEncabezado(context),

          // 🏷️ Tarjeta flotante
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
                      // 🔹 Título
                      Text(
                        'Ingrese el número de ticket',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                      ),
                      SizedBox(height: 20),

                      // 🔢 Campo de texto estilizado
                      TextField(
                        controller: _ticketController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          labelText: "Número de ticket",
                          labelStyle: TextStyle(color: Colors.blue.shade900),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green.shade700,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // 🟩 Botón estilizado
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade700,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: _cargando ? null : _calcularMonto,
                          child: _cargando
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text("Calcular Monto", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
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

  /// **Encabezado con degradado y botón atrás**
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
            // 🔙 Botón atrás
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Spacer(),
            // 📌 Título
            Text(
              'Ingreso Manual',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            // 🏷️ Espacio para balancear el icono de la izquierda
            SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}
