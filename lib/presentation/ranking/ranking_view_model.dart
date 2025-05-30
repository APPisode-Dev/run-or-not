import 'package:flutter/material.dart';

enum RankingIntent { increment }

class RankingState {
  final int count;
  RankingState({this.count = 0});

  RankingState copyWith({int? count}) {
    return RankingState(count: count ?? this.count);
  }
}

class RankingViewModel extends ChangeNotifier {
  RankingState _state = RankingState();
  RankingState get state => _state;

  void onIntent(RankingIntent intent) {
    switch (intent) {
      case RankingIntent.increment:
        _state = _state.copyWith(count: _state.count + 1);
        notifyListeners();
    }
  }
}
