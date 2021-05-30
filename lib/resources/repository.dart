import 'package:flutter_news_app/models/item_model.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';

class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel? item = await dbProvider.fetchItem(id);

    if (item == null) {
      item = await apiProvider.fetchItem(id);
      dbProvider.addItem(item!);
      return item;
    }
    return item;
  }
}
