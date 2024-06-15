import 'package:flutter/material.dart';
import 'package:pokedex/screens/all_pokemons_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToAllPokemonsScreen();
  }

  navigateToAllPokemonsScreen() async {
    Future.delayed(const Duration(seconds: 3)).then(
      (v) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AllPokemonsScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(53, 88, 205, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
      ),
    );
  }
}
