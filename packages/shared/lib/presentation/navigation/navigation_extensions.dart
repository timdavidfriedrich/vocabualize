import 'package:flutter/widgets.dart';
import 'package:kaisel/kaisel.dart';
import 'package:shared/presentation/navigation/routes.dart';

extension NavigationExtension on BuildContext {
  KaiselRouter<AppRoute> get appRouter => router<AppRoute>();

  Future<void> pushArticleDetail({required String articleId}) =>
      appRouter.push(ArticleDetail(articleId: articleId));
}
