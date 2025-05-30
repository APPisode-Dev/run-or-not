sealed class HomeIntent {}

class SetLoading extends HomeIntent {
  final bool isLoading;
  SetLoading(this.isLoading);
}

class ChangeText extends HomeIntent {
  final String value;
  ChangeText(this.value);
}

class ChangeButtonTapped extends HomeIntent {}

class NavigateToGamePlay extends HomeIntent {}