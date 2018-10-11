import 'package:flutter_todos_redux/models/current_tab.dart';
import 'package:flutter_todos_redux/redux/actions/tab_actions.dart';
import 'package:redux/redux.dart';

final currentTabReducer = combineReducers<CurrentTab>(
  [
    TypedReducer<CurrentTab, SetCurrentTabAction>(_currentTab),
  ],
);

CurrentTab _currentTab(CurrentTab tab, SetCurrentTabAction action) {
  if (action.currentTab == CurrentTab.Today) {
    print('debugggingggggggggggg .....today');
  }
  if (action.currentTab == CurrentTab.Week) {
    print('debugggingggggggggggg .....week');
  }
  if (action.currentTab == CurrentTab.Month) {
    print('debugggingggggggggggg .....month');
  }
  return action.currentTab;
}
