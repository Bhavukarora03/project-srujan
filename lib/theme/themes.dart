import 'package:flutter/material.dart';

class MyAppTheme {
  // Define the colors for light mode
  static final lightTheme = ThemeData(
    primaryColor: Colors.black,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.black),
      hintStyle: TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    ),
    scaffoldBackgroundColor: Colors.green.shade100,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      // Your body text color for light mode
      bodyMedium: TextStyle(color: Colors.black),
      // Your body text color for light mode
      titleLarge: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
      titleSmall: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
  );

  // Define the colors for dark mode
  static final darkTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.black),
      hintStyle: TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    ),
    scaffoldBackgroundColor: Colors.green.shade100,
    primaryColor: Colors.black,
    // Your background color for dark mode
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white), // Your body text color for dark mode
      bodyMedium: TextStyle(color: Colors.white), // Your body text color for dark mode
      titleLarge: TextStyle(color: Colors.white), // Your headline text color for dark mode
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );
}
