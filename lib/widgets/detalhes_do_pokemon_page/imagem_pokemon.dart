import 'package:flutter/material.dart';

class ImagemPokemon extends StatelessWidget {
  final String urlImagem;
  const ImagemPokemon({
    required this.urlImagem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Image.network(
          urlImagem,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}