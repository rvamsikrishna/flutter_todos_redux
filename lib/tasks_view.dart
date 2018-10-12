import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_todos_redux/models/app_state.dart';
import 'package:flutter_todos_redux/models/current_tab.dart';
import 'package:flutter_todos_redux/redux/actions/tab_actions.dart';
import 'package:flutter_todos_redux/todos_list.dart';
import 'package:redux/redux.dart';

class TasksView extends StatefulWidget {
  @override
  _TasksViewState createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Store<AppState> _store;
  final List<Widget> _tabs = [
    Tab(
      child: Row(children: <Widget>[Text('TODAY')]),
    ),
    Tab(
      child: Row(children: <Widget>[Text('WEEK')]),
    ),
    Tab(
      child: Row(children: <Widget>[Text('MONTH')]),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            _store.dispatch(SetCurrentTabAction(CurrentTab.Today));
            break;
          case 1:
            _store.dispatch(SetCurrentTabAction(CurrentTab.Week));
            break;
          case 2:
            _store.dispatch(SetCurrentTabAction(CurrentTab.Month));
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 18.0,
      ),
      child: Column(
        children: <Widget>[
          _MyTabBar(tabController: _tabController, tabs: _tabs),
          Expanded(
            child: _MyTabBarView(tabController: _tabController),
          ),
        ],
      ),
    );
  }
}

class _MyTabBar extends StatelessWidget {
  const _MyTabBar({
    Key key,
    @required TabController tabController,
    @required List<Widget> tabs,
  })  : _tabController = tabController,
        _tabs = tabs,
        super(key: key);

  final TabController _tabController;
  final List<Widget> _tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicator: UnderlineTabIndicator(
        borderSide: const BorderSide(
          width: 5.0,
          color: const Color.fromRGBO(86, 83, 195, 1.0),
        ),
        insets: const EdgeInsets.only(right: 100.0),
      ),
      controller: _tabController,
      tabs: _tabs.toList(),
      labelColor: Colors.black,
      labelPadding: EdgeInsets.all(0.0),
      labelStyle: Theme.of(context).textTheme.body2,
      unselectedLabelColor: Colors.grey,
    );
  }
}

class _MyTabBarView extends StatelessWidget {
  const _MyTabBarView({
    Key key,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        TodosList(key: Key('today')),
        TodosList(key: Key('week')),
        TodosList(key: Key('month')),
      ],
    );
  }
}
