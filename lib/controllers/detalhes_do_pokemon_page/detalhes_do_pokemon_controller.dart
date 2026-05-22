import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:personalizado/models/detalhes_do_pokemon_model/detalhes_do_pokemon_model.dart';
import 'package:personalizado/models/pokemons_model.dart';
import 'package:http/http.dart' as http;

class DetalhesDoPokemonController {
  final PokemonModel pokemonClicado;
  DetalhesDoPokemonController({required this.pokemonClicado});

  ValueNotifier<DetailsPokemonModel> detalhesDoPokemon =
      ValueNotifier<DetailsPokemonModel>(
        DetailsPokemonModel(
          id: 0,
          height: 0,
          name: "",
          weight: 0,
          backDefault: "",
        ),
      );

  ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  Future<void> buscarDetalhesDoPokemon() async {
    loading.value = true;
    await Future.delayed(Duration(seconds: 2));
    Uri enderecoDaApi = Uri.parse(pokemonClicado.url);

    var respostaDaApi = await http.get(enderecoDaApi);

    String respostaEmformatoDeString = respostaDaApi.body;

    final Map<String, dynamic> retorno = jsonDecode(respostaEmformatoDeString);

    DetailsPokemonModel detalhesDePokemon = DetailsPokemonModel.fromJson(
      retorno,
    );

    loading.value = false;

    detalhesDoPokemon.value = detalhesDePokemon;
  }
}
