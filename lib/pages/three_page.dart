import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ThreePage extends StatelessWidget {
  const ThreePage({super.key});



  Future<void> todos()async {
    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/todos');

    var armazenar = await http.get(url);

    String dadosApi = armazenar.body;

    List convertido = jsonDecode(dadosApi);

    List<Usuarios> usuariosModel = convertido.map((json) => Usuarios.fromJson(json)).toList();

    print(usuariosModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () => todos(),
         child: Text('clique para ver informaçoes')),
    );
  }
}


class Usuarios{
  final int userId;
  final int id;
  final String title;
  final bool completed;


  Usuarios({required this.userId, required this.id, required this.title, required this.completed});

  factory Usuarios.fromJson(Map<String, dynamic> json) {
    return Usuarios(
      userId: json ['userId'],
      id: json ['id'],
      title: json ['title'],
      completed: json ['completed']
    );

  }
}