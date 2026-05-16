import 'package:flutter/material.dart';
import 'package:personalizado/extension/string_extension.dart';
import 'package:personalizado/models/detalhes_do_pokemon_model.dart';
import 'package:personalizado/models/pokemons_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


// 1 - initstate para chamar a api / tirar botao
// 2 - loading na tela enquanto api carrega
// 3 - mudar nomes de varaveis e funcoes

ValueNotifier<DetailsPokemonModel> detalhes =
    ValueNotifier<DetailsPokemonModel>(
      DetailsPokemonModel(id: 0, height: 0, name: "", weight: 0),
    );

    ValueNotifier<bool> loading = ValueNotifier<bool> (false); 

class DetalhesDoPokemonPage extends StatefulWidget {
  final PokemonModel pokemonClicado;
  const DetalhesDoPokemonPage({super.key, required this.pokemonClicado});

  @override
  State<DetalhesDoPokemonPage> createState() => _DetalhesDoPokemonPageState();
}

class _DetalhesDoPokemonPageState extends State<DetalhesDoPokemonPage> {
  Future<void> buscaApi() async {
    loading.value = true;
    await Future.delayed(Duration(seconds: 2));
    Uri enderecoDaApi = Uri.parse(widget.pokemonClicado.url);

    var respostaDaApi = await http.get(enderecoDaApi);

    String respostaEmformatoDeString = respostaDaApi.body;

    final Map<String, dynamic> retorno = jsonDecode(respostaEmformatoDeString);

    DetailsPokemonModel detalhesDePokemon = DetailsPokemonModel.fromJson(retorno);

    loading.value = false;

    detalhes.value = detalhesDePokemon;
  }

@override
  void  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      buscaApi();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pokemonClicado.name.firstLetterCapitalized)),
      body: ValueListenableBuilder(
        valueListenable: loading,
       builder: (context, isLoadingAPI, child) {
        return Center(
          child: isLoadingAPI
          ? Center(child: CircularProgressIndicator())
                : SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              ValueListenableBuilder(
                valueListenable: detalhes,
                builder: (_, details, _) {
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
        },
      ),
    );
  }
}