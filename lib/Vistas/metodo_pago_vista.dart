import 'package:flutter/material.dart';

class MetodoPagoVista extends StatefulWidget {
  @override
  _MetodoPagoVistaState createState() => _MetodoPagoVistaState();
}

class _MetodoPagoVistaState extends State<MetodoPagoVista> {
  int _opcionSeleccionada = 0; // Controla cuál tarjeta está seleccionada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar personalizado con esquinas redondeadas inferiores
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Altura del AppBar
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue.shade900,
          // Forma redondeada en la parte de abajo
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          // Usamos un Row personalizado para colocar la flecha y el título centrado
          title: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Método de Pago',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Para mantener el mismo espacio que el IconButton de la izquierda
              SizedBox(width: 48),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.grey.shade100,
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 150),
              // Imagen de tarjeta grande (ajusta ruta)
              Image.asset(
                'assets/images/tarjetas.png',
                height: 120,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 50),

              // Texto "Total a Pagar"
              Text(
                'Total a Pagar',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 5),

              // Contenedor con el monto
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'S/. 30',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Tarjeta #1
              _TarjetaRadio(
                texto: '**** **** **** 5649',
                indexRadio: 0,
                grupoSeleccionado: _opcionSeleccionada,
                onChanged: (valor) {
                  setState(() {
                    _opcionSeleccionada = valor!;
                  });
                },
              ),
              SizedBox(height: 10),

              // Tarjeta #2
              _TarjetaRadio(
                texto: '11/29',
                indexRadio: 1,
                grupoSeleccionado: _opcionSeleccionada,
                onChanged: (valor) {
                  setState(() {
                    _opcionSeleccionada = valor!;
                  });
                },
              ),
              SizedBox(height: 20),

              // Botón Continuar
              ElevatedButton(
                onPressed: () {
                  // Acción al continuar
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Continuar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget reutilizable para cada "tarjeta" con radio button
class _TarjetaRadio extends StatelessWidget {
  final String texto;
  final int indexRadio;
  final int grupoSeleccionado;
  final ValueChanged<int?> onChanged;

  const _TarjetaRadio({
    Key? key,
    required this.texto,
    required this.indexRadio,
    required this.grupoSeleccionado,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio<int>(
          value: indexRadio,
          groupValue: grupoSeleccionado,
          onChanged: onChanged,
          activeColor: Colors.blue.shade900,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.blue.shade800,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            texto,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}