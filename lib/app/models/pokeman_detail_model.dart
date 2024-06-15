import 'package:hive/hive.dart';
part 'pokeman_detail_model.g.dart';
@HiveType(typeId: 1)
class PokemanDetais {
  @HiveField(0)
  String name;
  @HiveField(1)
  String image;
  @HiveField(2)
  List types;
  @HiveField(3)
  List base_stats;
  @HiveField(4)
  int height;
  @HiveField(5)
  int weight;
  @HiveField(6)
  int id;


  PokemanDetais({
    required this.name,
    required this.id,
    required this.image,
    required this.types,
    required this.height,
    required this.weight,
    required this.base_stats,

  });
  factory PokemanDetais.fromJson(Map<String, dynamic> json) {
    return PokemanDetais(
      name: json['name'],
      id: json['id'],
      image: json['sprites']['other']['official-artwork']['front_default'],
      types: json['types'],
      base_stats: json['stats'],
      height: json['height'],
      weight: json['weight'],

    );
  }
}

class PokemonType {
  int slot;
  Type type;

  PokemonType({
    required this.slot,
    required this.type,
  });

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      slot: json['slot'],
      type: Type.fromJson(json['type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slot': slot,
      'type': type.toJson(),
    };
  }
}

class Type {
  String name;
  String url;

  Type({
    required this.name,
    required this.url,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}

