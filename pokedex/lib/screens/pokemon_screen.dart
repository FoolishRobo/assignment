import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/data_sources/local/data.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/services/sql_service.dart';
import 'package:pokedex/widgets/single_stats_widget.dart';
import 'package:pokedex/widgets/weight_widget.dart';

class PokemonScreen extends StatefulWidget {
  final String id;
  const PokemonScreen({
    super.key,
    required this.id,
  });

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  var pokemonData;
  PokemonModel? pokemonModel;
  var types = '';
  var avg;
  bool isLoading = false;
  bool isFavourite = false;
  @override
  void initState() {
    super.initState();
    getPokemonData();
  }

  getTypes() async {
    final pokemons = favPokemons;
    if (pokemonData['types'] != null) {
      for (var i = 0; i < pokemonData['types']?.length; i++) {
        types =
            '$types${i == 0 ? '' : ','}${pokemonData['types'][i]['type']['name']}';
      }
    }
    setState(() {});
    pokemonModel = PokemonModel(
      id: int.tryParse(widget.id) ?? -1,
      title: pokemonData['name'],
      subtitle: types,
      image: pokemonData['sprites']['front_default'],
    );
    setState(() {});
    final p = pokemons.where((p) => p.id == int.tryParse(widget.id)).toList();
    if (p.isNotEmpty) {
      isFavourite = true;
    } else {
      isFavourite = false;
    }

    setState(() {});
    print(isFavourite);
  }

  getPokemonData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(
        Uri.parse(
          'https://pokeapi.co/api/v2/pokemon/${widget.id}',
        ),
      );
      if (response.statusCode == 200) {
        pokemonData = await json.decode(response.body);
        avg = pokemonData['stats'][0]['base_stat'] +
            pokemonData['stats'][1]['base_stat'] +
            pokemonData['stats'][2]['base_stat'] +
            pokemonData['stats'][3]['base_stat'] +
            pokemonData['stats'][4]['base_stat'] +
            pokemonData['stats'][5]['base_stat'];
        await getTypes();
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Error Occured",
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  checkData(PokemonModel pokemon) async {
    setState(() {
      isLoading = true;
    });
    final sqlService = SqlService.instance;
    List fav = await sqlService.queryAll();
    if (fav.contains(pokemon)) {
      await sqlService.delete(pokemon.id);
      favPokemons.remove(pokemon);
      isFavourite = false;
    } else {
      await sqlService.insert(pokemon);
      favPokemons.add(pokemon);
      isFavourite = true;
    }
    // int count = widget.count;
    // final sf = await SharedPreferences.getInstance();
    // if (ids.contains(widget.id.toString())) {
    //   await sf.remove(widget.id);
    //   await sf.setInt('idc', count - 1);
    //   ids.remove(widget.id.toString());
    //   names.remove(pokemonData['name']);
    //   type.remove(types);
    //   images.remove(pokemonData['sprites']['front_default']);
    //   setState(() {
    //     isFavourite = false;
    //     isLoading = false;
    //   });
    // } else {
    //   await sf.setString(widget.id, widget.id);
    //   await sf.setInt('idc', count + 1);
    //   ids.add(widget.id.toString());
    //   names.add(pokemonData['name']);
    //   type.add(types);
    //   images.add(pokemonData['sprites']['front_default']);
    //   setState(() {
    //     isFavourite = true;
    //     isLoading = false;
    //   });
    // }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Image.asset(
                  'assets/images/back_color.png',
                  height: 200 + kToolbarHeight,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: kToolbarHeight),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'assets/images/back.png',
                      height: 200,
                      width: 176,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 150,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            pokemonData['name'],
                                            style: const TextStyle(
                                              color:
                                                  Color.fromRGBO(22, 26, 51, 1),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 32,
                                            ),
                                          ),
                                          Text(
                                            types,
                                            style: const TextStyle(
                                              color:
                                                  Color.fromRGBO(22, 26, 51, 1),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 40,
                                            ),
                                            child: Text(
                                              widget.id.toString(),
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    22, 26, 51, 1),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Image.network(
                                    pokemonData['sprites']['front_default'],
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: 150,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                WeightWidget(
                                  type: 'Height',
                                  value: pokemonData['height'].toString(),
                                ),
                                WeightWidget(
                                  type: 'Weight',
                                  value: pokemonData['weight'].toString(),
                                ),
                                WeightWidget(
                                  type: 'BMI',
                                  value: ((pokemonData['weight'] as int) /
                                          sqrt(pokemonData['height'] as int))
                                      .toString()
                                      .substring(0, 4),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              height: 8,
                              color: const Color.fromRGBO(0, 0, 0, 0.05),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              child: Text(
                                'Base stats',
                                style: TextStyle(
                                  color: Color.fromRGBO(22, 26, 51, 1),
                                ),
                              ),
                            ),
                            Container(
                              height: 4,
                              color: const Color.fromRGBO(0, 0, 0, 0.05),
                            ),
                            SingleStatsWidget(
                              type: 'Hp',
                              value: pokemonData['stats'][0]['base_stat'],
                              color: const Color.fromRGBO(205, 40, 115, 1),
                            ),
                            SingleStatsWidget(
                              type: 'Attack',
                              value: pokemonData['stats'][1]['base_stat'],
                              color: const Color.fromRGBO(205, 40, 115, 1),
                            ),
                            SingleStatsWidget(
                              type: 'Defense',
                              value: pokemonData['stats'][2]['base_stat'],
                              color: const Color.fromRGBO(205, 40, 115, 1),
                            ),
                            SingleStatsWidget(
                              type: 'Special Attack',
                              value: pokemonData['stats'][3]['base_stat'],
                              color: const Color.fromRGBO(238, 194, 24, 1),
                            ),
                            SingleStatsWidget(
                              type: 'Special Defense',
                              value: pokemonData['stats'][4]['base_stat'],
                              color: const Color.fromRGBO(238, 194, 24, 1),
                            ),
                            SingleStatsWidget(
                              type: 'Speed',
                              value: pokemonData['stats'][5]['base_stat'],
                              color: const Color.fromRGBO(205, 40, 115, 1),
                            ),
                            SingleStatsWidget(
                              type: 'Avg. Power',
                              value: avg! ~/ 6,
                              color: const Color.fromRGBO(205, 40, 115, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
      floatingActionButton: isFavourite
          ? Padding(
              padding: const EdgeInsets.only(
                bottom: 30,
              ),
              child: FloatingActionButton.extended(
                backgroundColor: const Color.fromRGBO(213, 222, 255, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
                onPressed: () => checkData(pokemonModel!),
                label: const Text(
                  'Remove from favourites',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color.fromRGBO(53, 88, 205, 1),
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(
                bottom: 30,
              ),
              child: FloatingActionButton.extended(
                backgroundColor: const Color.fromRGBO(53, 88, 205, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
                onPressed: () => checkData(pokemonModel!),
                label: const Text(
                  'Mark as favourite',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
            ),
    );
  }
}
