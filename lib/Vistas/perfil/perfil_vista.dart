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

  Future<void> _cargarImagenPerfil() async {
    final db = await _obtenerBaseDeDatosPerfil();
    final List<Map<String, dynamic>> maps = await db.query('perfil');
    if (maps.isNotEmpty) {
      setState(() {
        _imagePath = maps.first['imagen'];
      });
    }
  }

  Future<void> _seleccionarImagen() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final Directory appDir = await getApplicationDocumentsDirectory();
    final String fileName = p.basename(pickedFile.path);
    final File savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');

    final db = await _obtenerBaseDeDatosPerfil();
    await db.insert('perfil', {'imagen': savedImage.path}, conflictAlgorithm: ConflictAlgorithm.replace);

    setState(() {
      _imagePath = savedImage.path;
    });
  }

  Future<Database> _obtenerBaseDeDatosPerfil() async {
    return openDatabase(
      p.join(await getDatabasesPath(), 'perfil.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE perfil (id INTEGER PRIMARY KEY, imagen TEXT)');
      },
      version: 1,
    );
  }

  Future<Database> _obtenerBaseDeDatosLicencia() async {
    return openDatabase(
      p.join(await getDatabasesPath(), 'licencia.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE licencia(id INTEGER PRIMARY KEY, codigo TEXT)");
      },
      version: 1,
    );
  }

  Future<void> _resetearBaseDeDatos() async {
    final perfilDBPath = p.join(await getDatabasesPath(), 'perfil.db');
    final licenciaDBPath = p.join(await getDatabasesPath(), 'licencia.db');

    if (await File(perfilDBPath).exists()) {
      await deleteDatabase(perfilDBPath);
    }
    if (await File(licenciaDBPath).exists()) {
      await deleteDatabase(licenciaDBPath);
    }

    setState(() {
      _imagePath = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Base de datos de perfil y licencia reseteadas correctamente.'), backgroundColor: Colors.green),
    );
  }

  void _confirmarReset() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Resetear base de datos'),
        content: Text('¿Estás seguro de que deseas borrar todos los datos de perfil y licencia?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _resetearBaseDeDatos();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Resetear', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          _buildEncabezado(),
          _buildTarjetaPerfil(),
          Expanded(
            child: ListView(
              children: [
                _construirOpcionMenu(context, Icons.account_balance_wallet, 'Billetera', BilleteraVista()),
                _construirOpcionMenu(context, Icons.help, 'Ayuda y soporte', SoporteVista()),
                _construirOpcionMenu(context, Icons.privacy_tip, 'Política de privacidad', PrivacidadVista()),
                _construirOpcionMenu(context, Icons.rule, 'Términos y condiciones', TerminosVista()),
                _construirBotonResetearDB(context),
                _construirBotonCerrarSesion(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

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
                      decoration: BoxDecoration(color: Colors.green.shade700, shape: BoxShape.circle),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: _seleccionarImagen,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Text('Jean Pierre GV', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
              SizedBox(height: 4),
              Text('jpieritop@email.com', style: TextStyle(color: Colors.grey.shade700)),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditarPerfilVista())),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700, foregroundColor: Colors.white),
                child: Text('Editar perfil'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirOpcionMenu(BuildContext context, IconData icono, String titulo, Widget destino) {
    return ListTile(
      leading: Icon(icono, color: Colors.blue.shade900),
      title: Text(titulo, style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue.shade900, size: 16),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => destino)),
    );
  }

  Widget _construirBotonResetearDB(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.refresh, color: Colors.orange.shade700),
      title: Text('Resetear Datos', style: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.warning, color: Colors.orange.shade700, size: 16),
      onTap: _confirmarReset,
    );
  }

  Widget _construirBotonCerrarSesion(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.logout, color: Colors.red.shade700),
      title: Text('Cerrar sesión', style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.exit_to_app, color: Colors.red.shade700, size: 16),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
