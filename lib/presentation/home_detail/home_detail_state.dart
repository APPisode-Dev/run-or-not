class HomeDetailState {
  final bool isLoading;

  const HomeDetailState({
    this.isLoading = false,
  });

  HomeDetailState copyWith({
    bool? isLoading,
  }) {
    return HomeDetailState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}