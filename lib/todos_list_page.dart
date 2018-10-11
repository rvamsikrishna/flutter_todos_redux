import 'package:flutter/material.dart';
import 'package:flutter_todos_redux/models/catergory_model.dart';
import 'package:flutter_todos_redux/todos_list.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({
    Key key,
    @required this.category,
  }) : super(key: key);

  final Category category;

  @override
  TodosPageState createState() {
    return new TodosPageState();
  }
}

class TodosPageState extends State<TodosPage>
    with SingleTickerProviderStateMixin {
  TabController _tabControlller;
  final List<Widget> _tabs = [
    Tab(
      text: 'UPCOMING',
    ),
    Tab(
      text: 'COMPLETED',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabControlller = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabControlller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'border-${widget.category.name}',
            child: Container(
              padding: EdgeInsets.only(top: 20.0),
              color: widget.category.color,
              width: double.infinity,
              height: 85.0,
              child: Center(
                child: Hero(
                  tag: 'name-${widget.category.name}',
                  child: Text(
                    widget.category.name,
                    style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ),
          TabBar(
            controller: _tabControlller,
            tabs: _tabs,
            indicatorColor: Colors.grey,
            labelColor: Colors.black,
            labelStyle: Theme.of(context).textTheme.body2,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TabBarView(
                controller: _tabControlller,
                children: <Widget>[
                  TodosList(
                    currentCategory: widget.category,
                    showCompleted: false,
                  ),
                  TodosList(
                    currentCategory: widget.category,
                    showCompleted: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
