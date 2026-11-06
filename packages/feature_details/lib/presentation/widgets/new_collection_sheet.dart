import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/widgets/emoji_catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/filled_text_field.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

const _emojiButtonSize = Spacing.xxxxl;
const _gridColumns = 8;
const _gridHeight = Spacing.xxxxl * 4 + Spacing.xxl;
const _inactiveTabOpacity = 0.5;

typedef NewCollection = ({String name, String? emoji});

Future<NewCollection?> requestsNewCollection(
  BuildContext context, {
  required List<String> usedEmojis,
}) {
  return showModalBottomSheet<NewCollection>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (sheetContext) => _NewCollectionSheet(usedEmojis: usedEmojis),
  );
}

class const _NewCollectionSheet({
  required final List<String> _usedEmojis,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final hasName = useListenableSelector(
      nameController,
      () => nameController.text.trim().isNotEmpty,
    );
    final emoji = useState<String?>(null);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            Spacing.l,
            0,
            Spacing.l,
            Spacing.l,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(context.s.detailsNewCollectionTitle, style: context.t.titleLarge),
              const SizedBox(height: Spacing.m),
              Row(
                children: [
                  Container(
                    width: _emojiButtonSize,
                    height: _emojiButtonSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.c.primary,
                      borderRadius: BorderRadius.circular(Spacing.radiusXl),
                    ),
                    child: switch (emoji.value) {
                      final emoji? => Text(emoji, style: context.t.headlineMedium),
                      null => Icon(Icons.add_reaction_outlined, color: context.c.onPrimary),
                    },
                  ),
                  const SizedBox(width: Spacing.m),
                  Expanded(
                    child: FilledTextField(
                      controller: nameController,
                      hintText: context.s.detailsCollectionNameHint,
                      style: context.t.titleMedium,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.m),
              _EmojiPicker(
                usedEmojis: _usedEmojis,
                selected: emoji.value,
                onSelected: (selected) => emoji.value = selected,
              ),
              const SizedBox(height: Spacing.m),
              Row(
                children: [
                  Expanded(
                    child: TonalButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(context.s.cancel),
                    ),
                  ),
                  const SizedBox(width: Spacing.s),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: hasName
                          ? () => Navigator.of(
                              context,
                            ).pop((name: nameController.text.trim(), emoji: emoji.value))
                          : null,
                      child: Text(context.s.detailsCreateCollectionButton),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class const _EmojiPicker({
  required final List<String> _usedEmojis,
  required final String? _selected,
  required final ValueChanged<String> _onSelected,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final query = useValueListenable(searchController).text.trim().toLowerCase();
    final categories = <EmojiCategory>[
      if (_usedEmojis.isNotEmpty)
        (
          icon: usedEmojisIcon,
          emojis: [for (final emoji in _usedEmojis.toSet()) (emoji: emoji, keywords: "")],
        ),
      ...emojiCategories,
    ];
    final categoryIndex = useState(0);
    final emojis = query.isEmpty
        ? [for (final entry in categories[categoryIndex.value].emojis) entry.emoji]
        : {
            for (final category in emojiCategories)
              for (final entry in category.emojis)
                if (entry.keywords.contains(query)) entry.emoji,
          }.toList();
    return Container(
      padding: const EdgeInsets.all(Spacing.s),
      decoration: BoxDecoration(
        color: context.c.surfaceContainer,
        borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilledTextField(
            controller: searchController,
            hintText: context.s.detailsEmojiSearchHint,
            prefix: const Icon(Icons.search_rounded),
            textInputAction: TextInputAction.search,
          ),
          const SizedBox(height: Spacing.xs),
          if (query.isEmpty)
            Row(
              children: [
                for (final (index, category) in categories.indexed)
                  Expanded(
                    child: _CategoryTab(
                      icon: category.icon,
                      isSelected: index == categoryIndex.value,
                      onTap: () => categoryIndex.value = index,
                    ),
                  ),
              ],
            ),
          const SizedBox(height: Spacing.xs),
          SizedBox(
            height: _gridHeight,
            child: emojis.isEmpty
                ? Center(
                    child: Text(
                      context.s.detailsEmojiNoResultsMessage,
                      style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _gridColumns,
                    ),
                    itemCount: emojis.length,
                    itemBuilder: (context, index) => _EmojiButton(
                      emoji: emojis[index],
                      isSelected: emojis[index] == _selected,
                      onTap: () => _onSelected(emojis[index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class const _CategoryTab({
  required final String _icon,
  required final bool _isSelected,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: _isSelected ? context.c.surfaceContainerHighest : context.c.surfaceContainer,
      borderRadius: BorderRadius.circular(Spacing.radiusM),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Spacing.xs),
          child: Opacity(
            opacity: _isSelected ? 1 : _inactiveTabOpacity,
            child: Text(_icon, textAlign: TextAlign.center, style: context.t.titleLarge),
          ),
        ),
      ),
    );
  }
}

class const _EmojiButton({
  required final String _emoji,
  required final bool _isSelected,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: _isSelected ? context.c.primary : context.c.surfaceContainer,
      borderRadius: BorderRadius.circular(Spacing.radiusM),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _onTap,
        child: Center(child: Text(_emoji, style: context.t.headlineSmall)),
      ),
    );
  }
}
