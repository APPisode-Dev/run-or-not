import 'package:flutter/material.dart';
import 'package:run_or_not/domain/model/character/custom_character.dart';
import 'package:run_or_not/presentation/ranking/ranking_intent.dart';
import 'package:run_or_not/presentation/ranking/ranking_state.dart';
import 'package:run_or_not/presentation/router/service/router_service.dart';

class RankingViewModel extends ChangeNotifier {
  final RouterService _routerService;

  RankingState _state;
  RankingState get state => _state;

  RankingViewModel(
      this._routerService,
      List<(String, String, int)> characterTuples,
      ): _state = RankingState(
      characterList: _sortedCharacters(characterTuples),
  );

  static List<CustomCharacter> _sortedCharacters(List<(String, String, int)> characterTuples) {
    final list = characterTuples.map((tuples) {
      return CustomCharacter(
        name: tuples.$1,
        assetName: tuples.$2,
        rank: tuples.$3,
      );
    }).toList();

    list.sort((a, b) => a.rank.compareTo(b.rank));

    return list;
  }

  Future<void> send(RankingIntent intent) async {
    final newState = reduce(_state, intent);
    if (newState != _state) {
      _state = newState;
      notifyListeners();
    }

    switch (intent) {
      case HomeButtonTapped():
        _routerService.goRoot();
        break;
    }
  }

  RankingState reduce(RankingState current, RankingIntent intent) {
    switch (intent) {
      default:
        return current;
    }
  }
}
