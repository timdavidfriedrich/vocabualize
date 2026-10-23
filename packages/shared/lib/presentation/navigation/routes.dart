import 'package:kaisel/kaisel.dart';

sealed class AppRoute extends KaiselRoute {
  const AppRoute();
}

class const Home() extends AppRoute;

class const ArticleDetail({
  required final String articleId,
}) extends AppRoute {
  @override
  List<Object?> get props => [articleId];
}
