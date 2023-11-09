import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maptravel/s_main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF236F38),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color(0xFFBFDEA8),
          onPrimaryContainer: Color(0xFF142514),
          secondary: Color(0xFF52634F),
          onSecondary: Color(0xFFFFFFFF),
          secondaryContainer: Color(0xFFD5E8CF),
          onSecondaryContainer: Color(0xFF111F0F),
          tertiary: Color(0xFF38656A),
          onTertiary: Color(0xFFFFFFFF),
          tertiaryContainer: Color(0xFFBCEBF0),
          onTertiaryContainer: Color(0xFF002023),
          surface: Color(0xFFFCFDF6),
          onSurface: Color(0xFF1A1C19),
          surfaceVariant: Color(0xFFDEE5D8),
          onSurfaceVariant: Color(0xFF424940),
          surfaceTint: Color(0xFF006E1C),
          outline: Color(0xFF72796F),
          outlineVariant: Color(0xFFC2C9BD),
          inverseSurface: Color(0xFF2F312D),
          onInverseSurface: Color(0xFFF0F1EB),
          inversePrimary: Color(0xFF7EDB7B),
          background: Color(0xFFFCFDF6),
          onBackground: Color(0xFF1A1C19),
          scrim: Color(0xFF000000),
          shadow: Color(0xFF000000),
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MapTravel'),
        ),
        body: const MainPage(),
      ),
    );
  }
}
