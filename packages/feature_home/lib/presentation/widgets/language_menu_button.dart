import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/language_setup/language_setup_cubit.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/app_menu.dart';
import 'package:shared/presentation/widgets/count_badge.dart';
import 'package:shared/presentation/widgets/language_label.dart';

class const LanguageMenuButton({
  super.key,
  required final LanguageSetup _setup,
  required final Map<Language, VocabularyOverview> _overviews,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LanguageSetupCubit>();
    return AppMenuAnchor(
      items: [
        for (final learned in _setup.active)
          _LanguageItem(
            learned: learned,
            overview: _overviews[learned.language],
            isSelected: learned.language == _setup.selected,
            onTap: () => cubit.select(learned.language),
          ),
        AppMenuItem(
          leading: const Icon(Icons.tune_rounded),
          title: context.s.homeManageLanguagesButton,
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: context.pushLanguages,
        ),
      ],
      builder: (context, controller) => Material(
        color: controller.isOpen ? context.c.surfaceContainerLow : context.c.surface,
        borderRadius: BorderRadius.circular(Spacing.radiusXl),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => controller.isOpen ? controller.close() : controller.open(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: LanguageLabel(language: _setup.selected, style: context.t.titleMedium),
                ),
                const SizedBox(width: Spacing.xs),
                Icon(
                  controller.isOpen
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class const _LanguageItem({
  required final LearnedLanguage _learned,
  required final VocabularyOverview? _overview,
  required final bool _isSelected,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final practiceCount = _overview?.practiceCountWith(_learned.newWords) ?? 0;
    return AppMenuItem(
      leading: Text(_learned.language.toFlag(), style: context.t.titleLarge),
      title: _learned.language.toLabel(context),
      subtitle: context.s.languagesWordCount(_overview?.totalCount ?? 0),
      trailing: practiceCount > 0
          ? CountBadge(
              count: practiceCount,
              color: _isSelected ? context.c.primary : context.c.surfaceContainerHighest,
              textColor: _isSelected ? context.c.onPrimary : context.c.onSurface,
            )
          : null,
      isSelected: _isSelected,
      onTap: _onTap,
    );
  }
}
