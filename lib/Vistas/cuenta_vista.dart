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
  double saldo = 10000; // Saldo de ejemplo, puede ser dinámico
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
        child: Container(
          color: Colors.grey.shade100,
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Nombre del usuario
              Text(
                'Hola',
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

              // Card del saldo
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Saldo',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'S/. ${saldo.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Acción para agregar fondos
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
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

              // Sección de pago si hay un monto pendiente
              if (widget.detallesPago != null) ...[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Monto a Pagar',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Total: S/. ${widget.detallesPago!['needAmount'].toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Descuento: S/. ${widget.detallesPago!['discountAmount'].toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Impuesto: S/. ${widget.detallesPago!['taxAmount'].toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _procesando ? null : _realizarPago,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade800,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: _procesando
                              ? CircularProgressIndicator()
                              : Text(
                            'Pagar',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],

              // Sección de movimientos
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

              // Card de movimientos
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: double.infinity,
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
                          // Acción para ver más movimientos
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
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

// Widget reutilizable para los movimientos
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
    return ListTile(
      title: Text(titulo),
      subtitle: Text(detalle),
      trailing: Text(monto, style: TextStyle(color: colorMonto, fontWeight: FontWeight.bold)),
    );
  }
}
