import 'package:flutter/material.dart';
import '../Controladores/pagar_voucher_controlador.dart';
import 'cuenta_vista.dart'; // Se cambia a cuenta_vista

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
      appBar: AppBar(title: Text('Ingreso Manual')),
      body: Column(
        children: [
          TextField(controller: _ticketController, decoration: InputDecoration(labelText: "Ingrese el número de ticket")),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _cargando ? null : _calcularMonto,
            child: Text("Calcular Monto"),
          ),
        ],
      ),
    );
  }
}
