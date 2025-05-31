class GamePlayState {
  final int count;
  GamePlayState({
    this.count = 0
  });

  GamePlayState copyWith({
    int? count
  }) {
    return GamePlayState(
        count: count ?? this.count
    );
  }
}