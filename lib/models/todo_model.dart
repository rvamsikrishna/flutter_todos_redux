import 'package:flutter/material.dart';
import 'package:flutter_todos_redux/helpers/uuid.dart';
import 'package:flutter_todos_redux/models/catergory_model.dart';

class Todo {
  final String id;
  final String text;
  final Category category;
  final DateTime date;
  final TimeOfDay time;
  final bool completed;

  Todo({this.text, this.category, this.date, this.time, this.completed = false})
      : id = Uuid().generateV4();

  factory Todo.empty() {
    return Todo(text: '', category: null, date: null, completed: false);
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      text: map['text'],
      category: map['category'],
      date: map['date'],
      time: map['time'],
      completed: map['completed'] ?? false,
    );
  }

  Todo copyWith(
      {String text, Category category, DateTime date, bool completed}) {
    return Todo(
      text: text ?? this.text,
      category: category ?? this.category,
      date: date ?? this.date,
      time: time ?? this.time,
      completed: completed ?? this.completed,
    );
  }
}
