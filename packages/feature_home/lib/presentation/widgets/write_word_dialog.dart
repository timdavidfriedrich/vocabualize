import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/send_text_field.dart';

const _menuWidth = Spacing.xxxxl * 4 + Spacing.xxl;
const _menuOffset = Offset(-Spacing.xs, -Spacing.l);

typedef WrittenWord = ({String text, Language language});

typedef _LanguageOption = ({Language language, String? role});

Future<WrittenWord?> requestsWrittenWord(
  BuildContext context, {
  required LanguageSetup setup,
}) {
  return showDialog<WrittenWord>(
    context: context,
    builder: (dialogContext) => _WriteWordDialog(setup: setup),
  );
}

class const _WriteWordDialog({
  required final LanguageSetup _setup,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final language = useState(_setup.main);
    final learned = [for (final learned in _setup.active) learned.language];
    final options = <_LanguageOption>[
      (language: _setup.main, role: context.s.languagesSpeakTitle),
      for (final language in learned) (language: language, role: context.s.homeWriteLearningLabel),
      for (final askMeIn in {for (final learned in _setup.active) ?learned.askMeIn})
        if (askMeIn != _setup.main && !learned.contains(askMeIn)) (language: askMeIn, role: null),
    ];
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.all(Spacing.s),
      backgroundColor: context.c.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.xs, Spacing.l, Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: Text(context.s.homeWriteTitle, style: context.t.titleLarge)),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: context.s.close,
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: Spacing.s),
            SendTextField(
              autofocus: true,
              hintText: context.s.homeWriteHint,
              prefix: options.length > 1
                  ? _LanguageChip(
                      options: options,
                      selected: language.value,
                      onSelected: (selected) => language.value = selected,
                    )
                  : null,
              onSubmitted: (text) =>
                  Navigator.of(context).pop((text: text, language: language.value)),
            ),
          ],
        ),
      ),
    );
  }
}

class const _LanguageChip({
  required final List<_LanguageOption> _options,
  required final Language _selected,
  required final ValueChanged<Language> _onSelected,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final portal = useMemoized(OverlayPortalController.new);
    final link = useMemoized(LayerLink.new);
    final isOpen = useState(false);
    void setOpen(bool value) {
      isOpen.value = value;
      value ? portal.show() : portal.hide();
    }

    final foreground = isOpen.value ? context.c.onPrimary : context.c.onSurface;
    return TapRegion(
      groupId: link,
      onTapOutside: (_) => setOpen(false),
      child: OverlayPortal(
        controller: portal,
        overlayChildBuilder: (_) => Align(
          alignment: Alignment.topLeft,
          child: CompositedTransformFollower(
            link: link,
            targetAnchor: Alignment.topLeft,
            followerAnchor: Alignment.bottomLeft,
            offset: _menuOffset,
            child: TapRegion(
              groupId: link,
              child: TextFieldTapRegion(
                child: _LanguageMenu(
                  options: _options,
                  selected: _selected,
                  onSelected: (language) {
                    _onSelected(language);
                    setOpen(false);
                  },
                ),
              ),
            ),
          ),
        ),
        child: CompositedTransformTarget(
          link: link,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(Spacing.xs, Spacing.xs, Spacing.s, Spacing.xs),
            child: Material(
              color: isOpen.value ? context.c.primary : context.c.surfaceContainer,
              borderRadius: BorderRadius.circular(Spacing.radiusL),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => setOpen(!isOpen.value),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.s),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selected.toFlag(),
                        style: context.t.titleMedium,
                        semanticsLabel: _selected.toLabel(context),
                      ),
                      const SizedBox(width: Spacing.xxs),
                      Icon(
                        isOpen.value
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: foreground,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class const _LanguageMenu({
  required final List<_LanguageOption> _options,
  required final Language _selected,
  required final ValueChanged<Language> _onSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.c.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      elevation: Spacing.elevationM,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: _menuWidth,
        child: Padding(
          padding: const EdgeInsets.all(Spacing.xs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.xs, Spacing.m, Spacing.xs),
                child: Text(
                  context.s.homeWriteLanguageTitle,
                  style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                ),
              ),
              for (final option in _options)
                _LanguageMenuRow(
                  option: option,
                  isSelected: option.language == _selected,
                  onTap: () => _onSelected(option.language),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class const _LanguageMenuRow({
  required final _LanguageOption _option,
  required final bool _isSelected,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: _isSelected ? context.c.surfaceContainerHighest : context.c.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(Spacing.radiusXl),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _onTap,
        child: Padding(
          padding: const EdgeInsets.all(Spacing.s),
          child: Row(
            children: [
              Text(_option.language.toFlag(), style: context.t.titleLarge),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_option.language.toLabel(context), style: context.t.titleMedium),
                    if (_option.role case final role?)
                      Text(
                        role,
                        style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                      ),
                  ],
                ),
              ),
              if (_isSelected) Icon(Icons.check_rounded, color: context.c.primary),
            ],
          ),
        ),
      ),
    );
  }
}
