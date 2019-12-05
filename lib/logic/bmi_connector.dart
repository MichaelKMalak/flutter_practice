import 'package:async_redux/async_redux.dart';
import 'package:bmi_calculator/model/gender.dart';
import 'package:bmi_calculator/model/state.dart';
import 'package:bmi_calculator/screens/bmi_page.dart';
import 'package:flutter/material.dart';

class BmiConnector extends StatelessWidget {
  const BmiConnector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModelBmi>(
      model: ViewModelBmi(),
      builder: (BuildContext context, ViewModelBmi vm) => BmiPage(
        name: vm.name,
        onChangeGender: vm.onChangeGender,
        onChangeHeight: vm.onChangeHeight,
        onChangeWeight: vm.onChangeWeight,
        onChangePage: vm.onChangePage,
      ),
    );
  }
}

////////////////////////////////////////////////////

class SaveGenderAction extends ReduxAction<AppState> {
  final Gender gender;

  SaveGenderAction(this.gender);

  @override
  AppState reduce() {
    return state.copy(gender: gender);
  }
}

////////////////////////////////////////////////////

class SaveHeightAction extends ReduxAction<AppState> {
  final int height;

  SaveHeightAction(this.height);

  @override
  AppState reduce() {
    return state.copy(height: height);
  }
}
////////////////////////////////////////////////////

class SaveWeightAction extends ReduxAction<AppState> {
  final int weight;

  SaveWeightAction(this.weight);

  @override
  AppState reduce() {
    return state.copy(weight: weight);
  }
}
class ViewModelBmi extends BaseModel<AppState> {
  String name;

  VoidCallback onChangePage;
  ValueChanged<Gender> onChangeGender;
  ValueChanged<int> onChangeHeight;
  ValueChanged<int> onChangeWeight;

  ViewModelBmi();

  ViewModelBmi.build({
    @required this.onChangePage,
    @required this.name,
    @required this.onChangeWeight,
    @required this.onChangeHeight,
    @required this.onChangeGender,
  });

  @override
  ViewModelBmi fromStore() => ViewModelBmi.build(
    name: state.name,
    onChangeWeight: (int weight) => dispatch(SaveWeightAction(weight)),
    onChangeHeight: (int height) => dispatch(SaveHeightAction(height)),
    onChangeGender: (Gender gender) => dispatch(SaveGenderAction(gender)),
    onChangePage: () =>
        dispatch(
          NavigateAction.pushNamed("/resultPage"),
        ),
      );
}
