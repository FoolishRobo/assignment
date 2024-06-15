
import 'package:assignment/app/data/app_images.dart';
import 'package:flutter/material.dart';

import '../models/pokeman_detail_model.dart';

class AppUtils {
  static Color getTypeColor(List<dynamic> list) {
    if (list.isNotEmpty &&
        list[0].containsKey('type') &&
        list[0]['type'].containsKey('name')) {
      String typeName = list[0]['type']['name'];
      switch (typeName) {
        case 'fire':
          return const Color(0xffFDF1F1);
        case 'grass':
          return const Color(0xffF3F9EF);
        case 'water':
          return const Color(0xffF3F9FE);
        default:
          return Colors.black26;
      }
    } else {
      return Colors
          .black26; // default color if the list is empty or keys are missing
    }
  }

  static String getbgImage(String type) {
    switch (type) {
      case 'fire':
        return AppImages.fb;
      case 'grass':
        return AppImages.gb;
      case 'water':
        return AppImages.wb;
      default:
        return AppImages.wb;
    }
  }

  static int calculateTotalBaseStat(List<dynamic> stats) {
    int total = 0;
    for (var stat in stats) {
      total += (stat["base_stat"] as int); // Cast to int
    }
    return total;
  }

  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  static double calculatebmi(double heightFeet, double weightKg) {
    double heightMeters = heightFeet * 0.3048;
    double bmi = weightKg / (heightMeters * heightMeters);

    return bmi;
  }

  static String formatNumberWithLeadingZeros(int number, int width) {
    return number.toString().padLeft(width, '0');
  }

  static List<Widget> generateTypeTextList(BuildContext context, List types) {
    return List.generate(types.length, (index) {
      PokemonType pokimantype = PokemonType.fromJson(types[index]);
      return Text(
        '${AppUtils.capitalizeFirstLetter(pokimantype.type.name)}${index == 0 && types.length > 1 ? "," : ""} ',
        style: Theme.of(context).textTheme.displayMedium,
      );
    });
  }

  static List<Widget> generateTypeTextListCard(
      BuildContext context, List types) {
    return List.generate(types.length, (index) {
      PokemonType pokimantype = PokemonType.fromJson(types[index]);
      return Text(
        '${AppUtils.capitalizeFirstLetter(pokimantype.type.name)}${index == 0 && types.length > 1 ? "," : ""} ',
        style: Theme.of(context).textTheme.titleMedium,
      );
    });
  }
}
