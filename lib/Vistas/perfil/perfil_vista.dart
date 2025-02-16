import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'editar_perfil_vista.dart';
import 'billetera_vista.dart';
import 'soporte_vista.dart';
import 'privacidad_vista.dart';
import 'terminos_vista.dart';

class PerfilVista extends StatefulWidget {
  @override
  _PerfilVistaState createState() => _PerfilVistaState();
}

class _PerfilVistaState extends State<PerfilVista> {
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _cargarImagenPerfil();
  }

  /// Carga la imagen de perfil desde SQLite
  Future<void> _cargarImagenPerfil() async {
    final db = await _obtenerBaseDeDatos();
    final List<Map<String, dynamic>> maps = await db.query('perfil');
    if (maps.isNotEmpty) {
      setState(() {
        _imagePath = maps.first['imagen'];
      });
    }
  }

  /// Abre el selector de imágenes, la guarda en la DB y actualiza el state
  Future<void> _seleccionarImagen() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final Directory appDir = await getApplicationDocumentsDirectory();
    final String fileName = p.basename(pickedFile.path);
    final File savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');

    final db = await _obtenerBaseDeDatos();
    await db.insert('perfil', {'imagen': savedImage.path},
        conflictAlgorithm: ConflictAlgorithm.replace);

    setState(() {
      _imagePath = savedImage.path;
    });
  }

  /// Abre/construye la base de datos local 'perfil.db'
  Future<Database> _obtenerBaseDeDatos() async {
    return openDatabase(
      p.join(await getDatabasesPath(), 'perfil.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE perfil (id INTEGER PRIMARY KEY, imagen TEXT)');
      },
      version: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sin AppBar tradicional, usaré un encabezado con degradado
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          // Encabezado con degradado
          _buildEncabezado(),
          // Tarjeta flotante con info de perfil
          _buildTarjetaPerfil(),
          // Expand las opciones de menú
          Expanded(
            child: ListView(
              children: [
                _construirOpcionMenu(
                  context,
                  Icons.account_balance_wallet,
                  'Billetera',
                  BilleteraVista(),
                ),
                _construirOpcionMenu(
                  context,
                  Icons.help,
                  'Ayuda y soporte',
                  SoporteVista(),
                ),
                _construirOpcionMenu(
                  context,
                  Icons.privacy_tip,
                  'Política de privacidad',
                  PrivacidadVista(),
                ),
                _construirOpcionMenu(
                  context,
                  Icons.rule,
                  'Términos y condiciones',
                  TerminosVista(),
                ),
                _construirBotonCerrarSesion(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Construye el encabezado con degradado azul
  Widget _buildEncabezado() {
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
        child: Center(
          child: Text(
            'Perfil',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  /// Tarjeta blanca con info principal (foto, nombre, email, botón Editar)
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
              // Foto con ícono de cámara
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: _imagePath != null
                          ? FileImage(File(_imagePath!))
                          : AssetImage('assets/profile.jpg') as ImageProvider,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 4, bottom: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade700,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: _seleccionarImagen,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // Nombre
              Text(
                'Nombre de Usuario',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(height: 4),

              // Correo
              Text(
                'usuario@email.com',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              SizedBox(height: 12),

              // Botón "Editar perfil"
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditarPerfilVista()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                ),
                child: Text('Editar perfil'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirOpcionMenu(
      BuildContext context, IconData icono, String titulo, Widget destino) {
    return ListTile(
      leading: Icon(icono, color: Colors.blue.shade900),
      title: Text(
        titulo,
        style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue.shade900, size: 16),
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) => destino)),
    );
  }

  Widget _construirBotonCerrarSesion(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.logout, color: Colors.red.shade700),
      title: Text(
        'Cerrar sesión',
        style: TextStyle(color: Colors.red.shade700),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Cerrar sesión'),
            content: Text('¿Estás seguro de que quieres cerrar sesión?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Lógica para cerrar sesión
                },
                child: Text('Sí, cerrar sesión'),
              ),
            ],
          ),
        );
      },
    );
  }
}
