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
      case ChangeButtonTapped():
        send(SetLoading(true));
        await _load();
        send(ChangeText("MVI Test~"));
        send(SetLoading(false));
        break;

      case NavigateToGamePlay():
        _routerService.navigateTo(AppScreen.gamePlay.path);
        break;

      default:
        break;
    }
  }

  HomeState reduce(HomeState current, HomeIntent intent) {
    switch (intent) {
      case ChangeText(:final value):
        return current.copyWith(
          message: value
        );
      case SetLoading(:final isLoading):
        return current.copyWith(isLoading: isLoading);
      default:
        return current;
      }
  }

  Future<void> _load() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}