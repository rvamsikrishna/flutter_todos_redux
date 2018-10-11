import 'package:flutter/material.dart';

class Category {
  final String name;
  final Color color;
  int todosNumber;
  final IconData icon;

  Category({this.name, this.todosNumber = 0, this.color, this.icon});
}

class Categories {
  final List<Category> categories;

  Categories(this.categories);

  factory Categories.initial() {
    return Categories(
      <Category>[
        Category(name: 'College', color: Colors.red, icon: Icons.school),
        Category(name: 'Work', color: Colors.blue, icon: Icons.work),
        Category(
            name: 'Study',
            color: Colors.yellow,
            icon: Icons.chrome_reader_mode),
        Category(name: 'Sport', color: Colors.green, icon: Icons.pool),
      ],
    );
  }
}
