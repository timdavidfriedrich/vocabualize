import 'package:dart_mappable/dart_mappable.dart';

part 'article.mapper.dart';

@MappableClass()
class const Article({
  required final String id,
  required final String title,
  required final ArticleStatus status,
}) with ArticleMappable;

@MappableEnum()
enum ArticleStatus { draft, published, unknown }
