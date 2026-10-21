import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/presentation/navigation/routes.dart';

extension NavigationExtension on BuildContext {
  void pushArticleDetail({required String articleId}) =>
      push(NavigationRoute.articleDetail.path.replaceFirst(":$parameterId", articleId));
}
