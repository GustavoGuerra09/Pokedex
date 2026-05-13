class DetailsPokemonModel {
  final int height;
  final int id;
  final String name;
  final int weight;

  DetailsPokemonModel({
    required this.height,
    required this.id,
    required this.name,
    required this.weight
  });

  factory DetailsPokemonModel.fromJson(Map<String, dynamic> json) {
    return DetailsPokemonModel(
      height: json['height'],
      id: json['id'],
      name: json['name'],
      weight: json['weight']
    );
  }
}
