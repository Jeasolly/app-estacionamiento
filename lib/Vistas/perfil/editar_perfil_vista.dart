import 'dart:io';
import 'package:flutter/material.dart';

class EditarPerfilVista extends StatefulWidget {
  @override
  _EditarPerfilVistaState createState() => _EditarPerfilVistaState();
}

class _EditarPerfilVistaState extends State<EditarPerfilVista> {
  final TextEditingController _nombreController =
  TextEditingController(text: 'Esther Howard');
  final TextEditingController _telefonoController =
  TextEditingController(text: '1234567890');
  final TextEditingController _correoController =
  TextEditingController(text: 'cameronwilliamson@example.com');
  File? _imagenPerfil;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        children: [
          // Sección de encabezado degradado + botón back
          _buildEncabezado(context),

          // Tarjeta flotante con foto y campos de perfil
          _buildTarjetaPerfil(),

          SizedBox(height: 24),

          // Botón "Actualizar"
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _guardarPerfil,
                child: Text(
                  'Actualizar Perfil',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
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
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Spacer(),
            Text(
              'Editar Perfil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            SizedBox(width: 48), // Para equilibrar el botón izquierdo
          ],
        ),
      ),
    );
  }

  /// Tarjeta con la foto de perfil y los campos de edición
  Widget _buildTarjetaPerfil() {
    return Container(
      transform: Matrix4.translationValues(0, -20, 0),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Imagen de perfil con ícono de cámara
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: _imagenPerfil == null
                          ? AssetImage('assets/profile.jpg') as ImageProvider
                          : FileImage(_imagenPerfil!),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: InkWell(
                        onTap: _cambiarFoto,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Actualizar foto de perfil',
                style: TextStyle(color: Colors.blue.shade900, fontSize: 14),
              ),
              SizedBox(height: 16),

              // Campos de entrada
              _crearCampoTexto('Nombre', _nombreController),
              SizedBox(height: 16),
              _crearCampoTexto('Número de teléfono', _telefonoController,
                  tipo: TextInputType.phone),
              SizedBox(height: 16),
              _crearCampoTexto('Correo electrónico', _correoController,
                  tipo: TextInputType.emailAddress),
            ],
          ),
        ),
      ),
    );
  }

  /// Método para crear los campos de texto con el estilo correspondiente
  Widget _crearCampoTexto(String label, TextEditingController controller,
      {TextInputType tipo = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: tipo,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blue.shade900),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green.shade700),
        ),
      ),
    );
  }

  void _cambiarFoto() async {
    // Aquí iría la lógica para seleccionar imagen usando ImagePicker
    print('Cambiar foto de perfil...');
  }

  void _guardarPerfil() {
    // Lógica para guardar los cambios
    print('Guardando perfil...');
    print('Nombre: ${_nombreController.text}');
    print('Teléfono: ${_telefonoController.text}');
    print('Correo: ${_correoController.text}');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Perfil actualizado correctamente')),
    );
  }
}
