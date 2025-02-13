Proyecto: App Estacionamiento
Versión 1.0.0
Este proyecto es una aplicación móvil en Flutter que facilita la gestión de estacionamientos y pagos. A lo largo de su desarrollo, hemos creado múltiples vistas, controladores, servicios y un sistema de rutas siguiendo un patrón de organización MVC. A continuación, se describe paso a paso el avance y las funcionalidades implementadas.

Estructura del Proyecto
bash
Copiar
Editar
lib/
├── Controladores/           # Controladores de la app (MVC)
├── Modelos/                 # Modelos de datos
├── Servicios/               # Clases para consumir APIs y lógica de negocio
├── Vistas/                  # Pantallas (vistas) de la aplicación
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
└── utilidades/              # Constantes y funciones reutilizables
Funcionalidades Implementadas
Pantalla de Bienvenida

Fondo con imagen y texto parpadeante que indica “Toca para comenzar”.
Al hacer tap, navega a la pantalla para ingresar el código de licencia.
Pantalla de Código de Licencia

Permite al usuario ingresar un código (similar a un “voucher”).
Un botón valida el código y redirige al inicio de sesión.
Inicio de Sesión

Fondo degradado azul.
Campos de texto para email y contraseña, con opción para mostrar/ocultar la contraseña.
Botón de Ingresar que, por ahora, redirige a la pantalla principal (HomeVista).
Pantalla de Registro

Degradado azul, campos de email y contraseña, checkbox para “Términos y Condiciones”.
Botón Continuar (futuro registro real con API).
Recuperar Contraseña

Similar estilo degradado azul, campos para email y nueva contraseña, con visibilidad opcional.
Botón Continuar que lleva al inicio de sesión o la ruta que se defina.
Pantalla Principal (HomeVista)

BottomNavigationBar con tres secciones: Home, Servicios y Perfil.
En la pestaña Home, aparece el logo en la parte superior, sección “Mostrar/Ocultar Saldo” con animación de ocultar o mostrar (ejemplo: “S/ 2.00”).
Grid de iconos circulares para Pagar Voucher, Estacionamientos, etc.
Pantalla de Servicios

Similar barra superior con logo.
También muestra/oculta saldo de forma dinámica (oculto → “S/ ****”, visible → “S/ 2.00”).
Grid de iconos circulares para Abonado, Soporte, Reservas…
Pagar Voucher

Pantalla con AppBar azul, texto de ayuda para escanear QR.
Ícono que simula la cámara.
Botón “Validar” que redirige a la pantalla de Cuenta.
Pantalla de Cuenta

AppBar azul centrado con “Mi Cuenta”.
Muestra nombre de usuario, saldo y lista de movimientos en tarjetas.
Botón “+ Agregar Fondos” que navega a la pantalla de Método de Pago.
Método de Pago

AppBar con bordes redondeados, imagen de tarjetas, total a pagar, radio buttons para elegir tarjeta y botón “Continuar”.
Pasos Realizados
Configuración Inicial de Proyecto Flutter

Creación con flutter create app-estacionamiento.
Configuración de pubspec.yaml para imágenes y dependencias (flutter pub get).
Implementación de Pantallas

Cada vista en un archivo .dart separado.
Se usó Scaffold con AppBar personalizado para cabeceras, fondos degradados y gradientes.
Rutas y Navegación

Definición de rutas en main.dart (o rutas.dart).
Uso de Navigator.pushNamed(context, '/ruta') para navegar entre pantallas.
MVC y Separación de Lógica

Se crearon carpetas de Modelos, Controladores y Servicios, aunque algunas partes siguen en vistas por ser maquetación temprana.
Control de estado en pantallas con StatefulWidget para acciones como ocultar/mostrar saldo.
Barra de Navegación Inferior

Implementada en home_vista.dart con BottomNavigationBar.
Tres ítems (Home, Servicios, Perfil) que cambian el índice _indiceActual y muestran la vista correspondiente.
Personalización de Estilos

Uso de Colors.blue.shade900 para AppBar y degradados.
Botones con ElevatedButton.styleFrom para colores y bordes redondeados.
Íconos circulares usando BoxDecoration con shape: BoxShape.circle.
Control de Estado

Se usó setState() para refrescar la UI al ocultar/mostrar saldo en HomeVista y ServiciosVista.
Versión

Actualmente etiquetado como Versión 1.0.0.
Cómo Ejecutar
Clona el repositorio:
bash
Copiar
Editar
git clone https://github.com/tuUsuario/app-estacionamiento.git
Entra a la carpeta del proyecto:
bash
Copiar
Editar
cd app-estacionamiento
Instala dependencias:
bash
Copiar
Editar
flutter pub get
Ejecuta la app:
bash
Copiar
Editar
flutter run
(Asegúrate de tener un emulador o dispositivo físico disponible.)
Próximos Pasos
Conectar con APIs reales: Para el login, registro y validación de pagos.
Persistencia de datos: Usar shared_preferences o base de datos local para mantener sesión.
Implementación de Cámara: En la pantalla “Pagar Voucher” para escanear QR real.
Integración de Pasarelas de Pago: Manejar transacciones al agregar fondos.
Estilos avanzados: Animaciones, transiciones, personalización de iconos, etc.
Contribución y Licencia
Si deseas contribuir, por favor haz un fork del repositorio y crea un pull request.
Este proyecto se distribuye bajo la licencia MIT.
¡Gracias por revisar nuestro progreso! Cualquier duda o sugerencia, no dudes en abrir un issue o contactarnos.
