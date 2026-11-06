import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/widgets/new_collection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _chipHeight = Spacing.xxl + Spacing.xxxs;

typedef _TagChoice = ({List<Tag> tags, Set<String> selected});

class const CollectionsRow({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<DetailsBloc, DetailsState, _TagChoice>(
      selector: (state) => switch (state) {
        DetailsEditing(:final tags, :final selectedTagIds) => (
          tags: tags,
          selected: selectedTagIds,
        ),
        _ => (tags: const [], selected: const {}),
      },
      builder: (context, choice) => SizedBox(
        height: _chipHeight,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xxl),
          children: [
            _AddButton(tags: choice.tags),
            for (final tag in choice.tags)
              Padding(
                key: ValueKey(tag.id),
                padding: const EdgeInsets.only(left: Spacing.xs),
                child: _CollectionChip(tag: tag, isSelected: choice.selected.contains(tag.id)),
              ),
          ],
        ),
      ),
    );
  }
}

class const _AddButton({
  required final List<Tag> _tags,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Material(
        color: context.c.surfaceContainerLow,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _create(context),
          child: Icon(
            Icons.add_rounded,
            color: context.c.primary,
            semanticLabel: context.s.detailsNewCollectionTitle,
          ),
        ),
      ),
    );
  }

  Future<void> _create(BuildContext context) async {
    final bloc = context.read<DetailsBloc>();
    final collection = await requestsNewCollection(
      context,
      usedEmojis: [for (final tag in _tags) ?tag.emoji],
    );
    if (collection case (:final name, :final emoji)) {
      bloc.add(DetailsTagCreated(name: name, emoji: emoji));
    }
  }
}

class const _CollectionChip({
  required final Tag _tag,
  required final bool _isSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foreground = _isSelected ? context.c.onPrimaryContainer : context.c.onSurfaceVariant;
    return Material(
      color: _isSelected ? context.c.primaryContainer : context.c.surfaceContainerLow,
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.read<DetailsBloc>().add(DetailsTagToggled(tagId: _tag.id)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isSelected) ...[
                Icon(Icons.check_rounded, size: Spacing.iconS, color: context.c.primary),
                const SizedBox(width: Spacing.xs),
              ],
              if (_tag.emoji case final emoji?) ...[
                Text(emoji, style: context.t.bodyLarge),
                const SizedBox(width: Spacing.xs),
              ],
              Text(_tag.name, style: context.t.bodyLarge?.copyWith(color: foreground)),
            ],
          ),
        ),
      ),
    );
  }
}
