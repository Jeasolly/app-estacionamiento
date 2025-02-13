import 'package:flutter/material.dart'; //
import 'rutas.dart'; //
import 'tema.dart'; //
import 'Vistas/bienvenida_vista.dart'; //
import 'Vistas/codigo_licencia_vista.dart'; //
import 'Vistas/inicio_sesion_vista.dart'; //
import 'Vistas/registro_vista.dart'; //
import 'Vistas/recuperar_contrasena_vista.dart'; //
import 'Vistas/home_vista.dart'; //
import 'Vistas/servicios_vista.dart'; //
import 'Vistas/pagar_voucher_vista.dart'; //
import 'Vistas/cuenta_vista.dart'; //
import 'Vistas/metodo_pago_vista.dart'; //




void main() {
  runApp(AccesoParqueoApp());
}

class AccesoParqueoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Park Access',
      theme: TemaAplicacion.temaClaro, // Asegúrate de que tema.dart tenga esta clase
      initialRoute: '/',
      routes: {
        '/': (context) => BienvenidaVista(),
        '/codigo_licencia': (context) => CodigoLicenciaVista(),
        '/inicio_sesion': (context) => InicioSesionVista(),
        '/registro': (context) => RegistroVista(),
        '/recuperar_contrasena': (context) => RecuperarContrasenaVista(),
        '/home': (context) => HomeVista(),
        '/servicios': (context) => ServiciosVista(),
        '/pagar_voucher': (context) => PagarVoucherVista(),
        '/cuenta': (context) => CuentaVista(),
        '/metodo_pago': (context) => MetodoPagoVista(),






      },
      debugShowCheckedModeBanner: false,
    );
  }
}

