import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        brightness: Brightness.light,
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          labelLarge:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          titleLarge: GoogleFonts.outfit(textStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: Colors.black)),
          headlineSmall: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          bodyMedium: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: Colors.black),
          bodySmall: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Colors.black),
          labelSmall: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 13,
              color: Colors.black),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Theme.of(context).colorScheme.onPrimary,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'MapTravel',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.green),
          ),
          elevation: 1,
          shadowColor: Theme.of(context).shadowColor,
        ),
        body: const MainPage(),
      ),
    );
  }
}
