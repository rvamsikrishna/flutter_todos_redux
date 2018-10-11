import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_todos_redux/all_todo_grid_tile.dart';
import 'package:flutter_todos_redux/models/app_state.dart';
import 'package:flutter_todos_redux/models/catergory_model.dart';
import 'package:redux/redux.dart';

class AllTodosSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      builder: (BuildContext context, _ViewModel vm) {
        return GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          shrinkWrap: true,
          itemCount: vm.categories.length,
          physics: ClampingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return AllTodosGridTile(category: vm.categories[index]);
          },
        );
      },
    );
  }
}

class _ViewModel {
  final List<Category> categories;

  _ViewModel({this.categories});

  factory _ViewModel.create(Store<AppState> store) {
    return _ViewModel(
      categories: store.state.categories,
    );
  }
}
