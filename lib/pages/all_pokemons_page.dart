import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:personalizado/models/pokemons_model.dart';
import 'package:personalizado/widgets/all_pokemons_page/lista_de_pokemons.dart';
import 'package:personalizado/widgets/custom_buttom_widget.dart';

class AllPokemonsPage extends StatefulWidget {
  const AllPokemonsPage({super.key});

  @override
  State<AllPokemonsPage> createState() => _AllPokemonsPageState();
}

class _AllPokemonsPageState extends State<AllPokemonsPage> {
  ValueNotifier<List<PokemonModel>> list = ValueNotifier<List<PokemonModel>>([]);

  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  Future<void> buscarPokemons() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));

    Uri endpointDaApi = Uri.parse('https://pokeapi.co/api/v2/pokemon');
    var respostaDaApi = await http.get(endpointDaApi);

    String respostaEmformatoDeString = respostaDaApi.body;

    final Map retorno = jsonDecode(respostaEmformatoDeString);

    List listaDePokemonsEmJson = retorno['results'];

    List<PokemonModel> listaDePokemonsEmPokemonModel = listaDePokemonsEmJson.map((json) => PokemonModel.fromJson(json)).toList();

    isLoading.value = false;

    list.value = listaDePokemonsEmPokemonModel;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      buscarPokemons();
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokemons')),
      body: ValueListenableBuilder(
        valueListenable: isLoading,
        builder: (context, isLoadingAPI, child) {
          return Center(
            child: isLoadingAPI
                ? Center(child: CircularProgressIndicator())
                : SafeArea(
                    // Evita que o conteúdo fique preso nas barras de status e de navegação
                    child: SingleChildScrollView(
                      child: ValueListenableBuilder(
                        valueListenable: list,
                        builder: (context, pokeList, _) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (pokeList.isEmpty) ...{
                                Text('Nenhum pokemon encontrado'),
                              } else ...{
                                ListaDePokemons(pokeList: pokeList),
                                CustomButtomWidget(
                                  title: 'Carregar mais pokemons >',
                                  onPressed: () {},
                                ),
                              },
                            ],
                          );
                        },
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

