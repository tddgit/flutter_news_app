import 'package:flutter/material.dart';
import 'package:flutter_news_app/blocs/stories_bloc.dart';
import 'package:flutter_news_app/blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: SafeArea(
        child: buildList(bloc),
      ),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) {
            return Text('${snapshot.data?[index]}');
          },
        );
      },
    );
  }

// Widget buildList() {
//   return ListView.builder(
//     itemCount: 1000,
//     itemBuilder: (context, int index) {
//       return FutureBuilder(
//         future: getFuture(),
//         builder: (context, snapshot) {
//           return snapshot.hasData
//               ? Text('Im visible $index')
//               : Text('Im not visible $index');
//         },
//       );
//     },
//   );
// }
//
// getFuture() {
//   return Future.delayed(Duration(seconds: 2), () => 'hi');
// }
}
