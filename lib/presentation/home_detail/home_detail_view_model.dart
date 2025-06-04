import 'package:flutter/material.dart';
import 'package:run_or_not/presentation/home_detail/home_detail_intent.dart';
import 'package:run_or_not/presentation/home_detail/home_detail_state.dart';
import 'package:run_or_not/presentation/router/app_screen.dart';
import 'package:run_or_not/presentation/router/service/router_service.dart';

class HomeDetailViewModel extends ChangeNotifier {
  final RouterService _routerService;

  HomeDetailViewModel(this._routerService);

  HomeDetailState _state = const HomeDetailState();
  HomeDetailState get state => _state;

  Future<void> send(HomeDetailIntent intent) async {
    final newState = reduce(_state, intent);
    if (newState != _state) {
      _state = newState;
      notifyListeners();
    }

    switch (intent) {
      case NavigateToGamePlay():
        final dummyCharactersTuples = [
          ('말1', 0xFFE57373),
          ('말2', 0xFF64B5F6),
          ('말3', 0xFF81C784),
        ];

        _routerService.navigateTo(AppScreen.gamePlay.path, extra: dummyCharactersTuples);
        break;
      default:
        break;
    }
  }

  HomeDetailState reduce(HomeDetailState current, HomeDetailIntent intent) {
    switch (intent) {
      default:
        return current;
    }
  }
}