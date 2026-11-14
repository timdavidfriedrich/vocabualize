import 'package:klog/klog.dart';
import 'package:shared/data/models/local_tag_extras.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _noExtras = LocalTagExtras(emoji: null);

extension LocalTagMappers on LocalTag {
  Tag toTag() => Tag(id: id.toString(), name: name, emoji: emoji, createdAt: createdAt.toUtc());

  String? get emoji => _extras.emoji;

  String extrasWithEmoji(String? emoji) => _extras.copyWith(emoji: emoji).toJson();

  LocalTagExtras get _extras {
    if (extras case final json?) {
      try {
        return LocalTagExtrasMapper.fromJson(json);
      } on Object catch (error) {
        Klog.warning("Tag extras unreadable: ${error.runtimeType}");
        return _noExtras;
      }
    }
    return _noExtras;
  }
}

extension TagEmojiMappers on String? {
  String? toTagExtras() => switch (this) {
    final emoji? => LocalTagExtras(emoji: emoji).toJson(),
    null => null,
  };
}
