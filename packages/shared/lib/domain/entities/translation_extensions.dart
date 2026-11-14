import 'package:shared/domain/entities/translation.dart';

extension TranslationOriginExtensions on TranslationOrigin {
  bool get isFromUser => switch (this) {
    TranslationOrigin.entered || TranslationOrigin.edited || TranslationOrigin.unknown => true,
    TranslationOrigin.translated => false,
  };
}
