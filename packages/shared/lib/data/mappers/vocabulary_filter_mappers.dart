import 'package:shared/data/models/local_level_range.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';

extension VocabularyLevelRangeMappers on VocabularyLevel {
  LocalLevelRange toLocalLevelRange() {
    return (
      from: index == 0 ? null : floor,
      until: VocabularyLevel.values.elementAtOrNull(index + 1)?.floor,
    );
  }
}
