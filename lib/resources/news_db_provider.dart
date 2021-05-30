import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';

class NewsDbProvider {
  Database? db;

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items.db');
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

  Future<ItemModel?> fetchItem(int id) async {
    final List<Map<String, dynamic>>? maps = await db?.query(
      "Items",
      columns: null,
      where: 'id=?',
      whereArgs: [id],
    );

    if (maps != null && maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  Future<int>? addItem(ItemModel item) {
    return db?.insert("Items", item.toMap());
  }
}
