import 'package:finish_up_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/router.dart';

//import 'core/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //Colors.black as material Color for primary swatch
      theme: ThemeData(
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
        fontFamily: 'Kumbh',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Color(0xFF111111),
          ),
          headlineLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111111),
          ),
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
      ),
      routerConfig: appRouter,
    );
  }
}
