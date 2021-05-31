import 'dart:convert';

import 'package:flutter_news_app/models/item_model.dart';
import 'package:flutter_news_app/resources/repository.dart';
import 'package:http/http.dart' show Client, Response;

class NewsApiProvider implements Source {
  final Client client = Client();

  final String root = 'https://hacker-news.firebaseio.com/v0/user/jl.json';

  @override
  Future<List<int>?> fetchTopIds() async {
    final Uri url = Uri.parse(root);

    final Response response = await client.get(url);
    final dynamic ids = json.decode(response.body);
    // if (ids['submitted'] is List<dynamic>) {
    //
    // }
    final List<dynamic> listOfIds = ids['submitted'] as List<dynamic>;
    // print('Top stories $ids');
    //Casting of List
    return listOfIds.cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final Uri url = Uri.parse('$root/v0/item/$id.json');
    final Response response = await client.get(url);
    final Map<String, dynamic> parsedJson =
        json.decode(response.body) as Map<String, dynamic>;
    return ItemModel.fromJson(parsedJson);
  }
}
