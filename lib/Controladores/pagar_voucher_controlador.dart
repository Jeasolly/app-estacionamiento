import 'dart:convert';
import 'package:http/http.dart' as http;

class PagarVoucherControlador {
  final String _baseUrl = "http://192.168.1.10/parkapi";

  // Obtener token de autenticación
  Future<String?> obtenerToken() async {
    final response = await http.post(
      Uri.parse("$_baseUrl/getToken"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "username": "00e14c3b",
        "password": "0ea1e855b21348e6"
      }),
    );

    print("📡 Respuesta de la API al obtener token: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["code"] == 0 && data.containsKey("token")) {
        print("✅ Token obtenido: ${data['token']}");
        return data["token"];
      } else {
        print("❌ Error al obtener token: ${data['msg']}");
      }
    }
    return null;
  }

  // Obtener montos de pago
  Future<Map<String, dynamic>?> obtenerMontos({String? plate, String? cardNo}) async {
    String? token = await obtenerToken();
    if (token == null) return null;

    Map<String, String> body = {};
    if (plate != null) body["plate"] = plate;
    if (cardNo != null) body["cardNo"] = cardNo;

    final response = await http.post(
      Uri.parse("$_baseUrl/charge"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: json.encode(body),
    );

    print("📡 Respuesta API (obtener montos): ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["code"] == 0) {
        return data["data"];
      }
    }
    return null;
  }

  // Actualizar estado de pago
  Future<bool> actualizarEstadoPago({String? plate, String? cardNo, required double monto}) async {
    String? token = await obtenerToken();
    if (token == null) return false;

    Map<String, dynamic> body = {
      "payTime": DateTime.now().millisecondsSinceEpoch,
      "amount": monto
    };
    if (plate != null) body["plate"] = plate;
    if (cardNo != null) body["cardNo"] = cardNo;

    final response = await http.post(
      Uri.parse("$_baseUrl/updatePaymentStatus"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: json.encode(body),
    );

    print("📡 Respuesta API (actualizarEstadoPago): ${response.body}");

    final data = json.decode(response.body);
    return data["code"] == 0;
  }
}
