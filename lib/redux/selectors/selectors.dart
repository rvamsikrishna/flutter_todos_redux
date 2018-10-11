import 'package:flutter_todos_redux/models/catergory_model.dart';
import 'package:flutter_todos_redux/models/current_tab.dart';
import 'package:flutter_todos_redux/models/todo_model.dart';

int totalTodos(List<Todo> todos) {
  return todos.length;
}

int completedTodos(List<Todo> todos) {
  return todos.where((todo) => todo.completed).length;
}

List<Todo> allCategoryTodosSelector(
    Category category, List<Todo> todos, bool completed) {
  return todos.where((todo) {
    return todo.category.name == category.name && todo.completed == completed;
  }).toList();
}

List<Todo> upcomingTodosSelector(CurrentTab currentTab, List<Todo> todos) {
  final now = DateTime.now();
  final endOfToday = DateTime.utc(now.year, now.month, now.day, 24);
  final endOfWeek =
      DateTime.utc(now.year, now.month, now.day + (7 - now.weekday), 24);

  switch (currentTab) {
    case CurrentTab.Today:
      return todos
          .where((todo) {
            return todo.date.isBefore(endOfToday);
          })
          .take(3)
          .toList();
      break;
    case CurrentTab.Week:
      return todos
          .where((todo) {
            return todo.date.isAfter(endOfToday) &&
                todo.date.isBefore(endOfWeek);
          })
          .take(3)
          .toList();
      break;
    case CurrentTab.Month:
      return todos
          .where((todo) {
            return todo.date.isAfter(endOfWeek) &&
                todo.date.isBefore(now.add(Duration(days: 31 - now.day)));
          })
          .take(3)
          .toList();
      break;
    default:
      return todos;
      break;
  }
}
