import 'dart:math';

import 'package:run_or_not/domain/const/character_random_min_max.dart';
import 'package:run_or_not/domain/const/game_probability.dart';
import 'package:run_or_not/domain/const/motion_effect_rule.dart';
import 'package:run_or_not/domain/model/character/custom_character.dart';
import 'package:run_or_not/domain/model/character/motion_effect.dart';

class GameUseCase {
  final Random _random;

  GameUseCase({Random? random}) : _random = random ?? Random();

  List<CustomCharacter> createInitialCharacters(
    Iterable<(String, String)> characterTuples,
  ) {
    return characterTuples.map((character) {
      return CustomCharacter(
        name: character.$1,
        assetName: character.$2,
        speed: _randomDoubleInRange(
          CharacterRandomMinMax.randomMin,
          CharacterRandomMinMax.randomMax,
        ),
      );
    }).toList();
  }

  List<CustomCharacter> resetCharacters(Iterable<CustomCharacter> characters) {
    return createInitialCharacters(
      characters.map((character) => (character.name, character.assetName)),
    );
  }

  List<CustomCharacter> moveCharactersAndAssignRanks(
    double maxDeviceWidth,
    List<CustomCharacter> characterList,
  ) {
    final _updatedCharacterList = _updateCharactersPosition(
      maxDeviceWidth,
      characterList,
    );

    final _rankedList = _updateRanks(_updatedCharacterList);
    return _rankedList;
  }

  List<CustomCharacter> _updateCharactersPosition(
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
        return character.copyWith(
          isFinished: true,
          motionEffect: MotionEffect.normal,
          effectRemainingTicks: 0,
          speedMultiplier: 1,
        );
      }

      return _updateCharacterMotion(character);
    }).toList();
  }

  CustomCharacter _updateCharacterMotion(CustomCharacter character) {
    return switch (character.motionEffect) {
      MotionEffect.stopped => _continueStoppedEffect(character),
      MotionEffect.slowDown => _continueSlowDownEffect(character),
      MotionEffect.boost ||
      MotionEffect.reverse => _finishTransientEffect(character),
      MotionEffect.normal => _moveWithPossibleSpecialEffect(character),
    };
  }

  CustomCharacter _moveWithPossibleSpecialEffect(CustomCharacter character) {
    final eventRoll = _random.nextDouble();
    final stoppedThreshold = GameProbability.stopped;
    final slowDownThreshold = stoppedThreshold + GameProbability.slowDown;
    final chaosThreshold = slowDownThreshold + GameProbability.chaos;

    if (eventRoll < stoppedThreshold) {
      return character.copyWith(
        motionEffect: MotionEffect.stopped,
        effectRemainingTicks: MotionEffectRule.stoppedTicks,
      );
    }

    if (eventRoll < slowDownThreshold) {
      final multiplier = _randomDoubleInRange(
        MotionEffectRule.slowDownMinMultiplier,
        MotionEffectRule.slowDownMaxMultiplier,
      );
      return _moveCharacter(
        character,
        character.speed * multiplier,
        motionEffect: MotionEffect.slowDown,
        effectRemainingTicks: MotionEffectRule.slowDownTicks,
        speedMultiplier: multiplier,
      );
    }

    if (eventRoll < chaosThreshold) {
      return _applyChaosEffect(character);
    }

    return _moveCharacter(character, character.speed);
  }

  CustomCharacter _continueStoppedEffect(CustomCharacter character) {
    if (character.effectRemainingTicks <= 1) {
      return _moveCharacter(character, character.speed);
    }

    return character.copyWith(
      effectRemainingTicks: character.effectRemainingTicks - 1,
    );
  }

  CustomCharacter _continueSlowDownEffect(CustomCharacter character) {
    if (character.effectRemainingTicks <= 1) {
      return _moveCharacter(character, character.speed);
    }

    return _moveCharacter(
      character,
      character.speed * character.speedMultiplier,
      motionEffect: MotionEffect.slowDown,
      effectRemainingTicks: character.effectRemainingTicks - 1,
      speedMultiplier: character.speedMultiplier,
    );
  }

  CustomCharacter _finishTransientEffect(CustomCharacter character) {
    return _moveCharacter(character, character.speed);
  }

  CustomCharacter _applyChaosEffect(CustomCharacter character) {
    final multiplier = _randomDoubleInRange(
      MotionEffectRule.chaosMinMultiplier,
      MotionEffectRule.chaosMaxMultiplier,
    );
    final isReverse = _random.nextBool();
    final appliedSpeed = character.speed * multiplier * (isReverse ? -1 : 1);

    return _moveCharacter(
      character,
      appliedSpeed,
      motionEffect: isReverse ? MotionEffect.reverse : MotionEffect.boost,
      effectRemainingTicks: MotionEffectRule.transientEffectTicks,
    );
  }

  CustomCharacter _moveCharacter(
    CustomCharacter character,
    double appliedSpeed, {
    MotionEffect motionEffect = MotionEffect.normal,
    int effectRemainingTicks = 0,
    double speedMultiplier = 1,
  }) {
    return character.copyWith(
      positionX: character.positionX + appliedSpeed,
      speed: _changeSpeedRandomlyEachCheckPoint(
        character.speed,
        character.positionX,
        appliedSpeed,
      ),
      motionEffect: motionEffect,
      effectRemainingTicks: effectRemainingTicks,
      speedMultiplier: speedMultiplier,
    );
  }

  List<CustomCharacter> _updateRanks(List<CustomCharacter> characterList) {
    final _unrankedFinished =
        characterList
            .where((character) => character.isFinished && character.rank == 0)
            .toList()
          ..sort(
            (a, b) => b.positionX.compareTo(a.positionX),
          ); // positionX 큰 순서대로

    int _nextRank =
        characterList.where((character) => character.rank != 0).length + 1;

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

  double _changeSpeedRandomlyEachCheckPoint(
    double speed,
    double positionX,
    double appliedSpeed,
  ) {
    const checkpoint = 100;

    if ((positionX ~/ checkpoint) != (positionX + appliedSpeed) ~/ checkpoint) {
      return _randomDoubleInRange(
        CharacterRandomMinMax.randomMin,
        CharacterRandomMinMax.randomMax,
      );
    }

    return speed;
  }

  double _randomDoubleInRange(double min, double max) {
    return min + (max - min) * _random.nextDouble();
  }
}
