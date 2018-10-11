import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_todos_redux/date_select_button.dart';
import 'package:flutter_todos_redux/models/catergory_model.dart';
import 'package:flutter_todos_redux/models/selected_day.dart';
import 'package:flutter_todos_redux/models/todo_model.dart';
import 'package:flutter_todos_redux/my_radio_button.dart';

class AddTodoForm extends StatefulWidget {
  final bool editing;
  final List<Category> categories;
  //screen size
  final Size size;
  final Function(bool) toggleEditingStatus;
  final Function(Todo) addTodo;

  const AddTodoForm({
    Key key,
    this.editing,
    this.categories,
    this.size,
    this.toggleEditingStatus,
    this.addTodo,
  }) : super(key: key);

  @override
  AddTodoFormState createState() {
    return new AddTodoFormState();
  }
}

class AddTodoFormState extends State<AddTodoForm>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _textController;
  AnimationController _animCntroller;
  ScrollController _scrollController;
  Animation<RelativeRect> _rectAnimation;
  Map<String, dynamic> _formData = {
    'text': null,
    'category': null,
    'date': null,
    'time': null,
  };
  SelectedDay _selectedDate;

  void _setInitial() {
    _formData['text'] = '';
    _formData['category'] = widget.categories[0];
    _formData['date'] = DateTime.now().add(Duration(hours: 1));
    _formData['time'] = TimeOfDay.now();
    _selectedDate = SelectedDay.Today;
  }

  @override
  void initState() {
    super.initState();
    _setInitial();
    _scrollController = ScrollController();
    _textController = TextEditingController();
    _animCntroller = AnimationController(
        duration: Duration(milliseconds: 300), value: 0.0, vsync: this);

    final Size size = widget.size;
    _rectAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, size.height, 0.0, -size.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_animCntroller);
  }

  @override
  void didUpdateWidget(AddTodoForm oldWidget) {
    if (widget.editing != oldWidget.editing) {
      if (!widget.editing) {
        _formKey.currentState.save();
        if (_formData['text'].isEmpty) {
          widget.toggleEditingStatus(false);
        } else {
          widget.addTodo(Todo.fromMap(_formData));
        }
        _textController.text = '';
        _setInitial();
        _scrollController.animateTo(0.0,
            curve: Curves.ease, duration: Duration(microseconds: 100));
      }
      _animCntroller.fling(velocity: widget.editing ? 1.0 : -1.0);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _textController.dispose();
    _animCntroller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildTodoTextInput() {
    return TextFormField(
      controller: _textController,
      decoration: InputDecoration(
        hintText: 'enter your todo',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      onSaved: (String text) {
        _formData['text'] = text;
      },
    );
  }

  Row _buildDateSelectionRow() {
    return Row(
      children: <Widget>[
        DateSelectButton(
          text: 'Today',
          selected: _selectedDate == SelectedDay.Today,
          onChange: (bool selected) {
            print('today toggled');
            _handleDateChange(selected, DateTime.now(), SelectedDay.Today);
          },
        ),
        SizedBox(width: 10.0),
        DateSelectButton(
          text: 'Tommorow',
          selected: _selectedDate == SelectedDay.Tommorow,
          onChange: (bool selected) {
            print('tommorow toggled');
            _handleDateChange(
              selected,
              DateTime.now().add(Duration(days: 1)),
              SelectedDay.Tommorow,
            );
          },
        ),
        SizedBox(width: 10.0),
        DateSelectButton(
          text: 'Date',
          selected: _selectedDate == SelectedDay.Custom,
          onChange: (bool selected) async {
            final DateTime date = await _selectDate();
            _handleDateChange(true, date, SelectedDay.Custom);
          },
        ),
      ],
    );
  }

  Future<DateTime> _selectDate() {
    return showDatePicker(
      context: context,
      firstDate: DateTime.now().add(Duration(days: 2)),
      initialDate: _selectedDate != SelectedDay.Custom
          ? DateTime.now().add(Duration(days: 3))
          : _formData['date'],
      lastDate: DateTime.now().add(Duration(days: 10000)),
    );
  }

  Column _buildCategorySelection() {
    return Column(
      children: widget.categories.map((Category cat) {
        final bool selected = _formData['category']?.name == cat.name;
        return ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 0.0),
          title: Text(
            '${cat.name}',
            style: Theme.of(context).textTheme.body2,
          ),
          leading: MyRadioButton(
            color: cat.color,
            selected: selected,
            onChange: (newVal) {
              _handleCategoryChange(newVal, cat);
            },
          ),
          onTap: () {
            print('tapped');
            if (selected) {
              _handleCategoryChange(false, cat);
            } else {
              _handleCategoryChange(true, cat);
            }
          },
        );
      }).toList(),
    );
  }

  Widget _buildTimeSelection() {
    final TimeOfDay time = _formData['time'];
    return Row(
      children: <Widget>[
        DateSelectButton(
          text: '${time.hour} : ${time.minute}',
          selected: _formData['time'] != null,
          onChange: (bool selected) async {
            final TimeOfDay time = await _selectTime();
            setState(() {
              _formData['time'] = time;
            });
          },
        ),
      ],
    );
  }

  Future<TimeOfDay> _selectTime() {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  void _handleDateChange(
      bool selected, DateTime date, SelectedDay selectedDate) {
    setState(() {
      if (selected) {
        _formData['date'] = date;
        _selectedDate = selectedDate;
      } else {
        _formData['date'] = null;
        _selectedDate = null;
      }
    });
  }

  void _handleCategoryChange(bool newVal, Category category) {
    setState(() {
      if (newVal) {
        _formData['category'] = category;
      } else {
        _formData['category'] = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect: _rectAnimation,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () => widget.toggleEditingStatus(false),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Form(
              key: _formKey,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.only(bottom: 75.0),
                child: ListView(
                  controller: _scrollController,
                  padding: EdgeInsets.all(25.0),
                  shrinkWrap: true,
                  children: <Widget>[
                    Text(
                      'Create new todo',
                      style: Theme.of(context).textTheme.headline,
                    ),
                    _buildTodoTextInput(),
                    SizedBox(height: 25.0),
                    _buildDateSelectionRow(),
                    SizedBox(height: 25.0),
                    _buildTimeSelection(),
                    SizedBox(height: 25.0),
                    _buildCategorySelection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
