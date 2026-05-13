import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:personalizado/models/pokemons_model.dart';
import 'package:personalizado/views/detalhes_do_pokemon_page.dart';
import 'package:personalizado/widgets/custom_buttom_widget.dart';

class TodosOsPokemonsPage extends StatefulWidget {
  const TodosOsPokemonsPage ({super.key});

  @override
  State<TodosOsPokemonsPage> createState() => _SeconPageState();
}

class _SeconPageState extends State<TodosOsPokemonsPage> {
  ValueNotifier<List<PokemonModel>> list = ValueNotifier<List<PokemonModel>>([]);
  ValueNotifier<bool> inLoader = ValueNotifier<bool>(false);

  Future<void> dadosApi() async {
    Uri endpointDaApi = Uri.parse('https://pokeapi.co/api/v2/pokemon');
    inLoader.value = true;
    var respostaDaApi = await http.get(endpointDaApi);

    String respostaEmformatoDeString = respostaDaApi.body;

    final Map retorno = jsonDecode(respostaEmformatoDeString);

    List listaDePokemonsEmJson = retorno['results'];

    List<PokemonModel> listaDePokemonsEmPokemonModel = listaDePokemonsEmJson
        .map((json) => PokemonModel.fromJson(json))
        .toList();

        inLoader.value = false;

    list.value = listaDePokemonsEmPokemonModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: CustomButtomWidget(
                  disable: false,
                  onPressed: () => dadosApi(),
                  title: 'Buscar Pokemon',
                  titleSize: 20,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: list,
                builder: (_, pokeList, __) {
                  return pokeList.isEmpty
                      ? SizedBox()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: pokeList.length,
                          itemBuilder: (context, index) {

                            final pokemonAtual = pokeList[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetalhesDoPokemonPage(
                                      pokemonClicado: pokemonAtual,
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: Text(index.toString()),
                                title: Text(pokemonAtual.name),
                              ),
                            );
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
