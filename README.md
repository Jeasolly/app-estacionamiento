🚗 App Estacionamiento
📌 Versión 1.0.0
📅 Última actualización: [13/02/2025]

Aplicación desarrollada en Flutter para la gestión de estacionamientos, pagos y reserva de espacios. La app permite a los usuarios realizar pagos, gestionar su cuenta y consultar estacionamientos disponibles de manera eficiente.

📂 Estructura del Proyecto
plaintext
Copiar
Editar
lib/
├── Controladores/           # Controladores de la app (MVC)
├── Modelos/                 # Modelos de datos
├── Servicios/               # Llamadas a APIs y lógica de negocio
├── Vistas/                  # Pantallas de la aplicación
│   ├── bienvenida_vista.dart
│   ├── codigo_licencia_vista.dart
│   ├── inicio_sesion_vista.dart
│   ├── registro_vista.dart
│   ├── recuperar_contrasena_vista.dart
│   ├── home_vista.dart
│   ├── servicios_vista.dart
│   ├── mapa_vista.dart
│   ├── pagar_voucher_vista.dart
│   ├── cuenta_vista.dart
│   ├── metodo_pago_vista.dart
│   ...
├── main.dart                # Punto de entrada de la app
├── rutas.dart               # Definición de rutas de navegación
├── tema.dart                # Configuración de estilos globales
└── utilidades/              # Funciones reutilizables y constantes
📱 Funcionalidades Implementadas
✅ Pantalla de Bienvenida
Muestra una imagen de fondo con la opción "Toca para comenzar".
Navega a la pantalla de Código de Licencia al hacer tap.
✅ Código de Licencia
Permite ingresar un código para verificar el acceso al sistema.
Botón de Ingresar que lleva al inicio de sesión.
✅ Inicio de Sesión
Interfaz con campos de email y contraseña.
Opción para mostrar/ocultar la contraseña.
Botón Ingresar que lleva a la pantalla principal.
✅ Registro de Usuario
Formulario de registro con validaciones básicas.
Checkbox de aceptación de términos y condiciones.
✅ Recuperar Contraseña
Permite restablecer la contraseña mediante email.
Validaciones para ingreso correcto de datos.
✅ Pantalla Principal (Home)
BottomNavigationBar con tres secciones:
Home (pantalla principal)
Servicios (opciones adicionales)
Perfil (datos del usuario)
Muestra el logo en la parte superior.
Sección de "Mostrar/Ocultar Saldo" con animación (S/ **** → S/ 2.00).
Grid de opciones: Pagar Voucher, Estacionamientos, etc.
✅ Servicios
Similar estructura a Home, con íconos de Abonado, Soporte, Reservas.
Opción para mostrar/ocultar saldo con botón dinámico.
✅ Pagar Voucher
Escanea un código QR para conocer el monto a cancelar.
Botón de Validar que lleva a la pantalla de Cuenta.
✅ Cuenta del Usuario
Muestra saldo disponible y movimientos recientes.
Botón de Agregar Fondos que lleva a Método de Pago.
✅ Método de Pago
Selección de tarjetas guardadas y opción para agregar nuevas.
Botón de Continuar que simula el proceso de pago.
🏗️ Pasos Realizados en el Desarrollo
Inicialización del Proyecto en Flutter

Se creó con flutter create app-estacionamiento.
Se configuró pubspec.yaml para imágenes y dependencias (flutter pub get).
Implementación de Pantallas con Material Design

Se diseñaron interfaces con AppBars personalizadas, botones y estilos.
Gestión de Rutas

Implementación de navegación con Navigator.pushNamed(context, '/ruta').
Organización en MVC

Separación de lógica en Controladores, Modelos y Servicios.
Bottom Navigation Bar

Implementado en home_vista.dart, permitiendo navegación fluida.
Control de Estado

Uso de setState() para ocultar/mostrar saldo en Home y Servicios.
🚀 Cómo Ejecutar la Aplicación
Clonar el repositorio
bash
Copiar
Editar
git clone https://github.com/tuUsuario/app-estacionamiento.git
Ir a la carpeta del proyecto
bash
Copiar
Editar
cd app-estacionamiento
Instalar dependencias
bash
Copiar
Editar
flutter pub get
Ejecutar la aplicación
bash
Copiar
Editar
flutter run
(Asegúrate de tener un emulador o dispositivo conectado).
📌 Próximos Pasos
✔ Integración con APIs para autenticación y pagos
✔ Escaneo real de QR en "Pagar Voucher"
✔ Persistencia de sesión con SharedPreferences o SQLite
✔ Optimización de UI con animaciones y efectos de transición

📜 Licencia
Este proyecto se distribuye bajo la licencia MIT.

💡 ¿Quieres contribuir?
Si deseas colaborar en este proyecto, puedes hacer un fork y enviar un pull request con mejoras o nuevas funciones.

📌 Contacto y Soporte:
📧 Email: jeangamarra1@gmail.com
🔗 Repositorio en GitHub: https://github.com/Jeasolly/app-estacionamiento

🚀 ¡Gracias por contribuir al desarrollo de la App Estacionamiento! 🚗
