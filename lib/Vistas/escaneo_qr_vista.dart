import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../Controladores/pagar_voucher_controlador.dart';
import 'cuenta_vista.dart'; // Se cambia a cuenta_vista

class EscaneoQRVista extends StatefulWidget {
  @override
  _EscaneoQRVistaState createState() => _EscaneoQRVistaState();
}

class _EscaneoQRVistaState extends State<EscaneoQRVista> {
  final PagarVoucherControlador _controlador = PagarVoucherControlador();
  bool _escaneoCompletado = false;

  void _procesarQR(String qrResult) async {
    if (qrResult.isEmpty || _escaneoCompletado) return;

    String cardNo = qrResult;

    setState(() {
      _escaneoCompletado = true;
    });

    final montos = await _controlador.obtenerMontos(cardNo: cardNo);

    if (montos != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CuentaVista(
            cardNo: cardNo,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escanear Ticket')),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: MobileScanner(
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty && !_escaneoCompletado) {
                  _procesarQR(barcodes.first.rawValue ?? "");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
