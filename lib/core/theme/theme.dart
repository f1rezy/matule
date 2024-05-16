import 'package:flutter/material.dart';

const primaryColor = Color(0xFF48B2E7);

final themeData = ThemeData(
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  useMaterial3: true,
  fontFamily: 'Raleway',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
        color: Color(0xFF707B81)),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
        color: Color(0xFF6A6A6A)),
    labelMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF6A6A6A)),
    labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
        color: Color(0xFF707B81)),
  ),
  filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
);
