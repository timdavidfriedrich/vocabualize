import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';

part 'translation.mapper.dart';

enum TranslationOrigin { entered, translated, edited, unknown }

extension TranslationOriginExtensions on TranslationOrigin {
  bool get isFromUser => switch (this) {
    TranslationOrigin.entered || TranslationOrigin.edited || TranslationOrigin.unknown => true,
    TranslationOrigin.translated => false,
  };
}

@MappableClass()
class const Translation({
  required final Language language,
  required final String text,
  required final TranslationOrigin origin,
}) with TranslationMappable;
