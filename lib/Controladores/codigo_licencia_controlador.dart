import 'package:shared_preferences/shared_preferences.dart';
import '../Servicios/codigo_licencia_servicio.dart';

class LicenciaController {
  final LicenciaService _service = LicenciaService();

  Future<bool> validarLicencia(String licencia, String deviceId) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await _service.validarLicencia(licencia, deviceId);
    if (response['status'] == 'success') {
      await prefs.setString('license', licencia);
      await prefs.setString('device_id', deviceId);
      return true;
    }
    return false;
  }

  Future<void> resetLicencia() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('device_id');
    if (deviceId != null) {
      await _service.resetLicencia(deviceId);
      await prefs.remove('license');
      await prefs.remove('device_id');
    }
  }

  /// ✅ **Nuevo método para verificar si hay licencia guardada**
  Future<bool> verificarLicenciaGuardada() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('license');
  }
}