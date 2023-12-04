import 'package:flutter/material.dart';
import 'package:maptravel/s_main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          labelLarge: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          headlineLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Theme.of(context).primaryColor)
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Theme
              .of(context)
              .colorScheme
              .onPrimary,
          hintStyle: TextStyle(
            color: Colors.green[700],
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'MapTravel',
            style: Theme.of(context).textTheme.headlineLarge
          ),
          elevation: 1,
          shadowColor: Theme
              .of(context)
              .shadowColor,
        ),
        body: const MainPage(),
      ),
    );
  }
}
