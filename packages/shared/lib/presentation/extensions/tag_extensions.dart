import 'package:shared/domain/entities/tag.dart';

extension TagExtensions on Tag {
  String toLabel() => switch (emoji) {
    final emoji? => "$emoji $name",
    null => name,
  };
}
