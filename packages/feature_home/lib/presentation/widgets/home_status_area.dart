import 'package:feature_home/presentation/extensions/home_loaded_extensions.dart';
import 'package:feature_home/presentation/home_bloc.dart';
import 'package:feature_home/presentation/home_event.dart';
import 'package:feature_home/presentation/home_state.dart';
import 'package:feature_home/presentation/widgets/language_import_card.dart';
import 'package:feature_home/presentation/widgets/status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language_setup_extensions.dart';

class const HomeStatusArea({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => switch ((previous, current)) {
        (final HomeLoaded before, final HomeLoaded after) =>
          before.overview != after.overview ||
              before.setup != after.setup ||
              before.customSession != after.customSession ||
              before.collections != after.collections ||
              before.overviews != after.overviews ||
              before.importWords != after.importWords ||
              before.isLanguageEmpty != after.isLanguageEmpty,
        _ => true,
      },
      builder: (context, state) => switch (state) {
        final HomeLoaded loaded when loaded.isLanguageEmpty => LanguageImportCard(
          language: loaded.setup.selected,
          source: loaded.importSource,
          sourceCount: switch (loaded.importSource) {
            final source? => loaded.overviews[source]?.totalCount ?? 0,
            null => loaded.allWordsCount,
          },
          words: loaded.importWords,
        ),
        HomeLoaded(:final overview, :final setup, :final customSession, :final collections) =>
          StatusCard(
            overview: overview,
            language: setup.selected,
            newWordLimit: setup.learnedOf(setup.selected)?.newWords,
            customSession: customSession,
            tags: [for (final collection in collections) collection.tag],
            onCustomPracticeEnded: () =>
                context.read<HomeBloc>().add(const HomeCustomPracticeEnded()),
          ),
        HomeLoading() || HomeFailure() => const SizedBox.shrink(),
      },
    );
  }
}
