import 'package:flutter/material.dart';
import 'package:run_or_not/presentation/home/home_intent.dart';
import 'package:run_or_not/presentation/home/home_state.dart';
import 'package:run_or_not/presentation/router/app_screen.dart';
import 'package:run_or_not/presentation/router/service/router_service.dart';

class HomeViewModel extends ChangeNotifier {
  final RouterService _routerService;

  HomeViewModel(this._routerService);

  HomeState _state = const HomeState();
  HomeState get state => _state;

  Future<void> send(HomeIntent intent) async {
    final newState = reduce(_state, intent);
    if (newState != _state) {
      _state = newState;
      notifyListeners();
    }

    switch (intent) {
      case StartButtonTapped():
        _routerService.navigateTo(AppScreen.homeDetail.path);
        break;
      case SettingButtonTapped():
        _routerService.navigateTo(AppScreen.setting.path);
        break;
    }
  }

  HomeState reduce(HomeState current, HomeIntent intent) {
    switch (intent) {
      default:
        return current;
      }
  }
}