enum AppScreen {
  home('/home'),
  homeDetail('/homeDetail'),
  gamePlay('/gamePlay'),
  ranking('/ranking'),
  setting('/setting');

  final String path;
  const AppScreen(this.path);
}