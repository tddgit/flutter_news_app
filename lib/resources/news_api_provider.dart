import 'dart:convert';

import 'package:flutter_news_app/models/item_model.dart';
import 'package:http/http.dart' show Client;

class NewsApiProvider {
  Client client = Client();

  final String root = 'https://hacker-news.firebaseio.com/v0';

  fetchTopIds() async {
    var url = Uri.parse('$root/v0/topstories.json');

    final response = await client.get(url);
    final ids = json.decode(response.body);

    return ids;
  }

  fetchItem(int id) async {
    var url = Uri.parse('$root/v0/item/$id.json');
    final response = await client.get(url);
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
