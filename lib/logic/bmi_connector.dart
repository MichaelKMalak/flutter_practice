import 'package:async_redux/async_redux.dart';
import 'package:bmi_calculator/model/state.dart';
import 'package:bmi_calculator/screens/bmi_page.dart';
import 'package:flutter/material.dart';

class BmiConnector extends StatelessWidget {

  const BmiConnector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _name = AppState().name ?? 'hamada';
    return StoreConnector<AppState, ViewModelBmi>(
      model: ViewModelBmi(),
      builder: (BuildContext context, ViewModelBmi vm) => BmiPage(
        name: _name.length > 10 ? _name.substring(0, 10) : _name,
        onChangePage: vm.onChangePage,
      ),
    );
  }
}

class ViewModelBmi extends BaseModel<AppState> {
  ViewModelBmi();

  VoidCallback onChangePage;

  ViewModelBmi.build({@required this.onChangePage});

  @override
  ViewModelBmi fromStore() => ViewModelBmi.build(
        onChangePage: () => dispatch(NavigateAction.pushNamed("/resultPage")),
      );
}
