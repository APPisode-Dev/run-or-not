import 'package:flutter/material.dart';
import 'package:run_or_not/presentation/ranking/ranking_intent.dart';
import 'package:run_or_not/presentation/ranking/ranking_state.dart';

class RankingViewModel extends ChangeNotifier {
  RankingState _state = RankingState();
  RankingState get state => _state;

  void onIntent(RankingIntent intent) {
    switch (intent) {
    }
  }
}
