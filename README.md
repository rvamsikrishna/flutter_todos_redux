# flutter_todos_redux

A Flutter hobby project using redux for state management. The UI has been inspired from a [dribbble](https://dribbble.com/shots/5261578-Task-Manager-TODO-Interaction-UX) by [DhipuMathew](https://dribbble.com/DhipuMathew).

## Screenshots

![GIF](https://cdn.dribbble.com/users/673583/screenshots/5261578/dribbble1.gif)

![home page](https://lh3.googleusercontent.com/ajupf-ZQllLf5TIfWjSJ6pOQTMtqKDue_r-yo6MLkFXCDNFjcAscMxq2rt0XHo6YMiYCbKmdPEuH) ![add todo](https://lh3.googleusercontent.com/S9dZ0BG9P_M7GbczeIM2tQ5T2wUNWXyw_Vg0fj_RfUGZS-A98tAfAY6nCtzfcOUqNUB5YywVXcp3)

I have been playing with flutter for about 3 weeks(sep 2018). This is my very first flutter app I built to check out the framework. The codebase is not well structured and also can be coded better. It is me just playing with the framework and quickly prototyping a working app.

## Architecture of the app

The App's state consists of:

1. list of todos
2. current tab the user is on i.e ''today'' or ''week'' or ''month''
3. boolean `editing`
4. list of categories

The app consists of two pages:

1. **_home page_**: it displays the user info, the tab view showing the upcoming todos and the todo categoris grid view.
2. **_todos list page_**: displays all the todos belonging to a particular category.

##### <u>The Home Page</u>

The home page is essentially a [Stack](https://docs.flutter.io/flutter/widgets/Stack-class.html) widget consisting of two layers:

1. Main Layer: This layer displays the appbar, user info, the upcoming todos(in a tabbed view) and all the todo categories.
2. AddTodo Layer: This consists of the 'ADD TODO' button and the form that appears when the button is clicked.

<u>Explanation of the add todo animation</u>:

The AddTodo layer is a Stack itself. This stack consist of two children:

1.  [AddTodoForm](https://github.com/rvamsikrishna/flutter_todos_redux/blob/master/lib/add_todo_form.dart)
2.  [AddTodoButton](https://github.com/rvamsikrishna/flutter_todos_redux/blob/master/lib/add_todo_button.dart)

These both are [PositionedTransition](https://docs.flutter.io/flutter/widgets/PositionedTransition-class.html) widgets which is the animated version of Positioned widgets.

The initial position of the form is completely pushed of the screen downwards which is derived from the RelativeRectTween as below:

```dart
    _rectAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, size.height, 0.0, -size.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_animCntroller);

	...
    ...
    ...

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect: _rectAnimation,
      child: Column(
        ...
      ),
    );
  }

```

Similarly the button also has its own animations which control its position and the button text. These animations are deferred using an [Interval](https://docs.flutter.io/flutter/animation/Interval-class.html). The button moves down and expands for the 70% of the animation and the the text animates for the remaining 30%

```dart
//animation that animates the position: 0.0 -> 0.7
_buttonAnimation = RelativeRectTween(
    begin: RelativeRect.fromLTRB(
        initialLeftRight, top - 25.0, initialLeftRight, 25.0),
    end: RelativeRect.fromLTRB(0.0, top, 0.0, 0.0),
  ).animate(CurvedAnimation(curve: Interval(0.0, 0.7), parent: _controller));


//animation that animates the text: 0.7 -> 1.0
_buttonTextAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(curve: Interval(0.7, 1.0), parent: _controller));
```

When the button is pressed initially it triggers a redux action mutating the `editing` state of the store to `true`. This causes the re-render of the widgets. Both these widgets has a `didUpdateWidget` lifecycle hook. This lifecycle hook gets called when the widget's parent rebuilds and passes new properties to the widgets. In this lifecycle hook we perform the animation depending on the `editing` property.
