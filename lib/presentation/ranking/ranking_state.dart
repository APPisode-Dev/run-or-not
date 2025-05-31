class RankingState {
  final int count;
  RankingState({
    this.count = 0
  });

  RankingState copyWith({
    int? count
  }) {
    return RankingState(
        count: count ?? this.count
    );
  }
}