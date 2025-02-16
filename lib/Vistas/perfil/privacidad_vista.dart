import 'package:flutter/material.dart';

class PrivacidadVista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Fondo gris claro
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Encabezado degradado con botón atrás
            _buildEncabezado(context),
            // Contenedor flotante
            Container(
              transform: Matrix4.translationValues(0, -20, 0),
              padding: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0,2),
                    ),
                  ],
                ),
                child: Text(
                  'Bienvenido a la Política de Privacidad de Park Access.\n\n'
                      '1. Recopilación de Información\n'
                      '- Recopilamos datos personales como nombre, correo electrónico y número de teléfono para el registro.\n'
                      '- Se almacenan datos de estacionamiento y pagos para mejorar la experiencia del usuario.\n\n'
                      '2. Uso de la Información\n'
                      '- La información se utiliza para mejorar el servicio y la seguridad de los usuarios.\n'
                      '- No compartimos datos personales con terceros sin consentimiento.\n\n'
                      '3. Seguridad\n'
                      '- Implementamos medidas de seguridad para proteger los datos.\n'
                      '- Sin embargo, no podemos garantizar una seguridad absoluta en internet.\n\n'
                      '4. Derechos del Usuario\n'
                      '- Puede solicitar la eliminación de su cuenta y datos personales en cualquier momento.\n'
                      '- Para más información, puede contactarnos a través del soporte de la aplicación.\n',
                  style: TextStyle(
                    color: Colors.blue.shade900,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Encabezado degradado con botón atrás
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
            // Botón atrás
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Spacer(),
            // Título
            Text(
              'Política de Privacidad',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
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
}

