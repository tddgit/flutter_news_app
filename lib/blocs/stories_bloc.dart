import 'package:flutter_news_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final PublishSubject<List<int>> _topIds = PublishSubject<List<int>>();
  final _repository = Repository();

  //Getters to stream
  Stream<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    //Adding ids to stream
    if (ids != null) {
      _topIds.sink.add(ids);
    }
  }

  dispose() {
    _topIds.close();
  }
}
