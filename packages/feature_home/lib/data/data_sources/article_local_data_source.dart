import 'package:feature_home/data/models/local_article.dart';
import 'package:injectable/injectable.dart';

const _seedArticles = [
  LocalArticle(id: "1", title: "Welcome to Vocabualize", status: "published"),
  LocalArticle(id: "2", title: "This screen reads from a local data source", status: "published"),
  LocalArticle(id: "3", title: "Swap it for a remote one when you have an API", status: "draft"),
];

abstract class ArticleLocalDataSource {
  Future<List<LocalArticle>> readArticles();

  Future<LocalArticle?> readArticle(String id);
}

@Injectable(as: ArticleLocalDataSource)
class const ArticleLocalDataSourceImpl() implements ArticleLocalDataSource {
  @override
  Future<List<LocalArticle>> readArticles() async => _seedArticles;

  @override
  Future<LocalArticle?> readArticle(String id) async {
    final matches = _seedArticles.where((it) => it.id == id);
    return matches.isEmpty ? null : matches.first;
  }
}
