import 'package:flutter/material.dart';

const Color bgColor = Color(0xFF0a0f2c);
const Color accentColor = Color(0xFF00cfff);
const Color textColor = Color(0xFFe0f7ff);

final ThemeData spaceTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: bgColor,
  fontFamily: 'Orbitron',
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      color: accentColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
    ),
    bodyMedium: TextStyle(
      color: textColor,
      fontSize: 16,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      side: const BorderSide(color: accentColor, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      foregroundColor: accentColor,
      shadowColor: accentColor.withOpacity(0.5),
      elevation: 10,
      textStyle: const TextStyle(
        fontFamily: 'Exo2',
        fontWeight: FontWeight.bold,
        fontSize: 18,
        letterSpacing: 1.2,
      ),
    ),
  ),
);

