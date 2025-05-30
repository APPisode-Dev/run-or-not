enum AppScreen {
  home('/home'),
  gamePlay('/gamePlay'),
  ranking('/ranking');

  final String path;
  const AppScreen(this.path);
}