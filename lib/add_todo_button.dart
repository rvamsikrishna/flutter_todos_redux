import 'package:flutter/material.dart';

class AddTodoButton extends StatefulWidget {
  final Function onClick;
  //screen size
  final Size size;
  final bool editing;

  const AddTodoButton({
    Key key,
    this.onClick,
    this.size,
    this.editing,
  }) : super(key: key);

  @override
  _AddTodoButtonState createState() => _AddTodoButtonState();
}

class _AddTodoButtonState extends State<AddTodoButton>
    with SingleTickerProviderStateMixin {
  ButtonState buttonState = ButtonState.Small;
  AnimationController _controller;
  Animation<RelativeRect> _buttonAnimation;
  Animation<double> _buttonTextAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 450), vsync: this);

    _buttonTextAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Interval(0.7, 1.0), parent: _controller));
  }

  @override
  void didUpdateWidget(AddTodoButton oldWidget) {
    if (widget.editing != oldWidget.editing) {
      _controller.value == 1.0 ? _controller.reverse() : _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleClick() {
    if (buttonState == ButtonState.Small) {
      _controller.forward();
      buttonState = ButtonState.Enlarged;
    } else {
      buttonState = ButtonState.Small;
      _controller.reverse();
    }
    widget.onClick();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;
    final Size buttonSize = Size(75.0, 75.0);
    final double top = size.height - buttonSize.height;
    final double initialLeftRight = (size.width - buttonSize.width) / 2;

    _buttonAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          initialLeftRight, top - 25.0, initialLeftRight, 25.0),
      end: RelativeRect.fromLTRB(0.0, top, 0.0, 0.0),
    ).animate(CurvedAnimation(curve: Interval(0.0, 0.7), parent: _controller));

    return PositionedTransition(
      rect: _buttonAnimation,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color.fromRGBO(111, 94, 230, 1.0),
              Color.fromRGBO(127, 110, 235, 1.0),
            ],
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _handleClick,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                SizeTransition(
                  sizeFactor: _buttonTextAnimation,
                  axis: Axis.horizontal,
                  axisAlignment: -1.0,
                  child: Center(
                    child: Text(
                      'ADD TODO',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum ButtonState { Small, Enlarged }
