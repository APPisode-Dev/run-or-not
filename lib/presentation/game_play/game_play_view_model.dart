import 'dart:async';

import 'package:flutter/material.dart';
import 'package:run_or_not/domain/const/motion_effect_rule.dart';
import 'package:run_or_not/domain/use_case/game/game_use_case.dart';
import 'package:run_or_not/presentation/core/const/widget_sizes.dart';
import 'package:run_or_not/presentation/game_play/game_play_intent.dart';
import 'package:run_or_not/presentation/game_play/game_play_state.dart';
import 'package:run_or_not/presentation/router/app_screen.dart';
import 'package:run_or_not/presentation/router/service/router_service.dart';

class GamePlayViewModel extends ChangeNotifier {
  final RouterService _routerService;
  final GameUseCase _gameUseCase;
  GamePlayState _state;
  GamePlayState get state => _state;
  Timer? _timer;

  GamePlayViewModel(
    this._routerService,
    List<(String, String)> characterTuples,
    GameUseCase gameUseCase,
  ) : _state = GamePlayState(
        characterList: gameUseCase.createInitialCharacters(characterTuples),
      ),
      _gameUseCase = gameUseCase;

  @override
  void dispose() {
    _timerDispose();
    super.dispose();
  }

  void _timerDispose() {
    _timer?.cancel();
    _timer = null;
  }

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
      case RankingButtonTapped():
        final charactersTuples =
            _state.characterList.map((character) {
              return (character.name, character.assetName, character.rank);
            }).toList();
        _routerService.navigateTo(
          AppScreen.ranking.path,
          extra: charactersTuples,
        );
        break;
      case StartButtonTapped():
        await send(SetGameStart(true));
        _timer?.cancel();

        _timer = Timer.periodic(MotionEffectRule.gameTickDuration, (
          timer,
        ) async {
          await send(UpdatePositionXWithSpeed());

          final isAllPlayerFinish = _state.characterList.every(
            (character) => character.isFinished,
          );
          if (isAllPlayerFinish) {
            _timerDispose();
            await send(SetGameStart(false));
          }
        });
        break;
      case RetryButtonTapped():
        final resetCharacters = _gameUseCase.resetCharacters(
          _state.characterList,
        );
        await send(SetCharacterList(resetCharacters));
        await send(StartButtonTapped());
        break;
      case UpdatePositionXWithSpeed():
        final maxDeviceWidth =
            _state.maxDeviceWidth -
            (WidgetSizes.avatarCircleSize + _state.horizontalSafeArea);
        final updatedCharacters = _gameUseCase.moveCharactersAndAssignRanks(
          maxDeviceWidth,
          _state.characterList,
        );
        await send(SetCharacterList(updatedCharacters));
        break;
      default:
        break;
    }
  }

  GamePlayState reduce(GamePlayState current, GamePlayIntent intent) {
    switch (intent) {
      case SetCharacterList(:final characters):
        return current.copyWith(characterList: characters);
      case UpdateMaxDeviceWidthAndSafeArea(
        :final maxDeviceWidth,
        :final horizontalSafeArea,
      ):
        return current.copyWith(
          maxDeviceWidth: maxDeviceWidth,
          horizontalSafeArea: horizontalSafeArea,
        );
      case SetGameStart(:final isStart):
        return current.copyWith(isStarting: isStart);
      default:
        return current;
    }
  }
}
