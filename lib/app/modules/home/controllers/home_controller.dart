import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api_services.dart';
import '../../../models/name_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final pokemons = RxList<Pokemon>([]);
  final isLoading = RxBool(false);
  final error = RxString('');
  Color getTypeColor(List<dynamic> list) {
  if (list.isNotEmpty && list[0].containsKey('type') && list[0]['type'].containsKey('name')) {
    String typeName = list[0]['type']['name'];
    switch (typeName) {
      case 'fire':
        return Color(0xffFDF1F1);
      case 'grass':
        return Color(0xffF3F9EF);
      case 'water':
        return Color(0xffF3F9FE);
      default:
        return Colors.black26;
    }
  } else {
    return Colors.black26; // default color if the list is empty or keys are missing
  }
}
String getbgImage(String type) {
  switch (type) {
      case 'fire':
        return 'assets/images/fb.png';
      case 'grass':
        return 'assets/images/gb.png';
      case 'water':
        return 'assets/images/wb.png';
      default:
        return 'assets/images/gb.png';
    }
}
int calculateTotalBaseStat(List<dynamic> stats) {
  int total = 0;
  for (var stat in stats) {
    total += (stat["base_stat"] as int); // Cast to int
  }
  return total;
}
  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  double calculatebmi(double heightFeet, double weightKg) {
    double heightMeters = heightFeet * 0.3048;
    double bmi = weightKg / (heightMeters * heightMeters);

    return bmi;
  }

  String formatNumberWithLeadingZeros(int number, int width) {
    return number.toString().padLeft(width, '0');
  }

  Future<void> fetchPokemons(int limit, int offset) async {
    isLoading.value = true;
    error.value = '';

    try {
      final newPokemons = await ApiService.fetchPokemonsname(limit, offset);
      pokemons.value.addAll(newPokemons);
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchPokemons(9, 0);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
