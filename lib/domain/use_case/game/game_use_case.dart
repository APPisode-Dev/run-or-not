import 'dart:math';

import 'package:run_or_not/core/utils/random_util.dart';
import 'package:run_or_not/domain/const/character_random_min_max.dart';
import 'package:run_or_not/domain/const/game_probability.dart';
import 'package:run_or_not/domain/model/character/custom_character.dart';

class GameUseCase {
  final Random _random = Random();

  List<CustomCharacter> moveCharactersAndAssignRanks(
    double avatarSize,
    double maxDeviceWidth,
    List<CustomCharacter> characterList,
  ) {
    final _updatedCharacterList = _updateCharactersPosition(
        avatarSize,
        maxDeviceWidth,
        characterList
    );

    final _rankedList = _updateRanks(_updatedCharacterList);
    return _rankedList;
  }

  List<CustomCharacter> _updateCharactersPosition(
    double avatarSize,
    double maxDeviceWidth,
    List<CustomCharacter> characterList,
  ) {
    return characterList.map((character) {
      final _hasFinished = character.isFinished;
      final _reachedGoal = character.positionX >= maxDeviceWidth;

      if (_hasFinished) {
        return character;
      }

      if (_reachedGoal) {
        return character.copyWith(isFinished: true);
      }

      double newSpeed = _boostRandomSpeedWithChaos(character.speed);

      return character.copyWith(
        positionX: character.positionX + newSpeed,
        speed: _changeSpeedRandomlyEachCheckPoint(character.speed, character.positionX),
      );
    }).toList();
  }

  List<CustomCharacter> _updateRanks(List<CustomCharacter> characterList) {
    final _unrankedFinished =
        characterList.where((character) => character.isFinished && character.rank == 0).toList()
          ..sort(
            (a, b) => b.positionX.compareTo(a.positionX),
          ); // positionX 큰 순서대로

    int _nextRank = characterList.where((character) => character.rank != 0).length + 1;

    final _rankedList =
        characterList.map((character) {
          if (_unrankedFinished.contains(character)) {
            final assignedRank = _nextRank++;
            return character.copyWith(rank: assignedRank);
          }
          return character;
        }).toList();

    return _rankedList;
  }

  double _boostRandomSpeedWithChaos(double originalSpeed) {
    if (_random.nextDouble() < GameProbability.boostSpeedWithChaos) {
      double newSpeed = originalSpeed * (2 + _random.nextDouble() * 3);
      if (_random.nextBool()) {
        newSpeed *= -1;
      }

      return newSpeed;
    } else {
      return originalSpeed;
    }
  }

  double _changeSpeedRandomlyEachCheckPoint(double speed, double positionX) {
    int checkpoint = 100;

    if ((positionX ~/ checkpoint) != (positionX + speed) ~/ checkpoint) {
      return RandomUtil.getDoubleMinMaxRangeValue(CharacterRandomMinMax.randomMin, CharacterRandomMinMax.randomMax);
    } else {
      return speed;
    }
  }
}
