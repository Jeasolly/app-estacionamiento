import 'package:flutter/material.dart';

class TerminosVista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Fondo gris claro
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Encabezado degradado con botón atrás
            _buildEncabezado(context),
            // Tarjeta flotante con términos
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
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Bienvenido a Park Access.\n\n'
                      '1. Introducción\n'
                      'Estos términos y condiciones regulan el uso de la aplicación Park Access. '
                      'Al utilizar la aplicación, usted acepta cumplir con estos términos en su totalidad.\n\n'
                      '2. Uso del Servicio\n'
                      '- Park Access proporciona gestión automatizada de estacionamientos.\n'
                      '- El usuario es responsable de la información ingresada en la aplicación.\n\n'
                      '3. Pagos y Tarifas\n'
                      '- Los pagos por el uso del estacionamiento se gestionan a través de los métodos de pago disponibles.\n'
                      '- No se realizarán reembolsos una vez confirmado el pago.\n\n'
                      '4. Responsabilidad\n'
                      '- Park Access no se hace responsable por daños o robos dentro de los estacionamientos.\n'
                      '- La empresa garantiza el funcionamiento del sistema, pero no se responsabiliza por fallas externas.\n\n'
                      '5. Modificaciones\n'
                      'Nos reservamos el derecho de modificar estos términos en cualquier momento. '
                      'El uso continuo de la aplicación implica la aceptación de los cambios.',
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
            // Título centrado
            Text(
              'Términos y Condiciones',
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
