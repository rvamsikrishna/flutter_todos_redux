import 'package:flutter/material.dart';
import 'package:flutter_todos_redux/helpers/format_date.dart';
import 'package:flutter_todos_redux/models/todo_model.dart';
import 'package:flutter_todos_redux/my_radio_button.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final Function(Todo) deleteTodo;
  final Function(String, Todo) updateTodo;

  const TodoTile({Key key, this.todo, this.deleteTodo, this.updateTodo})
      : super(key: key);

  Widget _buildTodoText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${todo.text}',
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.title,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
              '${todo.category.name}${formattedDateTime(todo.date, todo.time, context)}'),
        ),
      ],
    );
  }

  Widget _buildDismmissableBackground(Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color,
            Colors.redAccent,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          deleteTodo(todo);
        } else if (direction == DismissDirection.startToEnd) {
          updateTodo(todo.id, todo.copyWith(completed: true));
        }
      },
      background: _buildDismmissableBackground(todo.category.color),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 2.0, right: 30.0),
            child: MyRadioButton(
              selected: todo.completed,
              color: todo.category.color,
              onChange: (newVal) {
                updateTodo(todo.id, todo.copyWith(completed: newVal));
              },
            ),
          ),
          Expanded(
            child: _buildTodoText(context),
          ),
        ],
      ),
    );
  }
}
