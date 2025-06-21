import 'package:run_or_not/presentation/core/const/app_assets.dart';

class HomeDetailState {
  final List<String> characterNames;
  final List<String> characterImages;
  final AlertCase? alertCase;
  final bool hasReplaceRouter;

  const HomeDetailState({
    this.characterNames = const ['', ''],
    this.characterImages = const [AppAssets.horseYellow, AppAssets.horseBlue],
    this.alertCase,
    this.hasReplaceRouter = false,
  });

  HomeDetailState copyWith({
    List<String>? characterNames,
    List<String>? characterImages,
    AlertCase? alertCase,
    bool? hasReplaceRouter,
  }) {
    return HomeDetailState(
      characterNames: characterNames ?? this.characterNames,
      characterImages: characterImages ?? this.characterImages,
      alertCase: alertCase,
      hasReplaceRouter: hasReplaceRouter ?? this.hasReplaceRouter,
    );
  }

  int get characterCount => characterNames.length;

  bool get canRemoveCharacter => characterCount > 2;

  bool get canAddCharacter => characterCount < 99;

  bool get canStartGame => characterCount >= 2;
}

sealed class AlertCase {}
class SelectCharacterAlert extends AlertCase {
  final int index;

  SelectCharacterAlert(this.index);
}