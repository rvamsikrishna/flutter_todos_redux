import 'package:flutter_todos_redux/models/app_state.dart';
import 'package:flutter_todos_redux/redux/reducers/todos_reducer.dart';
import 'package:flutter_todos_redux/redux/reducers/current_tabReducer.dart';
import 'package:flutter_todos_redux/redux/reducers/edit_reducer.dart';
import 'package:flutter_todos_redux/redux/reducers/categories_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    todos: todosReducer(state.todos, action),
    currentTab: currentTabReducer(state.currentTab, action),
    editing: toggleEditingStatus(state.editing, action),
    // categories: state.categories,
    categories: categoriesReducer(state.categories, action),
  );
}
