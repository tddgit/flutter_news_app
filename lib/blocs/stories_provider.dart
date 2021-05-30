import 'package:flutter/cupertino.dart';
import 'package:flutter_news_app/blocs/stories_bloc.dart';
export 'package:flutter_news_app/blocs/stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesProvider({Key? key, required Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static StoriesBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StoriesProvider>()!.bloc;
  }
}
