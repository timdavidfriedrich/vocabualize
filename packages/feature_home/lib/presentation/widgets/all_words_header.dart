import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/extensions/home_loaded_extensions.dart';
import 'package:feature_home/presentation/home_bloc.dart';
import 'package:feature_home/presentation/home_state.dart';
import 'package:feature_home/presentation/widgets/home_section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';

class const AllWordsHeader({
  super.key,
  required final VoidCallback _onSearchOpened,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, Language?>(
      selector: (state) => switch (state) {
        final HomeLoaded loaded when loaded.isLanguageEmpty => loaded.setup.selected,
        HomeLoading() || HomeLoaded() || HomeFailure() => null,
      },
      builder: (context, emptyLanguage) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: HomeSectionTitle(title: context.s.homeAllWordsTitle)),
              if (emptyLanguage == null)
                IconButton(
                  onPressed: _onSearchOpened,
                  tooltip: context.s.vocabularySearchTooltip,
                  icon: const Icon(Icons.search_rounded),
                ),
            ],
          ),
          if (emptyLanguage case final language?) ...[
            const SizedBox(height: Spacing.m),
            Text(
              context.s.homeEmptyLanguageFeedHint(language.toShortLabel(context)),
              style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}
