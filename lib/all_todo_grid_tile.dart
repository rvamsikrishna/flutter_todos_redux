import 'package:flutter/material.dart';
import 'package:flutter_todos_redux/models/catergory_model.dart';
import 'package:flutter_todos_redux/todos_list_page.dart';

class AllTodosGridTile extends StatelessWidget {
  final Category category;

  const AllTodosGridTile({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: <Widget>[
        Positioned(
          right: 0.0,
          top: -5.0,
          child: Hero(
            tag: 'border-${category.name}',
            child: Container(
              color: category.color,
              width: 20.0,
              height: 5.0,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(18.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: Icon(category.icon, color: category.color),
                ),
              ),
              Hero(
                tag: 'name-${category.name}',
                child: Text(
                  category.name,
                  style: Theme.of(context).textTheme.body2,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 7.0),
                child: Text('${category.todosNumber.toString()} todos'),
              ),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: category.color,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) {
                  return TodosPage(category: category);
                },
              ));
            },
          ),
        ),
      ],
    );
  }
}
