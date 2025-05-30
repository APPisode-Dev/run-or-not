import 'package:flutter/material.dart';
import 'package:run_or_not/presentation/router/service/router_service.dart';

import 'game_play_intent.dart';

class GamePlayState {
  final int count;
  GamePlayState({this.count = 0});

  GamePlayState copyWith({int? count}) {
    return GamePlayState(count: count ?? this.count);
  }
}

class GamePlayViewModel extends ChangeNotifier {
  final RouterService _routerService;

  GamePlayViewModel(this._routerService);

  GamePlayState _state = GamePlayState();
  GamePlayState get state => _state;

  Future<void> send(GamePlayIntent intent) async {
    final newState = reduce(_state, intent);
    if (newState != _state) {
      _state = newState;
      notifyListeners();
    }

    switch (intent) {
      case GoBackButtonTapped():
        _routerService.goBack();
        break;
    }
  }

  GamePlayState reduce(GamePlayState current, GamePlayIntent intent) {
    switch (intent) {
      default:
        return current;
    }
  }
}
