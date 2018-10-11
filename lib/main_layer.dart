import 'package:flutter/material.dart';
import 'package:flutter_todos_redux/all_todos_grid.dart';
import 'package:flutter_todos_redux/appbar.dart';
import 'package:flutter_todos_redux/tasks_view.dart';
import 'package:flutter_todos_redux/user_info.dart';

class MainLayer extends StatefulWidget {
  @override
  _MainLayerState createState() => _MainLayerState();
}

class _MainLayerState extends State<MainLayer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Colors.white,
            Colors.grey[200],
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: <Widget>[
            MyAppBar(),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  UserInfo(),
                  Container(height: 380.0, child: TasksView()),
                  Text(
                    'ALL TODO',
                    style: Theme.of(context).textTheme.body2,
                  ),
                  AllTodosSection(),
                  SizedBox(
                    height: 80.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
