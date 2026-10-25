import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/widgets/add_tag_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const TagWrap({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<DetailsBloc, DetailsState, ({List<Tag> tags, Set<String> selected})>(
      selector: (state) => switch (state) {
        DetailsEditing(:final tags, :final selectedTagIds) => (
          tags: tags,
          selected: selectedTagIds,
        ),
        _ => (tags: const [], selected: const {}),
      },
      builder: (context, choice) => Wrap(
        spacing: Spacing.xs,
        children: [
          for (final tag in choice.tags)
            FilterChip(
              key: ValueKey(tag.id),
              label: Text(tag.name),
              selected: choice.selected.contains(tag.id),
              onSelected: (_) => context.read<DetailsBloc>().add(DetailsTagToggled(tagId: tag.id)),
            ),
          if (choice.tags.isEmpty)
            TextButton.icon(
              onPressed: () => _create(context),
              label: Text(context.s.detailsAddCollectionButton),
              icon: const Icon(Icons.add_rounded),
            )
          else
            IconButton(
              onPressed: () => _create(context),
              icon: const Icon(Icons.add_rounded),
            ),
        ],
      ),
    );
  }

  Future<void> _create(BuildContext context) async {
    final bloc = context.read<DetailsBloc>();
    final name = await requestsTagName(context);
    if (name != null) bloc.add(DetailsTagCreated(name: name));
  }
}
