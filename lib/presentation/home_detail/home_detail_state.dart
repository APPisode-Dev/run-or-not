import 'package:flutter/foundation.dart';
import 'package:run_or_not/presentation/core/const/app_assets.dart';

class HomeDetailState {
  final List<String> characterNames;
  final List<String> characterImages;

  const HomeDetailState({
    this.characterNames = const ['', ''],
    this.characterImages = const [AppAssets.horseYellow, AppAssets.horseYellow],
  });

  HomeDetailState copyWith({
    List<String>? characterNames,
    List<String>? characterImages,
  }) {
    return HomeDetailState(
      characterNames: characterNames ?? this.characterNames,
      characterImages: characterImages ?? this.characterImages,
    );
  }

  int get characterCount => characterNames.length;

  bool get canRemoveCharacter => characterNames.length > 2;

  bool get canAddCharacter => characterNames.length < 99;

  bool get canStartGame => characterCount >= 2;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HomeDetailState &&
          runtimeType == other.runtimeType &&
          listEquals(characterNames, other.characterNames) &&
          listEquals(characterImages, other.characterImages));
  @override
  int get hashCode => Object.hash(characterNames, characterImages);
}
