class PokemonModel {
  final String name;
  final String url;

  PokemonModel({required this.name, required this.url});

  factory PokemonModel.fromJson(Map<String, dynamic> myJson) {
    return PokemonModel(name: myJson['name'] ?? '', url: myJson['url'] ?? '');
  }
}
