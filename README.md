# rick_and_morty_app

# Flutter Clean Architecture with BLoC

Este es un proyecto de ejemplo que utiliza Flutter, Clean Architecture y el patrón BLoC para gestionar el estado. La aplicación muestra personajes de la serie "Rick and Morty" utilizando la API pública de Rick and Morty.

## Contenido

- [Características](#características)
- [Tecnologías Utilizadas](#tecnologías-utilizadas)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Instalación](#instalación)
- [Uso](#uso)
- [Arquitectura Limpia](#arquitectura-limpia)
- [BLoC](#bloc)
- [Contribuciones](#contribuciones)

## Características

- Carga de personajes desde la API de Rick and Morty.
- Navegación entre pantallas utilizando `GoRouter`.
- Implementación del patrón BLoC para la gestión del estado.
- Inyección de dependencias utilizando `GetIt`.

## Tecnologías Utilizadas

- [Flutter](https://flutter.dev)
- [Dart](https://dart.dev)
- [BLoC](https://bloclibrary.dev)
- [GetIt](https://pub.dev/packages/get_it)
- [Dio](https://pub.dev/packages/dio) (para realizar peticiones HTTP)
- [GoRouter](https://pub.dev/packages/go_router) (para la navegación)

## Estructura del Proyecto

-[Data]: Maneja la obtención de datos, incluyendo la comunicación con APIs externas y la gestión de modelos de datos.
-[Domain]: Contiene la lógica de negocio, incluyendo entidades y repositorios. Aquí se definen las reglas del negocio sin depender de las implementaciones concretas.
-[Presentation]: Se encarga de la UI y de la interacción con el usuario, utilizando el patrón BLoC para manejar el estado.