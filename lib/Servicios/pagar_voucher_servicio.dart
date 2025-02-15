import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Modelos/pago_modelo.dart';
import '../Utilidades/constantes.dart';

class PagarVoucherServicio {
  static String? _token;

  // Obtener Token de Autenticación
  static Future<bool> obtenerToken() async {
    final response = await http.post(
      Uri.parse('${Constantes.baseUrl}/getToken'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": Constantes.username,
        "password": Constantes.password
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["code"] == "0") {
        _token = data["token"];
        return true;
      }
    }
    return false;
  }

  // Obtener el monto del ticket antes de pagar
  static Future<double?> obtenerMonto(String plate, String cardNo) async {
    if (_token == null) {
      bool tokenObtenido = await obtenerToken();
      if (!tokenObtenido) return null;
    }

    final response = await http.post(
      Uri.parse('${Constantes.baseUrl}/calculatePayment'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
      body: jsonEncode({
        "plate": plate,
        "cardNo": cardNo,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["code"] == "0") {
        return data["amount"];
      }
    }
    return null;
  }

  // Validar y actualizar el pago
  static Future<bool> actualizarPago(Pago pago) async {
    if (_token == null) {
      bool tokenObtenido = await obtenerToken();
      if (!tokenObtenido) return false;
    }

    final response = await http.post(
      Uri.parse('${Constantes.baseUrl}/updatePaymentStatus'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
      body: jsonEncode(pago.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["code"] == "0";
    }
    return false;
  }
}
