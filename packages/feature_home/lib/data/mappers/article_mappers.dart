import 'package:feature_home/data/models/local_article.dart';
import 'package:shared/domain/entities/article.dart';

const _statusDraft = "draft";
const _statusPublished = "published";
const _statusUnknown = "unknown";

extension LocalArticleMappers on LocalArticle {
  Article toArticle() {
    return Article(id: id, title: title, status: status.toArticleStatus());
  }
}

extension ArticleMappers on Article {
  LocalArticle toLocalArticle() {
    return LocalArticle(id: id, title: title, status: status.value);
  }
}

extension ArticleStatusValueMappers on String {
  ArticleStatus toArticleStatus() => switch (this) {
    _statusDraft => ArticleStatus.draft,
    _statusPublished => ArticleStatus.published,
    _ => ArticleStatus.unknown,
  };
}

extension ArticleStatusMappers on ArticleStatus {
  String get value => switch (this) {
    ArticleStatus.draft => _statusDraft,
    ArticleStatus.published => _statusPublished,
    ArticleStatus.unknown => _statusUnknown,
  };
}
