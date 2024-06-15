class Pokemon {
  final String url;
  final String name;

  Pokemon({required this.url, required this.name});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      url: json['url'],
      name: json['name'],
    );
  }
}
