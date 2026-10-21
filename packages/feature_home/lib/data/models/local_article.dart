import 'package:dart_mappable/dart_mappable.dart';

part 'local_article.mapper.dart';

@MappableClass()
class const LocalArticle({
  required final String id,
  required final String title,
  required final String status,
}) with LocalArticleMappable;
