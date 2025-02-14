class Licencia {
  final String codigo;
  final bool usado;
  final String? fechaUso;
  final String? deviceId;

  Licencia({required this.codigo, required this.usado, this.fechaUso, this.deviceId});

  factory Licencia.fromJson(Map<String, dynamic> json) {
    return Licencia(
      codigo: json['codigo'],
      usado: json['usado'] == 1,
      fechaUso: json['fecha_uso'],
      deviceId: json['device_id'],
    );
  }
}