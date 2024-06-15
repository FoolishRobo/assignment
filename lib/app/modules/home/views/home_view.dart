import 'package:assignment/app/modules/home/views/pages/Homewidgets/poki_grid_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/api_services.dart';
import '../controllers/home_controller.dart';
import '../../../models/pokeman_detail_model.dart';
import 'pages/Homewidgets/grid_shimmer_view.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  @override
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8E8E8),
      body: Obx(() => controller.isLoading.value == true
          ? const Center(child: GridShimmerView())
          : FutureBuilder<List<PokemanDetais>>(
              future: ApiService.fetchAllPokemonDetails(controller.pokemons),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const GridShimmerView();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Pokémon data found'));
                } else {
                  List<PokemanDetais> allPokemonDetails = snapshot.data!;
                  return PokiGridView(
                    allPokemonDetails: allPokemonDetails,
                  );
                }
              },
            )),
    );
  }
}
