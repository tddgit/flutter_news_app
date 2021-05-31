import 'dart:async';
import 'dart:io';

import 'package:flutter_news_app/models/item_model.dart';
import 'package:flutter_news_app/resources/repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NewsDbProvider implements Source, Cache {
  Database? db;

  NewsDbProvider() {
    init();
  }

  @override
  Future<List<int>?>? fetchTopIds() {
    // Future.delayed(Duration());
    return null;
  }

  Future<void> init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, 'items.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
        CREATE TABLE Items 
        (
          id INTEGER PRIMARY KEY,
          type TEXT, 
          by TEXT,
          text TEXT,
          parent TEXT,
          kids BLOB,
          dead INTEGER,
          deleted INTEGER,
          url TEXT,
          descendants INTEGER              
        )
     """);
      },
    );
  }

  @override
  Future<ItemModel?> fetchItem(int id) async {
    final List<Map<String, dynamic>>? maps = await db?.query(
      "Items",
      columns: null,
      where: 'id=?',
      whereArgs: <int>[id],
    );

    if (maps != null && maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  @override
  Future<int>? addItem(ItemModel item) {
    return db?.insert("Items", item.toMap());
  }
}
