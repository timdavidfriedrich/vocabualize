import 'package:shared/data/models/local_tag_extras.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

extension LocalTagMappers on LocalTag {
  Tag toTag() => Tag(id: id.toString(), name: name, emoji: emoji, createdAt: createdAt.toUtc());

  String? get emoji => _extras?.emoji;

  String? extrasWithEmoji(String? emoji) =>
      (_extras ?? const LocalTagExtras(emoji: null)).copyWith(emoji: emoji).toJson();

  LocalTagExtras? get _extras {
    if (extras case final json?) {
      try {
        return LocalTagExtrasMapper.fromJson(json);
      } on Object {
        return null;
      }
    }
    return null;
  }
}

extension TagEmojiMappers on String? {
  String? toTagExtras() => switch (this) {
    final emoji? => LocalTagExtras(emoji: emoji).toJson(),
    null => null,
  };
}
