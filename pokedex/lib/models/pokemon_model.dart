class PokemonModel {
  final int id;
  final String title;
  final String subtitle;
  final String image;

  PokemonModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "subtitle": subtitle,
      "image": image,
    };
  }

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'] ?? -1,
      title: json['title'] ?? "",
      subtitle: json['subtitle'] ?? '',
      image: json['image'] ?? "",
    );
  }
}
