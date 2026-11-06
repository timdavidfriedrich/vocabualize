import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/app_dropdown.dart';
import 'package:shared/presentation/widgets/app_menu.dart';
import 'package:shared/presentation/widgets/send_text_field.dart';

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
            child: DropdownChip(
              leading: Text(_selected.toFlag(), style: context.t.titleMedium),
              semanticsLabel: _selected.toLabel(context),
              isOpen: isOpen.value,
              onPressed: () => setOpen(!isOpen.value),
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
    return AppMenu(
      title: context.s.homeWriteLanguageTitle,
      items: [
        for (final option in _options)
          AppMenuItem(
            leading: Text(option.language.toFlag(), style: context.t.titleLarge),
            title: option.language.toLabel(context),
            subtitle: option.role,
            isSelected: option.language == _selected,
            onTap: () => _onSelected(option.language),
          ),
      ],
    );
  }
}
