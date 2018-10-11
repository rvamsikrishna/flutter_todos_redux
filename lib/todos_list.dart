import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_todos_redux/models/app_state.dart';
import 'package:flutter_todos_redux/models/catergory_model.dart';
import 'package:flutter_todos_redux/models/current_tab.dart';
import 'package:flutter_todos_redux/models/todo_model.dart';
import 'package:flutter_todos_redux/redux/actions/todo_actions.dart';
import 'package:flutter_todos_redux/redux/selectors/selectors.dart';
import 'package:flutter_todos_redux/todo_tile.dart';
import 'package:redux/redux.dart';

class TodosList extends StatelessWidget {
  final Category currentCategory;
  final bool showCompleted;

  const TodosList({Key key, this.currentCategory, this.showCompleted})
      : super(key: key);

  List<Widget> _buildTodoList(List<Todo> todos, _ViewModel vm) {
    return todos
        .map(
          (todo) => Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: TodoTile(
                  todo: todo,
                  updateTodo: vm.updateTodo,
                  deleteTodo: vm.deleteTodo,
                ),
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      builder: (BuildContext context, _ViewModel vm) {
        List<Todo> todos;
        if (currentCategory != null) {
          todos = allCategoryTodosSelector(
              currentCategory, vm.todos, showCompleted);
        } else {
          todos = upcomingTodosSelector(vm.currentTab, vm.todos);
        }
        if (todos.length == 0) {
          return Center(child: Text('Yeah👏!! you have no todos...'));
        }
        return Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: _buildTodoList(todos, vm),
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final CurrentTab currentTab;
  final List<Todo> todos;
  final Function(Todo) deleteTodo;
  final Function(String, Todo) updateTodo;

  _ViewModel({
    this.currentTab,
    this.todos,
    this.deleteTodo,
    this.updateTodo,
  });

  factory _ViewModel.create(Store<AppState> store) {
    return _ViewModel(
        currentTab: store.state.currentTab,
        todos: store.state.todos,
        deleteTodo: (Todo todo) => store.dispatch(DeleteTodoAction(todo)),
        updateTodo: (String id, Todo todo) =>
            store.dispatch(UpdateTodoAction(id: id, updatedTodo: todo)));
  }
}
