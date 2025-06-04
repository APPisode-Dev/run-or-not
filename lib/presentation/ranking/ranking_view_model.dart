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
      List<(String, int, int?)> characterTuples,
      ): _state = RankingState(
      characterList: characterTuples.map((tuples) {

      return CustomCharacter(
        name: tuples.$1,
        hexColor: tuples.$2,
        rank: tuples.$3
      );
    }).toList(),
  );

  void onIntent(RankingIntent intent) {
    switch (intent) {
    }
  }
}
