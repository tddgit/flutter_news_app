import 'dart:convert';

import 'package:flutter_news_app/models/item_model.dart';
import 'package:flutter_news_app/resources/news_api_provider.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  test('Fetching top ids of acticles', () async {
    final NewsApiProvider newsApi = NewsApiProvider()
      ..client = MockClient((Request request) async {
        return Response(json.encode(<int>[1, 2, 3, 4]), 200);
      });

    final List<int>? ids = await newsApi.fetchTopIds();
    expect(ids, <int>[1, 2, 3, 4]);
  });

  test(
    'Fetching item for specific id',
    () async {
      final NewsApiProvider newsApi = NewsApiProvider()
        ..client = MockClient((Request request) async {
          final Map<String, int> jsonMap = <String, int>{'id': 123};
          return Response(json.encode(jsonMap), 200);
        });
      final ItemModel item = await newsApi.fetchItem(123);
      expect(item, 123);
    },
  );
}
