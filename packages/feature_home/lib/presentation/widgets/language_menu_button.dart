import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/language_setup/language_setup_cubit.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/count_badge.dart';
import 'package:shared/presentation/widgets/language_label.dart';

const _menuWidth = Spacing.xxxxl * 4 + Spacing.xxxl;
const _scrimOpacity = 0.6;

class const LanguageMenuButton({
  super.key,
  required final LanguageSetup _setup,
  required final Map<Language, VocabularyOverview> _overviews,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isOpen = useState(false);
    final language = _setup.selected;
    return Material(
      color: isOpen.value ? context.c.surfaceContainerLow : context.c.surface,
      borderRadius: BorderRadius.circular(Spacing.radiusXl),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          isOpen.value = true;
          await _showMenu(context);
          if (context.mounted) isOpen.value = false;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: LanguageLabel(language: language, style: context.t.titleMedium),
              ),
              const SizedBox(width: Spacing.xs),
              Icon(
                isOpen.value ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMenu(BuildContext context) {
    final box = context.findRenderObject()! as RenderBox;
    final anchor = box.localToGlobal(Offset.zero);
    final cubit = context.read<LanguageSetupCubit>();
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: context.s.close,
      barrierColor: context.c.scrim.withValues(alpha: _scrimOpacity),
      pageBuilder: (dialogContext, _, _) => Stack(
        children: [
          Positioned(
            left: anchor.dx - Spacing.xs,
            top: anchor.dy + box.size.height + Spacing.xs,
            width: _menuWidth,
            child: _Menu(
              setup: _setup,
              overviews: _overviews,
              onSelected: (language) {
                Navigator.of(dialogContext).pop();
                cubit.select(language);
              },
              onManage: () {
                Navigator.of(dialogContext).pop();
                context.pushLanguages();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class const _Menu({
  required final LanguageSetup _setup,
  required final Map<Language, VocabularyOverview> _overviews,
  required final ValueChanged<Language> _onSelected,
  required final VoidCallback _onManage,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.c.surfaceContainer,
      borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.xs),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final learned in _setup.active)
              _MenuRow(
                language: learned.language,
                overview: _overviews[learned.language],
                newWords: learned.newWords,
                isSelected: learned.language == _setup.selected,
                onTap: () => _onSelected(learned.language),
              ),
            const SizedBox(height: Spacing.xs),
            InkWell(
              onTap: _onManage,
              borderRadius: BorderRadius.circular(Spacing.radiusXl),
              child: Padding(
                padding: const EdgeInsets.all(Spacing.m),
                child: Row(
                  children: [
                    Icon(Icons.tune_rounded, color: context.c.primary),
                    const SizedBox(width: Spacing.m),
                    Expanded(
                      child: Text(
                        context.s.homeManageLanguagesButton,
                        style: context.t.titleMedium?.copyWith(color: context.c.primary),
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded, color: context.c.primary),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class const _MenuRow({
  required final Language _language,
  required final VocabularyOverview? _overview,
  required final NewWordLimit _newWords,
  required final bool _isSelected,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final practiceCount = _overview?.practiceCountWith(_newWords) ?? 0;
    return Material(
      color: _isSelected ? context.c.surfaceContainerHighest : context.c.surfaceContainer,
      borderRadius: BorderRadius.circular(Spacing.radiusXl),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _onTap,
        child: Padding(
          padding: const EdgeInsets.all(Spacing.m),
          child: Row(
            children: [
              Text(_language.toFlag(), style: context.t.titleLarge),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _language.toLabel(context),
                      style: context.t.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      context.s.languagesWordCount(_overview?.totalCount ?? 0),
                      style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              if (practiceCount > 0)
                CountBadge(
                  count: practiceCount,
                  color: _isSelected ? context.c.primary : context.c.surfaceContainerHighest,
                  textColor: _isSelected ? context.c.onPrimary : context.c.onSurface,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
