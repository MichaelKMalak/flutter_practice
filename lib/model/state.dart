import 'package:async_redux/async_redux.dart';

import 'gender.dart';


class AppState {
  final String name;
  final Gender gender;
  final int height;
  final int weight;

  AppState({this.name, this.height, this.gender, this.weight});

  AppState copy({String name, Gender gender, int height, int weight, Event<
      String> nameChanged}) =>
      AppState(
          name: name ?? this.name,
          gender: gender ?? this.gender,
          height: height ?? this.height,
          weight: weight ?? this.weight);

  static AppState initialState() =>
      AppState(
          name: "", height: 180, weight: 30, gender: Gender.other);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              gender == other.gender &&
              height == other.height &&
              weight == other.weight;

  @override
  int get hashCode =>
      name.hashCode ^ gender.hashCode ^ height.hashCode ^ weight.hashCode;
}
