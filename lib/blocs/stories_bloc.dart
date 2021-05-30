import 'package:flutter_news_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final PublishSubject<List<int>> _topIds = PublishSubject();
  final _repository = Repository();

  //Getters to stream
  Stream<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
  }

  dispose() {
    _topIds.close();
  }
}
