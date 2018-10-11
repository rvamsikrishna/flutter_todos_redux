import 'package:flutter/material.dart';

class BaseSelect extends StatefulWidget {
  final bool selected;
  final ValueChanged<bool> onChange;
  final Function(BuildContext, Animation) builder;

  const BaseSelect(
      {Key key, this.selected = false, this.onChange, @required this.builder})
      : super(key: key);

  @override
  _MyRadioButtonState createState() => _MyRadioButtonState();
}

class _MyRadioButtonState extends State<BaseSelect>
    with SingleTickerProviderStateMixin {
  bool _checked;
  AnimationController _controller;

  initState() {
    super.initState();
    _checked = widget.selected;
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      value: _checked ? 1.0 : 0.0,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(BaseSelect oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checked = widget.selected;
    if (_checked) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  _toggle() {
    setState(() {
      _checked = !_checked;
      if (widget.onChange != null && widget.onChange is Function(bool)) {
        widget.onChange(_checked);
      }
      if (_checked) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: widget.builder(context, _controller),
    );
  }
}
