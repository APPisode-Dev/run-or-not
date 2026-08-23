import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:run_or_not/domain/const/game_probability.dart';
import 'package:run_or_not/domain/const/motion_effect_rule.dart';
import 'package:run_or_not/domain/model/character/custom_character.dart';
import 'package:run_or_not/domain/model/character/motion_effect.dart';
import 'package:run_or_not/domain/use_case/game/game_use_case.dart';

void main() {
  const maxDeviceWidth = 1000.0;

  CustomCharacter moveOnce(GameUseCase useCase, CustomCharacter character) {
    return useCase.moveCharactersAndAssignRanks(maxDeviceWidth, [
      character,
    ]).single;
  }

  test('uses final special effect probabilities', () {
    expect(GameProbability.stopped, 0.0015);
    expect(GameProbability.slowDown, 0.002);
    expect(GameProbability.chaos, 0.002);
    expect(GameProbability.chaos / 2, 0.001);
  });

  test('creates initial characters with domain-owned random speed', () {
    final useCase = GameUseCase(random: _SequenceRandom(doubles: [0.5]));

    final characters = useCase.createInitialCharacters([
      ('horse', 'horse.riv'),
    ]);

    expect(characters.single.name, 'horse');
    expect(characters.single.assetName, 'horse.riv');
    expect(characters.single.speed, 5);
    expect(characters.single.motionEffect, MotionEffect.normal);
  });

  test('stopped effect blocks movement for exactly one second', () {
    final useCase = GameUseCase(random: _SequenceRandom(doubles: [0]));
    var character = moveOnce(useCase, _character());

    expect(character.motionEffect, MotionEffect.stopped);
    expect(character.effectRemainingTicks, MotionEffectRule.stoppedTicks);
    expect(character.positionX, 50);

    for (var tick = 1; tick < MotionEffectRule.stoppedTicks; tick++) {
      character = moveOnce(useCase, character);
      expect(character.motionEffect, MotionEffect.stopped);
      expect(character.positionX, 50);
    }

    character = moveOnce(useCase, character);

    expect(character.motionEffect, MotionEffect.normal);
    expect(character.effectRemainingTicks, 0);
    expect(character.positionX, 52);
  });

  test('slow down lasts 1.5 seconds and keeps its multiplier', () {
    final useCase = GameUseCase(random: _SequenceRandom(doubles: [0.002, 0]));
    var character = moveOnce(useCase, _character());

    expect(character.motionEffect, MotionEffect.slowDown);
    expect(character.effectRemainingTicks, MotionEffectRule.slowDownTicks);
    expect(character.speedMultiplier, MotionEffectRule.slowDownMinMultiplier);
    expect(character.positionX, closeTo(50.6, 0.0001));

    for (var tick = 1; tick < MotionEffectRule.slowDownTicks; tick++) {
      character = moveOnce(useCase, character);
      expect(character.motionEffect, MotionEffect.slowDown);
    }

    final positionBeforeNormalMove = character.positionX;
    character = moveOnce(useCase, character);

    expect(character.motionEffect, MotionEffect.normal);
    expect(character.effectRemainingTicks, 0);
    expect(character.speedMultiplier, 1);
    expect(character.positionX, closeTo(positionBeforeNormalMove + 2, 0.0001));
  });

  test('chaos applies one 4x to 7x reverse burst', () {
    final useCase = GameUseCase(
      random: _SequenceRandom(doubles: [0.004, 0.5], bools: [true]),
    );
    var character = moveOnce(useCase, _character());

    expect(character.motionEffect, MotionEffect.reverse);
    expect(
      character.effectRemainingTicks,
      MotionEffectRule.transientEffectTicks,
    );
    expect(character.positionX, 39);

    character = moveOnce(useCase, character);

    expect(character.motionEffect, MotionEffect.normal);
    expect(character.positionX, 41);
  });
}

CustomCharacter _character() {
  return const CustomCharacter(
    name: 'test horse',
    assetName: 'test.riv',
    speed: 2,
    positionX: 50,
  );
}

class _SequenceRandom implements Random {
  final List<double> _doubles;
  final List<bool> _bools;
  int _doubleIndex = 0;
  int _boolIndex = 0;

  _SequenceRandom({required List<double> doubles, List<bool> bools = const []})
    : _doubles = doubles,
      _bools = bools;

  @override
  bool nextBool() => _bools[_boolIndex++];

  @override
  double nextDouble() => _doubles[_doubleIndex++];

  @override
  int nextInt(int max) => 0;
}
