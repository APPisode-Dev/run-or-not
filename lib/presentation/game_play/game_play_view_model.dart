import 'package:flutter/material.dart';
import 'package:run_or_not/domain/model/character/custom_character.dart';
import 'package:run_or_not/presentation/game_play/game_play_intent.dart';
import 'package:run_or_not/presentation/game_play/game_play_state.dart';
import 'package:run_or_not/presentation/router/service/router_service.dart';

class GamePlayViewModel extends ChangeNotifier {
  final RouterService _routerService;
  GamePlayState _state;
  GamePlayState get state => _state;

  GamePlayViewModel(
      this._routerService,
      List<CustomCharacter> characters,
  ): _state = GamePlayState(characters: characters);

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
