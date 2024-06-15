import 'package:assignment/app/modules/home/views/poki_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/api_services.dart';
import '../controllers/home_controller.dart';
import '../pokeman_detail_model.dart';
import 'detailsview_view.dart';
import 'grid_shimmer_view.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE8E8E8),
      body: Obx(() => controller.isLoading.value == true
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<List<PokemanDetais>>(
              future: ApiService.fetchAllPokemonDetails(controller.pokemons),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return GridShimmerView();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No Pokémon data found'));
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
