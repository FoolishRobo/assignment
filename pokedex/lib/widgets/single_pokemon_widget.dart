import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class SinglePokemonWidget extends StatefulWidget {
  final String id;
  final String title;
  final String? img;

  VoidCallback onTap;
  SinglePokemonWidget({
    super.key,
    required this.id,
    required this.title,
    required this.onTap,
    this.img,
  });

  @override
  State<SinglePokemonWidget> createState() => _SinglePokemonWidgetState();
}

class _SinglePokemonWidgetState extends State<SinglePokemonWidget> {
  var pokemonData;
  var types = '';
  var avg;
  bool isLoading = false;
  @override
  void initState() {
    getPokemonData();
    super.initState();
  }

  getTypes() {
    if (pokemonData['types'] != null) {
      print(pokemonData['types']);
      for (var i = 0; i < pokemonData['types']?.length; i++) {
        types =
            '$types${i == 0 ? '' : ','}${pokemonData['types'][i]['type']['name']}';
      }
    }
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
        getTypes();
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        color: const Color.fromRGBO(243, 249, 239, 1),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    fit: BoxFit.cover,
                    widget.img ?? pokemonData['sprites']['front_default'],
                    height: MediaQuery.of(context).size.width * 0.3,
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      widget.id,
                      style: const TextStyle(
                        color: Color.fromRGBO(107, 107, 107, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.87),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      types,
                      style: const TextStyle(
                        color: Color.fromRGBO(107, 107, 107, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
