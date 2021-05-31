import 'dart:convert';

class ItemModel {
  final int? id;
  final bool? deleted;
  final String? type;
  final String? by;
  final int? time;
  final String? text;
  final bool? dead;
  final int? parent;
  final List<dynamic>? kids;
  final String? url;
  final int? score;
  final String? title;
  final int? descendants;

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'] as int,
        deleted = parsedJson['deleted'] as bool,
        type = parsedJson['type'] as String,
        by = parsedJson['by'] as String,
        time = parsedJson['time'] as int,
        text = parsedJson['text'] as String,
        dead = parsedJson['dead'] as bool,
        parent = parsedJson['parent'] as int,
        kids = parsedJson['kids'] as List<dynamic>,
        url = parsedJson['url'] as String,
        score = parsedJson['score'] as int,
        title = parsedJson['title'] as String,
        descendants = parsedJson['descendants'] as int;

  ItemModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'] as int,
        deleted = parsedJson['deleted'] == 1,
        type = parsedJson['type'] as String,
        by = parsedJson['by'] as String,
        time = parsedJson['time'] as int,
        text = parsedJson['text'] as String,
        dead = parsedJson['dead'] == 1,
        parent = parsedJson['parent'] as int,
        kids = jsonDecode(parsedJson['kids'] as String) as List<dynamic>,
        url = parsedJson['url'] as String,
        score = parsedJson['score'] as int,
        title = parsedJson['title'] as String,
        descendants = parsedJson['descendants'] as int;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'by': by,
      'time': time,
      'text': text,
      'parent': parent,
      'url': url,
      'score': score,
      'title': title,
      'deleted': deleted == false ? 0 : 1,
      'dead': dead == false ? 0 : 1,
      'kids': jsonEncode(kids),
    };
  }
}
