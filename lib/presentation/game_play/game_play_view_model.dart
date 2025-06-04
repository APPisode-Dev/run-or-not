import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:run_or_not/domain/model/character/custom_character.dart';
import 'package:run_or_not/domain/use_case/game/game_use_case.dart';
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
    List<(String, int)> characterTuples,
    this._gameUseCase,
  ): _state = GamePlayState(
    characterList: characterTuples.map((tuples) {
      final _name = tuples.$1;
      final _hexColor = tuples.$2;

      return CustomCharacter(
        name: _name,
        hexColor: _hexColor,
        speed: Random().nextInt(20) + 1,
        positionX: 0,
        isFinished: false,
      );
    }).toList(),
  );

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
        final charactersTuples = _state.characterList.map((character) {
          return (character.name, character.hexColor, character.rank);
        }).toList();
        _routerService.navigateTo(AppScreen.ranking.path, extra: charactersTuples);
        break;
      case TimerStartButtonTapped():
        _timer?.cancel();

        _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
          send(UpdatePositionXWithSpeed());

          bool _isAllPlayerFinish = _state.characterList.every((character) => character.isFinished);
          if (_isAllPlayerFinish) {
            _timerDispose();
          }
        });
        break;
      default:
        break;
    }
  }

  GamePlayState reduce(GamePlayState current, GamePlayIntent intent) {
    switch (intent) {
      case UpdatePositionXWithSpeed():
        final double _avatarCircleSize = 40;
        final double _maxDeviceWidth = current.maxDeviceWidth - (_avatarCircleSize + current.horizontalSafeArea);

        final _updatedCharacterList = _gameUseCase.moveCharactersAndAssignRanks(
            _avatarCircleSize,
            _maxDeviceWidth,
            current.characterList
        );

        return current.copyWith(characterList: _updatedCharacterList);
      case UpdateMaxDeviceWidthAndSafeArea(:final maxDeviceWidth, :final horizontalSafeArea):
        return current.copyWith(maxDeviceWidth: maxDeviceWidth, horizontalSafeArea: horizontalSafeArea);
      default:
        return current;
    }
  }
}
