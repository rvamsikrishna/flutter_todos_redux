import 'package:flutter_todos_redux/redux/actions/edit_actions.dart';
import 'package:redux/redux.dart';

final toggleEditingStatus = TypedReducer<bool, ToggleEditingStatusAction>(
    (bool editing, ToggleEditingStatusAction action) {
  return action.editing;
});
