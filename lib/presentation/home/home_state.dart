class HomeState {
  final bool isLoading;
  final String message;

  const HomeState({
    this.isLoading = false,
    this.message = ""
  });

  HomeState copyWith({
    bool? isLoading,
    String? message
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
    );
  }
}