import 'package:flutter/material.dart';
import 'package:flutter_news_app/blocs/stories_bloc.dart';
import 'package:flutter_news_app/blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StoriesBloc bloc = StoriesProvider.of(context);

    // ignore: cascade_invocations
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top News'),
      ),
      body: SafeArea(
        child: buildList(bloc),
      ),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder<List<int>>(
      stream: bloc.topIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (BuildContext context, int index) {
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
