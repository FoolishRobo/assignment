
import 'package:assignment/app/modules/home/views/pages/Homewidgets/grid_shimmer_view.dart';
import 'package:assignment/app/modules/home/views/pages/Homewidgets/poki_grid_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../data/api_services.dart';
import '../../../models/pokeman_detail_model.dart';

class FavoritesView extends GetView {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Hive.box('MyFavorites').listenable(),
        builder: (context, box, widget) {
          print(box.name);
          print(box.keys.toList());



          // pokemons.value = jsonDecode(box.keys);

            return FutureBuilder<List<PokemanDetais>>(
            future: ApiService.fetchfavPokemonDetails(box.keys.toList()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const GridShimmerView();
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No Pokémon Added'));
              } else {
                List<PokemanDetais> allPokemonDetails = snapshot.data!;
                return PokiGridView(
                  allPokemonDetails: allPokemonDetails,
                );
              }
            },
          );

        },
      ),
    );
  }
}
