abstract interface class RouterService {
  void navigateTo(String path, {Object? extra});
  void goBack();
  void goRoot();
  void replace(String path, {Object? extra});
}