import 'package:flutter/material.dart';
import 'package:personalizado/extension/string_extension.dart';
import 'package:personalizado/models/pokemons_model.dart';
import 'package:personalizado/routes/app_routes.dart';

class ListaDePokemons extends StatelessWidget {
  final List<PokemonModel> pokeList;
  const ListaDePokemons({
    required this.pokeList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => Divider(),
        itemCount: pokeList.length,
        itemBuilder: (context, index) {
          final pokemonAtual = pokeList[index];
    
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.detalhesDoPokemon,
                arguments: pokemonAtual,
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                child: Text(index.toString()),
              ),
              title: Text(pokemonAtual.name.firstLetterCapitalized),
            ),
          );
        },
      ),
    );
  }
}
