import 'package:flutter/material.dart';
import 'package:run_or_not/presentation/setting/setting_intent.dart';
import 'package:run_or_not/presentation/setting/setting_state.dart';

class SettingViewModel extends ChangeNotifier {
  SettingState _state = const SettingState();
  SettingState get state => _state;

  SettingViewModel();

  Future<void> send(SettingIntent intent) async {
    final newState = reduce(_state, intent);
    if (newState != _state) {
      _state = newState;
      notifyListeners();
    }
  }

  SettingState reduce(SettingState current, SettingIntent intent) {
    return current;
  }
}
