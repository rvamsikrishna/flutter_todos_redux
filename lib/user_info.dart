import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_todos_redux/models/app_state.dart';
import 'package:flutter_todos_redux/models/todo_model.dart';
import 'package:flutter_todos_redux/redux/selectors/selectors.dart';
import 'package:redux/redux.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 25.0, right: 5.0),
        child: StoreConnector<AppState, List<Todo>>(
          converter: (Store<AppState> store) => store.state.todos,
          builder: (BuildContext context, List<Todo> todos) {
            final int total = totalTodos(todos);
            final int completed = completedTodos(todos);
            final double percent = completed / total;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hey Mathew,',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'Hello ',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Loook like feel good.\n',
                              ),
                              TextSpan(text: 'You have $total tasks to do.'),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                CustomPaint(
                  size: Size(35.0, 35.0),
                  painter:
                      TodosProgress(percentDone: total > 0 ? percent : null),
                ),
              ],
            );
          },
        ));
  }
}

class TodosProgress extends CustomPainter {
  final double percentDone;

  TodosProgress({this.percentDone});
  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Rect arcRect =
        Rect.fromCircle(center: Offset(radius, radius), radius: radius);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;
    if (percentDone != null) {
      canvas
        ..drawArc(
          arcRect,
          -pi / 2,
          2 * pi * percentDone,
          false,
          paint..color = Colors.red,
        );

      canvas.drawArc(
        arcRect,
        -pi / 2,
        -2 * pi * (1.0 - percentDone),
        false,
        paint..color = Colors.grey[300],
      );
    }
  }

  @override
  bool shouldRepaint(TodosProgress oldDelegate) {
    return oldDelegate.percentDone != percentDone;
  }
}
