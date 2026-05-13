import 'package:flutter/material.dart';
import 'package:personalizado/models/detalhes_do_pokemon_model.dart';
import 'package:personalizado/models/pokemons_model.dart';
import 'package:personalizado/widgets/custom_buttom_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//1- Criar botao
//2- Criar funçao para o botao chamar
//3- Criar modelo de detahes do pokemon(mapear so oq eu quero no from json),
//criar variavel valueNotifier com tipo sendo um modelo criado
//4- ajustar funçao para bater na Api: pokemonClicado.url
//5-Converter para detalhesDoPokemonModel
//6- atualizar o valor do meu valueNotifier
//7- criar o  ValueListenableBuilder
ValueNotifier<DetailsPokemonModel> detalhes =
    ValueNotifier<DetailsPokemonModel>(
      DetailsPokemonModel(id: 0, height: 0, name: "", weight: 0),
    );

class DetalhesDoPokemonPage extends StatefulWidget {
  final PokemonModel pokemonClicado;
  const DetalhesDoPokemonPage({super.key, required this.pokemonClicado});

  @override
  State<DetalhesDoPokemonPage> createState() => _DetalhesDoPokemonPageState();
}

class _DetalhesDoPokemonPageState extends State<DetalhesDoPokemonPage> {
  Future<void> buscaApi() async {
    Uri enderecoDaApi = Uri.parse(widget.pokemonClicado.url);

    var respostaDaApi = await http.get(enderecoDaApi);

    String respostaEmformatoDeString = respostaDaApi.body;

    final Map<String, dynamic> retorno = jsonDecode(respostaEmformatoDeString);

    DetailsPokemonModel detalhesDePokemon = DetailsPokemonModel.fromJson(
      retorno,
    );

    detalhes.value = detalhesDePokemon;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.pokemonClicado.url);
    return Scaffold(
      appBar: AppBar(title: Text(widget.pokemonClicado.name)),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: CustomButtomWidget(
                  disable: false,
                  onPressed: () => buscaApi(),
                  title: 'Buscar Detalhes do Pokemon',
                  titleSize: 20,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: detalhes,
                builder: (_, details, __) {
                  return details.id == 0 ? SizedBox() : Column(
                    children: [
                      Text('ID:${details.id.toString()} '),
                      Text('Altura::${details.height.toString()}'),
                      Text('Name::${details.name}'),
                      Text('o Peso é ${details.weight}')

                    ],
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

