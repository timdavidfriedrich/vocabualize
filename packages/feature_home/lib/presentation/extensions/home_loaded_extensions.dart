import 'package:feature_home/presentation/home_state.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup_extensions.dart';

extension HomeLoadedExtensions on HomeLoaded {
  bool get isLanguageEmpty => overview.totalCount == 0 && vocabularies.isEmpty && allWordsCount > 0;

  Language? get importSource {
    final candidates = [
      for (final learned in setup.active)
        if (learned.language != setup.selected &&
            (overviews[learned.language]?.totalCount ?? 0) > 0)
          learned.language,
    ];
    candidates.sort(
      (first, second) => overviews[second]!.totalCount.compareTo(overviews[first]!.totalCount),
    );
    return candidates.firstOrNull;
  }
}
