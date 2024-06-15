import 'package:dio/dio.dart';

import '../models/name_model.dart';
import '../modules/home/pokeman_detail_model.dart';

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
    } on DioError catch (e) {
      throw Exception('API error: ${e.message}');
    }
  }
}
