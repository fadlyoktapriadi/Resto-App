enum NavigationRoute {
  mainRoute("/"),
  detailRoute("/detail"),
  favoriteRoute("/favorite"),
  settingRoute("/settings");

  const NavigationRoute(this.name);
  final String name;
}