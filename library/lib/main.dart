import 'package:flutter/material.dart';
import 'package:movies/screens/feature_slide_screen.dart';
import 'package:movies/screens/login_screen.dart';
import 'package:movies/screens/splash_screen.dart';
import 'screens/book_selection_screen.dart';
import 'theme/book_app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Đọc Sách Premium App',
      debugShowCheckedModeBanner: false,
      
      theme: AppBookTheme.lightTheme,
      darkTheme: AppBookTheme.darkTheme,
      themeMode: ThemeMode.system,
      
      home: const FeatureSlideScreen(),
    );
  }
}
