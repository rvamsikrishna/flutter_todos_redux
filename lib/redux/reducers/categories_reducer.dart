import 'package:flutter_todos_redux/models/catergory_model.dart';
import 'package:flutter_todos_redux/redux/actions/todo_actions.dart';
import 'package:redux/redux.dart';

final categoriesReducer = combineReducers<List<Category>>([
  TypedReducer<List<Category>, AddTodoAction>(_increaseCategoryTodoCount),
  TypedReducer<List<Category>, DeleteTodoAction>(_decreaseCategoryTodoCount),
]);

List<Category> _increaseCategoryTodoCount(
    List<Category> categories, AddTodoAction action) {
  return categories
      .map((Category cat) {
        if (action.todo.category.name == cat.name) {
          cat.todosNumber++;
        }
        return cat;
      })
      .toList()
      .cast<Category>();
}

List<Category> _decreaseCategoryTodoCount(
    List<Category> categories, DeleteTodoAction action) {
  return categories
      .map((Category cat) {
        if (action.todo.category.name == cat.name) {
          cat.todosNumber--;
        }
        return cat;
      })
      .toList()
      .cast<Category>();
}
