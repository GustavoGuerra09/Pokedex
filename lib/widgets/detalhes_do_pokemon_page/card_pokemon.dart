import 'package:flutter/material.dart';

class CardPokemon extends StatelessWidget {
  final String conteudoCard;
  const CardPokemon({
    required this.conteudoCard,
    super.key,
  });

  @override
  Widget build(BuildContext context) {  
    return SizedBox(
      width: double.infinity,
      child: Text(
        conteudoCard,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}