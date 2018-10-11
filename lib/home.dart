import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_todos_redux/add_todo_button.dart';
import 'package:flutter_todos_redux/add_todo_form.dart';
import 'package:flutter_todos_redux/main_layer.dart';
import 'package:flutter_todos_redux/models/app_state.dart';
import 'package:flutter_todos_redux/models/catergory_model.dart';
import 'package:flutter_todos_redux/models/todo_model.dart';
import 'package:flutter_todos_redux/redux/actions/edit_actions.dart';
import 'package:flutter_todos_redux/redux/actions/todo_actions.dart';
import 'package:redux/redux.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          MainLayer(),
          AddTodoLayer(),
        ],
      ),
    );
  }
}

class AddTodoLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      builder: (BuildContext context, _ViewModel vm) {
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            AddTodoForm(
              editing: vm.editing,
              categories: vm.categories,
              size: size,
              toggleEditingStatus: vm.toggleEditingStatus,
              addTodo: vm.addTodo,
            ),
            AddTodoButton(
              editing: vm.editing,
              size: size,
              onClick: () {
                if (vm.editing) {
                  vm.toggleEditingStatus(false);
                } else {
                  vm.toggleEditingStatus(true);
                }
              },
              // addTodo: vm.addTodo
            ),
          ],
        );
      },
    );
  }
}

class _ViewModel {
  final List<Category> categories;
  final bool editing;
  final Function(bool) toggleEditingStatus;
  final Function(Todo) addTodo;

  _ViewModel({
    this.categories,
    this.editing,
    this.toggleEditingStatus,
    this.addTodo,
  });

  factory _ViewModel.create(Store<AppState> store) {
    return _ViewModel(
      categories: store.state.categories,
      editing: store.state.editing,
      toggleEditingStatus: (bool status) =>
          store.dispatch(ToggleEditingStatusAction(editing: status)),
      addTodo: (Todo todo) => store.dispatch(AddTodoAction(todo)),
    );
  }
}
