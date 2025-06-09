import 'package:flutter/material.dart';
import 'package:run_or_not/presentation/core/const/app_assets.dart';
import 'package:run_or_not/presentation/home_detail/home_detail_intent.dart';
import 'package:run_or_not/presentation/home_detail/home_detail_state.dart';
import 'package:run_or_not/presentation/router/app_screen.dart';
import 'package:run_or_not/presentation/router/service/router_service.dart';

class HomeDetailViewModel extends ChangeNotifier {
  final RouterService _routerService;

  HomeDetailState _state = const HomeDetailState();
  HomeDetailState get state => _state;

  HomeDetailViewModel(this._routerService);

  Future<void> send(HomeDetailIntent intent) async {
    final newState = reduce(_state, intent);
    if (newState != _state) {
      _state = newState;
      notifyListeners();
    }

    switch (intent) {
      case NavigateToGamePlay():
        if (_state.canStartGame) {
          final characterTuples =
              _state.characterNames
                  .asMap()
                  .entries
                  .where((entry) => entry.value.trim().isNotEmpty)
                  .map((entry) {
                    final index = entry.key;
                    final name = entry.value;
                    final imagePath = _state.characterImages[index];
                    return (name, imagePath);
                  })
                  .toList();

          _routerService.navigateTo(
            AppScreen.gamePlay.path,
            extra: characterTuples,
          );
        }
        break;
      default:
        break;
    }
  }

  HomeDetailState reduce(HomeDetailState current, HomeDetailIntent intent) {
    switch (intent) {
      case AddCharacter():
        if (current.canAddCharacter) {
          final newNames = [...current.characterNames];
          final newImages = [...current.characterImages];

          final newIndex = newNames.length + 1;
          newNames.add('$newIndex');

          final imageIndex = newImages.length % _availableImages.length;
          newImages.add(_availableImages[imageIndex]);

          return current.copyWith(
            characterNames: newNames,
            characterImages: newImages,
          );
        }
        return current;

      case RemoveCharacter(:final index):
        if (current.canRemoveCharacter &&
            index >= 0 &&
            index < current.characterNames.length) {
          final newNames = [...current.characterNames];
          final newImages = [...current.characterImages];

          newNames.removeAt(index);
          newImages.removeAt(index);

          return current.copyWith(
            characterNames: newNames,
            characterImages: newImages,
          );
        }
        return current;

      case UpdateCharacterName(:final index, :final name):
        if (index >= 0 && index < current.characterNames.length) {
          final newNames = [...current.characterNames];
          newNames[index] = name;
          return current.copyWith(characterNames: newNames);
        }
        return current;

      case UpdateCharacterImage(:final index, :final imagePath):
        if (index >= 0 && index < current.characterImages.length) {
          final newImages = [...current.characterImages];
          newImages[index] = imagePath;
          return current.copyWith(characterImages: newImages);
        }
        return current;

      default:
        return current;
    }
  }

  static const List<String> _availableImages = [
    AppAssets.horseYellow,
    AppAssets.horseBlue,
    AppAssets.horseRed,
    AppAssets.horseGreen,
  ];
}
