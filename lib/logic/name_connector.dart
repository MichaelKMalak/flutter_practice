import 'package:async_redux/async_redux.dart';
import 'package:bmi_calculator/model/app_state.dart';
import 'package:bmi_calculator/screens/name_page.dart';
import 'package:flutter/material.dart';

class NameConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModelName>(
      model: ViewModelName(),
      builder: (BuildContext context, ViewModelName vm) =>
          NamePage(
            onSaveName: vm.onSaveName,
            onChangePage: vm.onChangePage,
          ),
    );
  }
}

class ViewModelName extends BaseModel<AppState> {
  ViewModelName();

  ValueChanged<String> onSaveName;
  VoidCallback onChangePage;

  ViewModelName.build({
    @required this.onChangePage,
    @required this.onSaveName,});

  @override
  ViewModelName fromStore() => ViewModelName.build(
    onSaveName: (String name) => dispatch(SaveUserAction(name)),
    onChangePage: () => dispatch(NavigateAction.pushNamed("/bmiPage")),
  );
}

class SaveUserAction extends ReduxAction<AppState> {
  final String name;

  SaveUserAction(this.name);

  @override
  AppState reduce() {
    print('reducer: $name\n');
    print('appstatenow: ${AppState().name}');
    return state.copy(
        name: name); //name.length > 10 ? name.substring(0, 10) : name);
  }

  @override
  Object wrapError(error) => UserException("Save failed", cause: error);
}