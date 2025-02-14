import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modelos/licencia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LicenciaService {
  final String baseUrl = 'https://gamarracode.parkinventario.com/token.php';

  Future<Map<String, dynamic>> validarLicencia(String licencia, String deviceId) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'validar': true, 'licencia': licencia, 'device_id': deviceId}),
    );
    return jsonDecode(response.body);
  }

  Future<void> resetLicencia(String deviceId) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'reset': true, 'device_id': deviceId}),
    );
  }
}