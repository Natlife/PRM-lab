import 'package:flutter/material.dart';

enum ReadingMode {
  light,
  dark,
  sepia,
  green,
}

class ReaderTheme {
  final Color backgroundColor;
  final Color textColor;
  final Color accentColor;
  final String name;

  const ReaderTheme({
    required this.backgroundColor,
    required this.textColor,
    required this.accentColor,
    required this.name,
  });
}

class AppBookTheme {
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFFFF6584);
  static const Color darkBackgroundColor = Color(0xFF0F0E17);
  static const Color lightBackgroundColor = Color(0xFFF9F9FB);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      background: lightBackgroundColor,
      primary: primaryColor,
      secondary: secondaryColor,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: lightBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF2E2E3A)),
      titleTextStyle: TextStyle(
        color: Color(0xFF2E2E3A),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2E2E3A)),
      bodyMedium: TextStyle(color: Color(0xFF5E5E6E)),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      background: darkBackgroundColor,
      primary: primaryColor,
      secondary: secondaryColor,
      surface: const Color(0xFF1A1824),
    ),
    scaffoldBackgroundColor: darkBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      bodyMedium: TextStyle(color: Color(0xFFA5A5B5)),
    ),
  );

  static const Map<ReadingMode, ReaderTheme> readerThemes = {
    ReadingMode.light: ReaderTheme(
      backgroundColor: Color(0xFFFFFFFC),
      textColor: Color(0xFF1A1A1A),
      accentColor: primaryColor,
      name: 'Sáng',
    ),
    ReadingMode.dark: ReaderTheme(
      backgroundColor: Color(0xFF121214),
      textColor: Color(0xFFE1E1E6),
      accentColor: Colors.amber,
      name: 'Tối',
    ),
    ReadingMode.sepia: ReaderTheme(
      backgroundColor: Color(0xFFF7F0E3),
      textColor: Color(0xFF4A3B32),
      accentColor: Colors.brown,
      name: 'Giấy cũ',
    ),
    ReadingMode.green: ReaderTheme(
      backgroundColor: Color(0xFFE8F5E9),
      textColor: Color(0xFF1B5E20),
      accentColor: Colors.teal,
      name: 'Dịu mắt',
    ),
  };
}
