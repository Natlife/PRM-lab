import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PRM API Companion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        primaryColor: const Color(0xFFCBA6F7),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFCBA6F7),
          brightness: Brightness.dark,
        ),
      ),
      home: const MainScreen(),
    );
  }
}
