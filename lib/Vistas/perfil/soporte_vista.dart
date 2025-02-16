import 'package:flutter/material.dart';

class SoporteVista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Fondo general
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildEncabezado(context),
            // Contenedor flotante si quieres efecto sobre el degradado
            // Lo colocamos algo más abajo para no superponerse al encabezado
            Container(
              padding: EdgeInsets.all(16),
              transform: Matrix4.translationValues(0, -20, 0),
              child: Column(
                children: [
                  // Imagen de ayuda/soporte fuera de tarjeta
                  Image.asset('assets/images/soporte.png', height: 150),
                  SizedBox(height: 16),

                  // Fila de botones Llamar/Correo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.phone),
                        label: Text('Llamar'),
                      ),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.green.shade700,
                          side: BorderSide(color: Colors.green.shade700),
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.email),
                        label: Text('Enviar correo'),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

                  // Tarjeta blanca con “Contacto rápido”
                  Container(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contacto rápido',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        SizedBox(height: 16),

                        // Campo: Nombre
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                            labelStyle: TextStyle(color: Colors.blue.shade900),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Campo: Correo
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Correo electrónico',
                            labelStyle: TextStyle(color: Colors.blue.shade900),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Campo: Mensaje
                        TextField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Mensaje',
                            labelStyle: TextStyle(color: Colors.blue.shade900),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Botón “Enviar”
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade700,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: Text('Enviar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Encabezado con degradado y botón atrás
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
              'Ayuda y Soporte',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            SizedBox(width: 48), // Espacio para equilibrar el icono back
          ],
        ),
      ),
    );
  }
}
