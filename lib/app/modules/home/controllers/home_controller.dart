
import 'package:get/get.dart';

import '../../../data/api_services.dart';

import '../../../models/name_model_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final pokemons = RxList<Pokemon>([]);
  final isLoading = RxBool(false);
  final error = RxString('');




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
    fetchPokemons(10, 0);
  }



  void increment() => count.value++;
}
