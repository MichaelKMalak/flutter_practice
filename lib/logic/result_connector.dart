import 'package:async_redux/async_redux.dart';
import 'package:bmi_calculator/logic/calculator.dart';
import 'package:bmi_calculator/model/state.dart';
import 'package:bmi_calculator/screens/result_page.dart';
import 'package:flutter/material.dart';

class ResultConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModelResult>(
      model: ViewModelResult(),
      builder: (BuildContext context, ViewModelResult vm) => ResultPage(
        bmi: vm.bmi,
        bmiEvaluation: vm.bmiEvaluation,
        onChangeBmi: vm.onChangeBmi,
        onChangeName: vm.onChangeName,
      ),
    );
  }
}

class ViewModelResult extends BaseModel<AppState> {
  ViewModelResult();

  VoidCallback onChangeBmi;
  VoidCallback onChangeName;
  String bmi;
  String bmiEvaluation;

  ViewModelResult.build(
      {@required this.bmi,
      @required this.bmiEvaluation,
      @required this.onChangeBmi,
      @required this.onChangeName});

  @override
  ViewModelResult fromStore() => ViewModelResult.build(
        bmi: calculateBMI(
          height: state.height,
          weight: state.weight,
        ).toStringAsFixed(1),
        bmiEvaluation: evaluateBMI(
            bmiStr: calculateBMI(
          height: state.height,
          weight: state.weight,
        ).toStringAsFixed(1)),
        onChangeBmi: () => dispatch(NavigateAction.pop()),
        onChangeName: () => dispatch(NavigateAction.popUntil("/")),
      );
}

////////////////////////////////////////////////////

class SaveNameAction extends ReduxAction<AppState> {
  final String name;

  SaveNameAction(this.name);

  @override
  AppState reduce() {
    return state.copy(name: name);
  }
}
