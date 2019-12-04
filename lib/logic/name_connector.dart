import 'package:async_redux/async_redux.dart';
import 'package:bmi_calculator/model/state.dart';
import 'package:bmi_calculator/screens/name_page.dart';
import 'package:flutter/material.dart';

class NameConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModelName>(
      model: ViewModelName(),
      builder: (BuildContext context, ViewModelName vm) =>
          NamePage(
            onChangePage: vm.onChangePage,
            name: vm.userName,
          ),
    );
  }
}

class ViewModelName extends BaseModel<AppState> {
  ViewModelName();

  String userName;
  VoidCallback onChangePage;

  //_name.length > 10 ? _name.substring(0, 10) : _name

  ViewModelName.build({
    @required this.onChangePage,
    @required this.userName,});

  @override
  ViewModelName fromStore() => ViewModelName.build(
        onChangePage: () => dispatch(NavigateAction.pushNamed("/bmiPage")),
      );
}
