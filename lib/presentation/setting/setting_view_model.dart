import 'package:flutter/material.dart';
import 'package:run_or_not/presentation/router/service/router_service.dart';
import 'package:run_or_not/presentation/setting/setting_intent.dart';
import 'package:run_or_not/presentation/setting/setting_state.dart';

class SettingViewModel extends ChangeNotifier {
  final RouterService _routerService;

  SettingState _state = const SettingState();
  SettingState get state => _state;

  SettingViewModel(this._routerService);

  Future<void> send(SettingIntent intent) async {
    final newState = reduce(_state, intent);
    if (newState != _state) {
      _state = newState;
      notifyListeners();
    }

    switch (intent) {

    }
  }

  SettingState reduce(SettingState current, SettingIntent intent) {
    switch (intent) {
      default:
        return current;
    }
  }
}
