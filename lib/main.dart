import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/config/router/app_router.dart';

import 'di/injection_container.dart';

void main() async {
  init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rick and Morty App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, useMaterial3: true),
      routerConfig: appRouter
    );
  }
}