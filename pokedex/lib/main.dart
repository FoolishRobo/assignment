import 'package:flutter/material.dart';
import 'package:pokedex/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Noto Sans',
        appBarTheme: const AppBarTheme(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      home: const SplashScreen(),
    );
  }
}
