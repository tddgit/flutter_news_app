import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/news_list.dart';

import 'package:flutter_news_app/blocs/stories_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'News!',
        home: NewsList(),
      ),
    );
  }
}
