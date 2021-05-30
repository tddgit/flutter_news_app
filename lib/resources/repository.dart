import 'package:flutter_news_app/models/item_model.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';

final newsDbProvider = NewsDbProvider();

abstract class Source {
  Future<List<int>>? fetchTopIds();

  Future<ItemModel?> fetchItem(int id);
}

abstract class Cache {
  Future<int>? addItem(ItemModel item);
}

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>>? fetchTopIds() {
    // Future.delayed(Duration());
    return sources[1].fetchTopIds();
  }

  Future<ItemModel?> fetchItem(int id) async {
    late ItemModel? item;
    Source source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    if (item != null) {
      for (var cache in caches) {
        cache.addItem(item);
      }
      return item;
    }

    return null;

    // ItemModel? item = await dbProvider.fetchItem(id);
    //
    // if (item == null) {
    //   item = await apiProvider.fetchItem(id);
    //   dbProvider.addItem(item);
    //   return item;
    // }
    // return item;
  }
}
