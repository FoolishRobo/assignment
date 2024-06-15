import 'package:hive/hive.dart';
part 'name_model_model.g.dart';
@HiveType(typeId: 2)
class Pokemon {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  Pokemon({required this.id, required this.name});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['url'],
      name: json['name'],
    );
  }
}
