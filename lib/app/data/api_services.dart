import 'package:assignment/app/models/name_model_model.dart';
import 'package:assignment/app/models/pokeman_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiService {
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  static Future<List<Pokemon>> fetchPokemonsname(int limit, int offset) async {
    final dio = Dio(); // Create a Dio instance
    final url = '$baseUrl/pokemon?limit=$limit&offset=$offset';
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final results = response.data['results'] as List;
        return results.map((json) => Pokemon.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch pokemons');
      }
    } on DioException catch (e) {
      throw Exception('API error: ${e.message}');
    }
  }

  static Future<List<PokemanDetais>> fetchAllPokemonDetails(
      RxList pokemons) async {
    List<PokemanDetais> allPokemonDetails = [];
    for (var pokemon in pokemons) {
      PokemanDetais details = await ApiService.fetchPokemon(pokemon.name);

      allPokemonDetails.add(details);
    }
    return allPokemonDetails;
  }

  static Future<List<PokemanDetais>> fetchfavPokemonDetails(
      List pokemons) async {
    List<PokemanDetais> allPokemonDetails = [];
    for (var pokemon in pokemons) {
      PokemanDetais details = await ApiService.fetchPokemon(pokemon);

      allPokemonDetails.add(details);
    }
    return allPokemonDetails;
  }

  static Future<PokemanDetais> fetchPokemon(String name) async {
    final dio = Dio(); // Create a Dio instance
    final url = 'https://pokeapi.co/api/v2/pokemon/$name';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        return PokemanDetais.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch pokemon');
      }
    } on DioException catch (e) {
      throw Exception('API error: ${e.message}');
    }
  }
}
