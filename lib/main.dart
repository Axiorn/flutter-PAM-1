import 'package:flutter/material.dart';
import 'pages/calculator.dart';
import 'pages/history.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          bodySmall: TextStyle(fontSize: 16, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 20, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 28, color: Colors.white),
          headlineSmall: TextStyle(fontSize: 16, color: Colors.white),
          headlineMedium: TextStyle(fontSize: 18, color: Colors.white),
          headlineLarge: TextStyle(fontSize: 28, color: Colors.white),
          labelMedium: TextStyle(fontSize: 18, color: Colors.white60),
        ),
        scaffoldBackgroundColor: Color(0xff090909),
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.blue,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CalculatorApp(),
        '/history': (context) => History(),
      },
    );
  }
}
