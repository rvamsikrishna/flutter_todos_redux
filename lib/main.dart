// import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter/material.dart';
import 'package:flutter_todos_redux/home.dart';
import 'package:flutter_todos_redux/models/app_state.dart';
import 'package:flutter_todos_redux/redux/actions/edit_actions.dart';
import 'package:flutter_todos_redux/redux/reducers/app_reducer.dart';
import 'package:redux/redux.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Store<AppState> store =
      Store<AppState>(appReducer, initialState: AppState.initial());

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Todos...',
        theme: _myTheme,
        home: WillPopScope(
          onWillPop: () async {
            if (store.state.editing) {
              store.dispatch(ToggleEditingStatusAction(editing: false));
            }
          },
          child: HomePage(),
        ),
      ),
    );
  }
}

final ThemeData _myTheme = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    // primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    // accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.0,
        ),
        title: base.title.copyWith(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        body2: base.body2.copyWith(
          fontWeight: FontWeight.w900,
          fontSize: 16.0,
          // letterSpacing: -1.0,
        ),
      )
      .apply(
        fontFamily: 'Poppins',
      );
}
