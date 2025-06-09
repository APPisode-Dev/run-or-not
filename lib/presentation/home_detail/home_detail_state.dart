import 'package:flutter/foundation.dart';
import 'package:run_or_not/presentation/core/const/app_assets.dart';

class HomeDetailState {
  final List<String> characterNames;
  final List<String> characterImages;
  final bool isLoading;

  const HomeDetailState({
    this.characterNames = const ['1', '2'],
    this.characterImages = const [AppAssets.horseYellow, AppAssets.horseYellow],
    this.isLoading = false,
  });

  HomeDetailState copyWith({
    List<String>? characterNames,
    List<String>? characterImages,
    bool? isLoading,
  }) {
    return HomeDetailState(
      characterNames: characterNames ?? this.characterNames,
      characterImages: characterImages ?? this.characterImages,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  int get characterCount => characterNames.length;

  bool get canRemoveCharacter => characterNames.length > 2;

  bool get canAddCharacter => characterNames.length < 99;

  List<String> get validCharacterNames =>
      characterNames.where((name) => name.trim().isNotEmpty).toList();

  bool get canStartGame => validCharacterNames.length >= 2;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HomeDetailState &&
          runtimeType == other.runtimeType &&
          listEquals(characterNames, other.characterNames) &&
          listEquals(characterImages, other.characterImages) &&
          isLoading == other.isLoading);

  @override
  int get hashCode => Object.hash(characterNames, characterImages, isLoading);
}
