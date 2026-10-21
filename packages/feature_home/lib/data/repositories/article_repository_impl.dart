import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_home/data/data_sources/article_local_data_source.dart';
import 'package:feature_home/data/mappers/article_mappers.dart';
import 'package:feature_home/domain/repositories/article_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/article.dart';

@Injectable(as: ArticleRepository)
class const ArticleRepositoryImpl(
  final ArticleLocalDataSource _dataSource,
) implements ArticleRepository {
  @override
  Future<AppResult<List<Article>>> getArticles() async {
    try {
      final localArticles = await _dataSource.readArticles();
      return Success(localArticles.map((it) => it.toArticle()).toList());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<Article>> getArticle(String id) async {
    try {
      final localArticle = await _dataSource.readArticle(id);
      if (localArticle == null) return const Failure(NotFoundError());
      return Success(localArticle.toArticle());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }
}
