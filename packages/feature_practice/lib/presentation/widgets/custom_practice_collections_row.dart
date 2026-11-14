import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_bloc.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_event.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_state.dart';
import 'package:feature_practice/presentation/widgets/collections_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const CustomPracticeCollectionsRow({
  super.key,
  required final CustomPracticeEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final names = [
      for (final tag in _state.tags)
        if (_state.tagIds.contains(tag.id)) tag.name,
    ];
    return Material(
      color: context.c.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(Spacing.radiusXxxl),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _pick(context),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.l),
          child: Row(
            children: [
              Text(context.s.customPracticeCollectionsTitle, style: context.t.titleMedium),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: Text(
                  names.isEmpty ? context.s.customPracticeAllOption : names.join(", "),
                  style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(width: Spacing.xs),
              Icon(Icons.chevron_right_rounded, color: context.c.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final bloc = context.read<CustomPracticeBloc>();
    final tagIds = await requestsCollections(
      context,
      tags: _state.tags,
      images: _state.collectionImages,
      counts: _state.collectionCounts,
      selected: _state.tagIds,
    );
    if (tagIds != null) bloc.add(CustomPracticeCollectionsChanged(tagIds: tagIds));
  }
}
