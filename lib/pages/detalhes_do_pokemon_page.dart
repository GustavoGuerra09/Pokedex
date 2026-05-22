import 'package:flutter/material.dart';
import 'package:personalizado/controllers/detalhes_do_pokemon_page/detalhes_do_pokemon_controller.dart';
import 'package:personalizado/extension/string_extension.dart';
import 'package:personalizado/models/pokemons_model.dart';
import 'package:personalizado/widgets/detalhes_do_pokemon_page/detalhes_do_pokemon.dart';
import 'package:personalizado/widgets/detalhes_do_pokemon_page/detalhes_do_pokemon_page_loading.dart';
import 'package:personalizado/widgets/detalhes_do_pokemon_page/error_pokemon_nao_encontrado.dart';
import 'package:personalizado/widgets/detalhes_do_pokemon_page/imagem_pokemon.dart';

class DetalhesDoPokemonPage extends StatefulWidget {
  final PokemonModel pokemonClicado;
  const DetalhesDoPokemonPage({super.key, required this.pokemonClicado});

  @override
  State<DetalhesDoPokemonPage> createState() => _DetalhesDoPokemonPageState();
}

class _DetalhesDoPokemonPageState extends State<DetalhesDoPokemonPage> {
  late DetalhesDoPokemonController controller;

  @override
  void initState() {
    super.initState();
    controller = DetalhesDoPokemonController(pokemonClicado: widget.pokemonClicado);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.buscarDetalhesDoPokemon();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pokemonClicado.name.firstLetterCapitalized)),
      body: ValueListenableBuilder(
        valueListenable: controller.loading,
        builder: (context, isLoadingAPI, child) {
          return isLoadingAPI
            ? DetalhesDoPokemonPageLoading()
            : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: controller.detalhesDoPokemon,
                      builder: (_, detalhesDoPokemonClicado, _) {
                        final pokemonNaoFoiEncontrado = detalhesDoPokemonClicado.id == 0;
                        return pokemonNaoFoiEncontrado
                          ? ErrorPokemonNaoEncontrado()
                          : Column(
                            children: [
                              ImagemPokemon(urlImagem: detalhesDoPokemonClicado.backDefault),
                              DetalhesDoPokemon(pokemonModel: detalhesDoPokemonClicado),
                            ],
                          );
                      },
                    ),
                  ],
                ),
              ),
            );
        },
      ),
    );
  }
}



