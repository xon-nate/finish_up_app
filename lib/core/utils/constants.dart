import 'package:flutter/material.dart';

ThemeData myLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: Colors.white,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF111111),
    elevation: 15,
  ),
  cardTheme: const CardTheme(
    color: Colors.white,
    surfaceTintColor: Color(0xFFF5F6F7),
    elevation: 20,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  ),
  listTileTheme: const ListTileThemeData(
    titleTextStyle: TextStyle(
      fontFamily: 'Kumbh',
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: Color(0xFF111111),
    ),
    tileColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      elevation: MaterialStateProperty.all(15),
      surfaceTintColor: MaterialStateProperty.all(
        Colors.transparent,
      ),
    ),
  ),
  fontFamily: 'Kumbh',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 30,
      fontFamily: 'Kumbh',
      fontWeight: FontWeight.w900,
    ),
    headlineLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Color(0xFF111111),
    ),
    bodyMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(
        color: Color(0xFF111111),
      ),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
    filled: true,
    fillColor: Color(0xFFF5F6F7),
    hintStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF111111),
    ),
  ),
  dialogTheme: const DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    backgroundColor: Color(0xFFF3F3F3),
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.black,
    titleTextStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.black, // Adjust text color as needed
    ),
    contentTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.black, // Adjust text color as needed
    ),
    elevation: 12,
    actionsPadding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  ),
  datePickerTheme: const DatePickerThemeData(
    backgroundColor: Color(0xFFF3F3F3),
    surfaceTintColor: Colors.transparent,
  ),
  timePickerTheme: const TimePickerThemeData(
    backgroundColor: Color(0xFFF3F3F3),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    elevation: 12,
    modalBackgroundColor: Colors.white,
    modalElevation: 12,
    clipBehavior: Clip.antiAlias,
  ),
  colorScheme: ColorScheme.fromSwatch(
      primarySwatch: const MaterialColor(
    0xFF111111, // The primary color value
    <int, Color>{
      50: Color(0xFFF6F6F6), // Lighter shade
      100: Color(0xFFE5E5E5),
      200: Color(0xFFD4D4D4),
      300: Color(0xFFC2C2C2),
      400: Color(0xFFB1B1B1),
      500: Color(0xFF111111), // Middle shade (unchanged)
      600: Color(0xFF090909),
      700: Color(0xFF080808),
      800: Color(0xFF070707),
      900: Color(0xFF060606), // Darkest shade
    },
  )).copyWith(
    error: Colors.red,
    secondary: Colors.black,
  ),
);
