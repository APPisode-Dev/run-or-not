import 'package:run_or_not/domain/model/character/custom_character.dart';

class GamePlayState {
  final List<CustomCharacter> characterList;
  final double maxDeviceWidth;
  final double horizontalSafeArea;

  GamePlayState({
    required this.characterList,
    this.maxDeviceWidth = 376,
    this.horizontalSafeArea = 0,
  });

  GamePlayState copyWith({
    List<CustomCharacter>? characterList,
    double? maxDeviceWidth,
    double? horizontalSafeArea,
  }) {
    return GamePlayState(
      characterList: characterList ?? this.characterList,
      maxDeviceWidth: maxDeviceWidth ?? this.maxDeviceWidth,
      horizontalSafeArea: horizontalSafeArea ?? this.horizontalSafeArea,
    );
  }
}