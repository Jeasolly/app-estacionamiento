# **App Estacionamiento
## ****Versión 1.0.0 | Última actualización: 19/02/2025

Aplicación desarrollada en Flutter para la gestión de estacionamientos, pagos online. Permite a los usuarios realizar pagos utilizando tarjetas y varios medios de pago como yape, gestionar su cuenta de manera eficiente.

## 📌 **Change Log**
# Versión 1.0.2 | 15/02/2025
## 🚀 Mejoras en la Interfaz de Usuario
###### Se optimizó el diseño de la pantalla de bienvenida con animaciones mejoradas.
###### Se implementó un efecto de parpadeo en el texto "Toca para comenzar >" para mejorar la visibilidad.
###### Se mejoró el diseño de las tarjetas en la pantalla de Mi Cuenta, haciendo que ocupen todo el ancho de la pantalla y sean completamente responsivas.
###### Se corrigieron problemas de alineación en los botones de acción dentro de las pantallas de perfil y billetera.
###### Se añadió un carrusel de banners en la pantalla de inicio para destacar promociones y mensajes importantes.
## 🛠️ Correcciones y Optimización
###### Se optimizó la gestión de AnimationController para evitar errores con TickerProviderStateMixin.
###### Se corrigieron errores de inicialización de variables que afectaban la animación en la pantalla de bienvenida.
###### Se mejoró la fluidez de las transiciones entre la pantalla de inicio de sesión y la validación de código de licencia.
###### Se ajustó la estructura del código para evitar redundancias en las animaciones.
## 🔌 Integración con Backend y APIs
###### Se integraron las APIs de cobro dentro del sistema de estacionamientos.
###### Se optimizó la comunicación entre la aplicación y el servidor para manejar pagos de manera más eficiente.
###### Se configuraron correctamente las llamadas a las APIs de validación de licencias y administración de usuarios.
## 🧪 Pruebas Realizadas
###### Se verificó que la animación de bienvenida se ejecute sin errores.
###### Se probó el efecto de parpadeo en el texto de inicio y su correcto funcionamiento en diferentes dispositivos.
###### Se confirmó que la navegación entre pantallas se mantenga estable sin errores de transición.
###### Se validó la correcta comunicación con el backend y las APIs de cobro.
# Versión 1.0.2 | 14/02/2025
# Descripción
######  Se implementó la pantalla de bienvenida con animaciones mejoradas.
######  Se agregó un efecto de parpadeo en el texto "Toca para comenzar >" para mayor visibilidad.
###### Se optimizó la gestión de AnimationController evitando errores con TickerProviderStateMixin.
###### Se corrigieron errores relacionados con la inicialización de variables y la estructura de la animación.
###### Se garantizó que la transición a la pantalla de inicio de sesión o código de licencia sea fluida.
## Backend y APIs
###### Se integraron las APIs para el sistema de cobro del estacionamiento.
###### Se optimizó la comunicación entre la app y el backend para manejar los pagos de manera eficiente.
###### Se agregaron endpoints para la validación de licencias y la gestión de usuarios.
###  Cambios técnicos
###### Se usa TickerProviderStateMixin para manejar múltiples AnimationController correctamente.
###### Se eliminó código redundante y mejoró la estructura de inicialización de animaciones.
###### Se corrigió el error de LateInitializationError con _parpadeo.
###### Se configuraron las llamadas a las APIs de cobro dentro del flujo de la aplicación.
### Pruebas realizadas
###### Se verificó que la animación de bienvenida funciona sin errores.
###### Se probó el efecto de parpadeo en el texto.
###### Se confirmó que la navegación entre pantallas se mantiene estable.
###### Se validó la correcta comunicación con el backend y las APIs de cobro.

###### Flutter Mobile App (Android)
###### Implementación de la función "Mostrar/Ocultar Saldo".
###### Rediseño de la pantalla de "Método de Pago" con mejor distribución.
###### Optimización de la navegación entre pantallas con animaciones suaves.
###### Ajustes en la pantalla de "Pagar Voucher" para centrar elementos.
### ##### Mejoras en la Interfaz
###### Ajuste en el tamaño del logo en la pantalla de inicio y home.
###### Mejor distribución de los botones en "Cuenta del Usuario".
###### Ajustes en la fuente y colores de la aplicación para mejor accesibilidad.
# Versión 1.0.1 | 13/02/2025
#### Flutter Mobile App (Android & iOS)
###### Creación de la estructura del proyecto en Flutter con patrón MVC.
###### Implementación de la barra de navegación inferior (Home, Servicios, Perfil).
###### Diseño e integración de las pantallas principales:
###### BienvenidaBienvenida
###### Código de Licencia
###### Inicio de Sesión
###### RegistroRegistro
###### HomeHome
###### ServiciosServicios
###### Cuenta del Usuario
###### Método de Pago
###### Funcionalidad básica de navegación entre pantallas con Navigator.pushNamed().
#### Mejoras en la Interfaz
###### Se añadieron los íconos en el Bottom Navigation Bar.
###### Se integraron botones dinámicos en la pantalla de "Servicios".
###### Ajustes en los tamaños de los títulos para mejorar la legibilidad.
# Versión 1.0.0 | 13/02/2025
###### Versión inicial con estructura base en Flutter.
###### Creación de pantallas y navegación básica.
###### Implementación del diseño inicial para todas las vistas.
### 📂 **Estructura del Proyecto**
###### Controladores: Manejo de la lógica de cada pantalla.
###### Modelos: Definición de las estructuras de datos utilizadas en la app.
###### Servicios: Conexión con APIs y lógica de negocio.
###### Vistas: Contiene las pantallas principales del usuario.
###### Main.dart: Punto de entrada de la aplicación.
###### Rutas.dart: Configuración de navegación entre pantallas.
###### Tema.dart: Configuración de estilos globales.
###### Utilidades: Funciones reutilizables y constantes globales.
### 📱 Funcionalidades Actuales
###### Inicio de Sesión y Registro con validaciones.
###### Pantalla de Home con opciones rápidas como Pagar Voucher, Estacionamientos.
###### Sección de Servicios con botones dinámicos.
###### Método de Pago con selección de tarjetas guardadas.
###### Visualización del saldo disponible y movimientos recientes en la cuenta.
### 🚀 Cómo Ejecutar la Aplicación
#### Clonar el repositorio
git clone https://github.com/tuUsuario/app-estacionamiento.git
#### Ingresar al directorio del proyecto
cd app-estacionamiento
### Instalar dependencias

flutter pub get
### Ejecutar la aplicación

flutter run
(Asegúrate de tener un emulador o dispositivo conectado).
### 🔜 Próximos Pasos
Integración con APIs para autenticación y pagos.
Implementación de escaneo real de QR en la pantalla de "Pagar Voucher".
Persistencia de sesión con SharedPreferences o SQLite.
Optimización de la UI con animaciones y transiciones mejoradas.
### 📜 Licencia
Este proyecto se distribuye bajo la licencia MIT.

### 📞 Contacto y Soporte
Email: jeangamarra1@gmail.com
Repositorio GitHub: GitHub/app-estacionamiento
¡Gracias por contribuir al desarrollo de la App Estacionamiento!
