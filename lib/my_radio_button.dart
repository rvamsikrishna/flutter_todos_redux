import 'package:flutter/material.dart';
import 'package:flutter_todos_redux/base_select.dart';

class MyRadioButton extends StatelessWidget {
  final double size;
  final bool selected;
  final Color color;
  final ValueChanged<bool> onChange;

  const MyRadioButton({
    Key key,
    this.size = 30.0,
    this.selected = false,
    this.color = Colors.grey,
    this.onChange,
  }) : super(key: key);
//   @override
//   _MyRadioButtonState createState() => _MyRadioButtonState();
// }

// class _MyRadioButtonState extends State<MyRadioButton>
//     with SingleTickerProviderStateMixin {
//   bool _checked;
//   AnimationController _controller;

//   initState() {
//     super.initState();
//     _checked = widget.initialValue;
//     _controller = AnimationController(
//       duration: Duration(milliseconds: 200),
//       value: _checked ? 1.0 : 0.0,
//       vsync: this,
//     );
//   }

//   @override
//   void didUpdateWidget(MyRadioButton oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.initialValue != oldWidget.initialValue) {
//       _checked = widget.initialValue;
//       if (_checked) {
//         _controller.forward();
//       } else {
//         _controller.reverse();
//       }
//     }
//   }

//   @override
//   dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   _toggle() {
//     setState(() {
//       _checked = !_checked;
//       if (widget.onChange != null && widget.onChange is Function(bool)) {
//         widget.onChange(_checked);
//       }
//       if (_checked) {
//         _controller.forward();
//       } else {
//         _controller.reverse();
//       }
//     });
//   }

  @override
  Widget build(BuildContext context) {
    return BaseSelect(
      selected: selected,
      onChange: onChange,
      builder: (BuildContext context, Animation animation) {
        return Container(
          width: size,
          height: size,
          child: CustomPaint(
            painter: MyRadioButtonPainter(
                animation: animation, checked: true, color: color),
          ),
        );
      },
    );
  }
}

class MyRadioButtonPainter extends CustomPainter {
  final Animation animation;
  final Color color;
  final bool checked;

  MyRadioButtonPainter({this.animation, this.checked, this.color})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    // print('rebuilding radio....$checked');
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Paint borderPaint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final Paint innerCirclePaint = Paint()
      ..color = color.withOpacity(animation.value);

    canvas.drawCircle(center, size.width / 2, borderPaint);
    // if (checked) {
    canvas.drawCircle(center, size.width / 2 - 5.0, innerCirclePaint);
    // }
  }

  @override
  bool shouldRepaint(MyRadioButtonPainter oldDelegate) {
    return oldDelegate.checked != checked;
  }
}
