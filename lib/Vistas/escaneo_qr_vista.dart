import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../Controladores/pagar_voucher_controlador.dart';
import 'cuenta_vista.dart';

class EscaneoQRVista extends StatefulWidget {
  @override
  _EscaneoQRVistaState createState() => _EscaneoQRVistaState();
}

class _EscaneoQRVistaState extends State<EscaneoQRVista> {
  final PagarVoucherControlador _controlador = PagarVoucherControlador();
  bool _escaneoCompletado = false;
  bool _procesando = false;

  void _procesarQR(String qrResult) async {
    if (qrResult.isEmpty || _escaneoCompletado || _procesando) return;

    setState(() {
      _escaneoCompletado = true;
      _procesando = true;
    });

    final montos = await _controlador.obtenerMontos(cardNo: qrResult);

    setState(() {
      _procesando = false;
    });

    if (montos != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CuentaVista(
            cardNo: qrResult,
            monto: montos["needAmount"] ?? 0.0,
            detallesPago: montos,
          ),
        ),
      );
    } else {
      _mostrarError("No se encontró información para el ticket.");
    }
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("❌ $mensaje"), backgroundColor: Colors.red),
    );

    setState(() {
      _escaneoCompletado = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          // Encabezado con degradado y botón atrás
          _buildEncabezado(context),

          // Indicaciones y área de escaneo
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Escanea el código QR del ticket",
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                ),
                SizedBox(height: 20),

                // Área de escaneo con borde resaltado
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade900, width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      MobileScanner(
                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;
                          if (barcodes.isNotEmpty && !_escaneoCompletado) {
                            _procesarQR(barcodes.first.rawValue ?? "");
                          }
                        },
                      ),
                      if (_procesando)
                        Container(
                          color: Colors.black45,
                          child: Center(
                            child: CircularProgressIndicator(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Botón para escanear nuevamente en caso de error
                if (_escaneoCompletado)
                  ElevatedButton.icon(
                    icon: Icon(Icons.refresh),
                    label: Text("Escanear de nuevo"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _escaneoCompletado = false;
                      });
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// **Encabezado degradado con botón atrás**
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
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Spacer(),
            Text(
              'Escanear Ticket',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}
