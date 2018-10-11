import 'package:flutter_todos_redux/models/todo_model.dart';
import 'package:flutter_todos_redux/redux/actions/todo_actions.dart';
import 'package:redux/redux.dart';

final todosReducer = combineReducers<List<Todo>>([
  TypedReducer<List<Todo>, AddTodoAction>(_addTodo),
  TypedReducer<List<Todo>, DeleteTodoAction>(_deleteTodo),
  TypedReducer<List<Todo>, UpdateTodoAction>(_updateTodo),
]);

List<Todo> _addTodo(List<Todo> todos, AddTodoAction action) {
  return List.from(todos)..add(action.todo);
}

List<Todo> _deleteTodo(List<Todo> todos, DeleteTodoAction action) {
  return todos.where((todo) => todo.id != action.todo.id).toList();
}

List<Todo> _updateTodo(List<Todo> todos, UpdateTodoAction action) {
  return todos
      .map((todo) => todo.id == action.id ? action.updatedTodo : todo)
      .toList();
}
