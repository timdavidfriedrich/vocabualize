import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<AppResult<List<Article>>> getArticles();

  Future<AppResult<Article>> getArticle(String id);
}
