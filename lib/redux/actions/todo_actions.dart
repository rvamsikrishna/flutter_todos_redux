import 'package:flutter_todos_redux/models/todo_model.dart';

class AddTodoAction {
  final Todo todo;

  AddTodoAction(this.todo);
}

class DeleteTodoAction {
  final Todo todo;

  DeleteTodoAction(this.todo);
}

class UpdateTodoAction {
  final String id;
  final Todo updatedTodo;

  UpdateTodoAction({this.id, this.updatedTodo});
}
