import 'package:flutter/material.dart';
import 'package:personalizado/models/pokemons_model.dart';
import 'package:personalizado/pages/all_pokemons_page.dart';
import 'package:personalizado/pages/detalhes_do_pokemon_page.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> allRoutes = {
    initial: (context) => AllPokemonsPage(),
    detalhesDoPokemon: (context) {
      final clickedPokemon = ModalRoute.of(context)!.settings.arguments as PokemonModel;
      return DetalhesDoPokemonPage(pokemonClicado: clickedPokemon);
    },
  };

  static const String initial = '/initial';
  static const String detalhesDoPokemon  = '/detalhes-do-pokemon';
}
