import 'package:flutter/material.dart';
import 'package:flutter_todos_redux/models/catergory_model.dart';
import 'package:flutter_todos_redux/models/current_tab.dart';
import 'package:flutter_todos_redux/models/todo_model.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final List<Todo> todos;
  final CurrentTab currentTab;
  final bool editing;
  final List<Category> categories;

  AppState({
    this.todos,
    this.currentTab,
    this.editing,
    this.categories,
  });

  factory AppState.initial() {
    return AppState(
      currentTab: CurrentTab.Today,
      editing: false,
      // todos: [],
      todos: List.unmodifiable(
        <Todo>[
          Todo(
            text: 'Welcome.... ',
            category: Category(name: 'welcome', color: Colors.green),
            date: DateTime.now(),
            time: TimeOfDay.now(),
          ),
          Todo(
            text: 'Start taking down todos',
            category: Category(name: 'welcome', color: Colors.red),
            date: DateTime.now(),
            time: TimeOfDay.now(),
          ),
        ],
      ),
      categories: Categories.initial().categories,
    );
  }
}
