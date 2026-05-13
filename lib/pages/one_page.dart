import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:personalizado/widgets/custom_buttom_widget.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class OnePage extends StatelessWidget {
  OnePage({super.key});

  ValueNotifier<List<Post>> list = ValueNotifier<List<Post>>([]);
  ValueNotifier<bool> isloading = ValueNotifier<bool>(false);

  Future<void> callAPI() async {
    isloading.value = true;
    list.value.clear();

    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    var response = await http.get(url);

    String postsResponse = response.body;

    List jsonConvertido = jsonDecode(postsResponse);

    List<Post> lista = jsonConvertido
        .map((itemJson) => Post.fromJson(itemJson))
        .toList();

    list.value = lista;
    isloading.value = false;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: CustomButtomWidget(
                      disable: false,
                      onPressed: () => callAPI(),
                      title: 'Buscar Posts',
                      titleSize: 20,
                    ),
                  ),

                  ValueListenableBuilder(
                    valueListenable: list,
                    builder: (_, postList, __) {

                      
                      return postList.isEmpty
                          ? SizedBox()
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: postList.length,
                              itemBuilder: (context, index) {
                                final post = postList[index];
                                return ListTile(
                                  leading: Text(post.id.toString()),
                                  title: Text(postList[index].title),
                                );
                              },
                            );
                    },
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: isloading,
              builder: (_, loading, __) {
                return loading == false
                    ? SizedBox()
                    : Container( 
                      height: 500,
                      width: double.infinity,
                      color: Colors.grey.withOpacity(.2),
                      child: Center(child: Text('Buscando dados...')),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
