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

  bool get canRemoveCharacter => characterCount > 2;

  bool get canAddCharacter => characterCount < 99;

  bool get canStartGame => characterCount >= 2;
}
