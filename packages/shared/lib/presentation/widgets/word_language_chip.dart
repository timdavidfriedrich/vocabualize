import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/app_dropdown.dart';
import 'package:shared/presentation/widgets/app_menu.dart';
import 'package:shared/presentation/widgets/asks_in_tag.dart';

const _menuOffset = Offset(-Spacing.xs, -Spacing.l);

typedef _LanguageOption = ({Language language, String role, Language? askMeIn});

class const WordLanguageChip({
  super.key,
  required final LanguageSetup _setup,
  required final Language _selected,
  required final ValueChanged<Language> _onSelected,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final learnedLanguages = [for (final learned in _setup.active) learned.language];
    final options = <_LanguageOption>[
      (language: _setup.main, role: context.s.languagesSpeakTitle, askMeIn: null),
      for (final learned in _setup.active)
        (
          language: learned.language,
          role: context.s.homeWriteLearningLabel,
          askMeIn: learned.askMeIn,
        ),
      for (final askMeIn in {for (final learned in _setup.active) ?learned.askMeIn})
        if (askMeIn != _setup.main && !learnedLanguages.contains(askMeIn))
          (language: askMeIn, role: context.s.learnedLanguageAskMeInLabel, askMeIn: null),
    ];
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
                  options: options,
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
            tag: switch (option.askMeIn) {
              final askMeIn? => AsksInTag(language: askMeIn),
              null => null,
            },
            subtitle: option.role,
            isSelected: option.language == _selected,
            onTap: () => _onSelected(option.language),
          ),
      ],
    );
  }
}
