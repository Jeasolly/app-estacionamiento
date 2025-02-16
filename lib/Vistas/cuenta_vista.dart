import 'package:flutter/material.dart';
import '../Controladores/pagar_voucher_controlador.dart';

class CuentaVista extends StatefulWidget {
  final String? cardNo;
  final double? monto;
  final Map<String, dynamic>? detallesPago;

  CuentaVista({this.cardNo, this.monto, this.detallesPago});

  @override
  _CuentaVistaState createState() => _CuentaVistaState();
}

class _CuentaVistaState extends State<CuentaVista> {
  final PagarVoucherControlador _controlador = PagarVoucherControlador();
  double saldo = 9740.00;
  bool _procesando = false;

  void _realizarPago() async {
    if (widget.monto == null || widget.cardNo == null) {
      _mostrarMensaje("No hay información de pago disponible.");
      return;
    }

    if (saldo < widget.monto!) {
      _mostrarMensaje("Saldo insuficiente. Agrega fondos.");
      return;
    }

    setState(() {
      _procesando = true;
    });

    bool exito = await _controlador.actualizarEstadoPago(
      cardNo: widget.cardNo,
      monto: widget.monto!,
    );

    setState(() {
      _procesando = false;
    });

    if (exito) {
      setState(() {
        saldo -= widget.monto!;
      });
      _mostrarMensaje("✅ Pago realizado correctamente.", success: true);
    } else {
      _mostrarMensaje("❌ Error al procesar el pago.");
    }
  }

  void _mostrarMensaje(String mensaje, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          // 🟦 Encabezado degradado con botón atrás
          _buildEncabezado(context),

          // 📌 Tarjeta de saldo
          _buildTarjetaSaldo(),

          // 📌 Tarjeta de pago (solo si hay un pago pendiente)
          if (widget.detallesPago != null) _buildTarjetaPago(),

          // 📌 Sección de movimientos
          Expanded(child: _buildSeccionMovimientos()),
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
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Spacer(),
            Text(
              'Mi Cuenta',
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

  /// **Tarjeta de saldo (Ocupa todo el ancho)**
  Widget _buildTarjetaSaldo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: _estiloTarjeta(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Saldo disponible', style: TextStyle(color: Colors.blueGrey, fontSize: 16)),
          SizedBox(height: 5),
          Text(
            'S/. ${saldo.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Acción para agregar fondos
            },
            style: _botonEstilo(Colors.green.shade700),
            child: Text('+ Agregar Fondos', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  /// **Tarjeta de pago (Ocupa todo el ancho)**
  Widget _buildTarjetaPago() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: _estiloTarjeta(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Monto a Pagar',
            style: TextStyle(color: Colors.blueGrey, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Total: S/. ${widget.detallesPago!['needAmount'].toStringAsFixed(2)}'),
          Text('Descuento: S/. ${widget.detallesPago!['discountAmount'].toStringAsFixed(2)}'),
          Text('Impuesto: S/. ${widget.detallesPago!['taxAmount'].toStringAsFixed(2)}'),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _procesando ? null : _realizarPago,
            style: _botonEstilo(Colors.blue.shade800),
            child: _procesando
                ? CircularProgressIndicator()
                : Text('Pagar', style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  /// **Sección de movimientos con botón "Ver más"**
  Widget _buildSeccionMovimientos() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Movimientos',
            style: TextStyle(color: Colors.blueGrey, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                _MovimientoItem(titulo: 'San Isidro', detalle: 'Hoy', monto: '-S/. 30.00', colorMonto: Colors.red),
                Divider(color: Colors.grey.shade300),
                _MovimientoItem(titulo: 'Mall del Sur', detalle: 'Ayer', monto: '-S/. 8.00', colorMonto: Colors.red),
                Divider(color: Colors.grey.shade300),
                _MovimientoItem(titulo: 'Recarga Saldo', detalle: '03/03/2023', monto: '+S/. 40.00', colorMonto: Colors.green),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Acción para ver más movimientos
                  },
                  child: Text('Ver más', style: TextStyle(color: Colors.blue.shade900)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// **Estilo de tarjetas**
  BoxDecoration _estiloTarjeta() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
    );
  }

  /// **Estilo de botones**
  ButtonStyle _botonEstilo(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}

/// **Widget de Movimientos**
class _MovimientoItem extends StatelessWidget {
  final String titulo;
  final String detalle;
  final String monto;
  final Color colorMonto;

  const _MovimientoItem({
    required this.titulo,
    required this.detalle,
    required this.monto,
    required this.colorMonto,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(titulo),
      subtitle: Text(detalle),
      trailing: Text(monto, style: TextStyle(color: colorMonto, fontWeight: FontWeight.bold)),
    );
  }
}
