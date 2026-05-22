import 'package:flutter/material.dart';

class DetalhesDoPokemonPageLoading extends StatelessWidget {
  const DetalhesDoPokemonPageLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
