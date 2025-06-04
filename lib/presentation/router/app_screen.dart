enum AppScreen {
  home('/home'),
  homeDetail('/homeDetail'),
  gamePlay('/gamePlay'),
  ranking('/ranking');

  final String path;
  const AppScreen(this.path);
}