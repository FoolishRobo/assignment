class PokemonStat {
  final int baseStat;
  final int effort;
  final Stat stat;

  PokemonStat(
      {required this.baseStat, required this.effort, required this.stat});

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    return PokemonStat(
      baseStat: json['base_stat'],
      effort: json['effort'],
      stat: Stat.fromJson(json['stat']),
    );
  }
}

class Stat {
  final String name;
  final String url;

  Stat({required this.name, required this.url});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      name: _formatStatName(json['name']),
      url: json['url'],
    );
  }
  static String _formatStatName(String name) {
    // Convert snake case to title case
    return name.split('-').map((word) => word.capitalize()).join(' ');
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}


