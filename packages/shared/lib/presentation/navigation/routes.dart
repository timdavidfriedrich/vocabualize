const parameterId = "id";

enum NavigationRoute {
  home("/home"),
  articleDetail("/home/:$parameterId");

  const NavigationRoute(this.path);

  final String path;
}
