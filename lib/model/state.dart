import 'package:async_redux/async_redux.dart';

class AppState {
  final String name;

  AppState({this.name});

  AppState copy({String name, Event<String> nameChanged}) =>
      AppState(name: name ?? this.name);

  static AppState initialState() => AppState(name: "");

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;
}
