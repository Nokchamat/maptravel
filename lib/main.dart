import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/common/secure_storage/secure_strage.dart';
import 'package:maptravel/s_main_page.dart';

import 'api/common.dart';

void refreshTokenPeriodically() async {
  print('[refreshTokenPeriodically] 초기 토큰 갱신 : ${DateTime.now()}');
  String? refreshToken = await getRefreshToken();
  if (refreshToken != null) {
    http.Response response = await http.get(
      Uri.parse('$baseUrl/v1/token/refresh'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "refresh_token": refreshToken,
      },
    );

    if (response.statusCode == 200) {
      print(
          '[refreshTokenPeriodically] accessToken : ${response.headers['access_token']}');
      print(
          '[refreshTokenPeriodically] refreshToken : ${response.headers['refresh_token']}');
      savedRefreshToken(
        response.headers['access_token']!,
        response.headers['refresh_token']!,
      );
    } else {
      //이동
    }
  }

  Timer.periodic(const Duration(minutes: 50), (Timer timer) async {
    print('[refreshTokenPeriodically] 토큰 갱신 실행 : ${DateTime.now()}');

    String? refreshToken = await getRefreshToken();
    if (refreshToken != null) {
      http.Response response = await http.get(
        Uri.parse('$baseUrl/v1/token/refresh'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "refresh_token": refreshToken,
        },
      );

      if (response.statusCode == 200) {
        print(
            '[refreshTokenPeriodically] accessToken : ${response.headers['access_token']}');
        print(
            '[refreshTokenPeriodically] refreshToken : ${response.headers['refresh_token']}');
        savedRefreshToken(
          response.headers['access_token']!,
          response.headers['refresh_token']!,
        );
      }
    }
    print('[refreshTokenPeriodically] 토큰 갱신 종료 : ${DateTime.now()}');
  });
}

void main() {
  runApp(const MyApp());
  refreshTokenPeriodically();
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
          titleLarge: GoogleFonts.outfit(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Colors.black)),
          headlineMedium: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: Colors.black,
                offset: Offset(1.0, 1.0),
              )
            ]
          ),
          headlineSmall: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          bodyMedium: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: 20, color: Colors.black),
          bodySmall: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black),
          labelSmall: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: 13, color: Colors.black),
          labelMedium: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black),
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
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.green),
          ),
          elevation: 1,
          shadowColor: Theme.of(context).shadowColor,
        ),
        body: const MainPage(),
      ),
    );
  }
}
