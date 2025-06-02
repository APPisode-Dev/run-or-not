import 'package:run_or_not/domain/model/character/custom_character.dart';

class GamePlayState {
  final int count;
  final List<CustomCharacter> characters;

  GamePlayState({
    this.count = 0,
    required this.characters,
  });

  GamePlayState copyWith({
    int? count,
    List<CustomCharacter>? characters,
  }) {
    return GamePlayState(
        count: count ?? this.count,
        characters: characters ?? this.characters,
    );
  }
}