import 'package:flutter/material.dart';
import 'package:personalizado/models/detalhes_do_pokemon_model/detalhes_do_pokemon_model.dart';
import 'package:personalizado/widgets/detalhes_do_pokemon_page/card_pokemon.dart';

class DetalhesDoPokemon extends StatelessWidget {
  final DetailsPokemonModel pokemonModel;
  const DetalhesDoPokemon({
    required this.pokemonModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CardPokemon(conteudoCard: 'ID do pokemon: ${pokemonModel.id.toString()} '),
            Divider(),
            CardPokemon(conteudoCard: 'Altura do pokemon: ${pokemonModel.height.toString()} m'),
            Divider(),
            CardPokemon(conteudoCard: 'Nome do pokemon: ${pokemonModel.name}'),
            Divider(),
            CardPokemon(conteudoCard: 'Peso do pokemon: ${pokemonModel.weight} kg'),
          ],
        ),
      ),
    );
  }
}