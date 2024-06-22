import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/data_sources/local/data.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/screens/pokemon_screen.dart';
import 'package:pokedex/services/sql_service.dart';
import 'package:pokedex/widgets/single_pokemon_widget.dart';

class AllPokemonsScreen extends StatefulWidget {
  const AllPokemonsScreen({super.key});

  @override
  State<AllPokemonsScreen> createState() => _AllPokemonsScreenState();
}

class _AllPokemonsScreenState extends State<AllPokemonsScreen> {
  bool isFavourite = false;
  List pokemons = [];
  List<PokemonModel> favourites = [];
  bool isLoadingMore = false;
  bool isLoading = false;
  int c = 0;
  var previous;
  int countOfPagesLoaded = 0;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController = ScrollController()..addListener(_onScrolledMore);
    fetchPokemons();
    setFavourites();
    super.initState();
  }

  setFavourites() async {
    final sqlService = SqlService.instance;
    favourites = await sqlService.queryAll();
    favPokemons = favourites;
    print(favourites);
    setState(() {});
  }

  Future<void> fetchPokemons() async {
    final sqlService = SqlService.instance;
    await sqlService.initDb();
    if (pokemons.isNotEmpty) return;
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.parse(
        'https://pokeapi.co/api/v2/pokemon/?limit=500',
      ),
    );
    if (response.statusCode == 200) {
      previous = await json.decode(response.body)['results'];
      pokemons = pokemons + await json.decode(response.body)['results'];
      countOfPagesLoaded++;
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Some Error Occured'),
        ),
      );
    }
  }

  void _onScrolledMore() async {
    print('Entered');
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      final response = await http.get(
        Uri.parse(
          previous['next'],
        ),
      );

      if (response.statusCode == 200) {
        final pokemonNewData = await json.decode(response.body)['results'];
        pokemons.addAll(pokemonNewData);
        countOfPagesLoaded++;
        print(countOfPagesLoaded);
        setState(() {
          isLoadingMore = false;
        });
      } else {
        setState(() {
          isLoadingMore = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Some Error Occured'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/pokedex_header.png',
          width: 140,
          height: 40,
        ),
      ),
      body: Column(
        children: [
          const Divider(
            height: 2,
            color: Color.fromRGBO(0, 0, 0, 0.05),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (isFavourite) {
                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  }
                },
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'All Pokemons',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: isFavourite
                                ? const Color.fromRGBO(107, 107, 107, 1)
                                : const Color.fromRGBO(22, 26, 51, 1),
                          ),
                        ),
                      ),
                      Container(
                        height: 5,
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                          color: isFavourite == false
                              ? const Color.fromRGBO(53, 88, 205, 1)
                              : Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (isFavourite == false) {
                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  }
                },
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            Text(
                              'Favourites  ',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: isFavourite == false
                                    ? const Color.fromRGBO(107, 107, 107, 1)
                                    : const Color.fromRGBO(22, 26, 51, 1),
                              ),
                            ),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor:
                                  const Color.fromRGBO(53, 88, 205, 1),
                              child: Text(
                                favourites.length.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 5,
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                          color: isFavourite
                              ? const Color.fromRGBO(53, 88, 205, 1)
                              : Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height - size.height * 0.2,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 200,
              ),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              controller: scrollController,
              itemCount: isFavourite
                  ? favourites.length
                  : isLoadingMore
                      ? pokemons.length + 1
                      : pokemons.length,
              itemBuilder: (context, index) {
                return isFavourite
                    ? SinglePokemonWidget(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PokemonScreen(
                              id: favourites[index].id.toString(),
                            ),
                          ),
                        ),
                        id: favourites[index].id.toString(),
                        title: favourites[index].title,
                        img: favourites[index].image,
                      )
                    : index < pokemons.length
                        ? SinglePokemonWidget(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PokemonScreen(
                                  id: (index + 1).toString(),
                                ),
                              ),
                            ),
                            id: (index + 1).toString(),
                            title: pokemons[index]['name'],
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
              },
            ),
          ),
        ],
      ),
    );
  }
}
