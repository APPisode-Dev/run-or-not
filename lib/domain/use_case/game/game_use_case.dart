import 'package:run_or_not/domain/model/character/custom_character.dart';

class GameUseCase {
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

      return character.copyWith(
        positionX: character.positionX + character.speed,
      );
    }).toList();
  }

  List<CustomCharacter> _updateRanks(List<CustomCharacter> characterList) {
    final _unrankedFinished =
        characterList.where((c) => c.isFinished && c.rank == null).toList()
          ..sort(
            (a, b) => b.positionX.compareTo(a.positionX),
          ); // positionX 큰 순서대로

    int _nextRank = characterList.where((c) => c.rank != null).length + 1;

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
}
