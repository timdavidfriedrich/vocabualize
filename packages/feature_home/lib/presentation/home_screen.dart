import 'dart:io';

import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/home_bloc.dart';
import 'package:feature_home/presentation/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/sync_status_icon.dart';

class const HomeScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.s.appTitle),
        actions: [
          const SyncStatusIcon(),
          IconButton(
            onPressed: context.pushSettings,
            icon: const Icon(Icons.settings_rounded),
            tooltip: context.s.settingsTitle,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: context.pushVocabularyDetails,
        icon: const Icon(Icons.edit_rounded),
        label: Text(context.s.homeWriteButton),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => switch (state) {
          HomeLoading() => const Center(child: CircularProgressIndicator()),
          HomeFailure(:final error) => Center(child: Text(error.toMessage(context))),
          HomeLoaded(:final vocabularies, :final vocabularyCount) => _Feed(
            vocabularies: vocabularies,
            vocabularyCount: vocabularyCount,
          ),
        },
      ),
    );
  }
}

class const _Feed({
  required final List<Vocabulary> _vocabularies,
  required final int _vocabularyCount,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (_vocabularies.isEmpty) {
      return Center(
        child: Text(context.s.homeAddFirstWordMessage, textAlign: TextAlign.center),
      );
    }
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(Spacing.m),
          sliver: SliverToBoxAdapter(
            child: Text(
              context.s.homeStatusTotalMessage(_vocabularyCount),
              style: context.t.bodyLarge,
            ),
          ),
        ),
        SliverList.builder(
          itemCount: _vocabularies.length,
          itemBuilder: (context, index) => _VocabularyTile(
            key: ValueKey(_vocabularies[index].id),
            vocabulary: _vocabularies[index],
          ),
        ),
      ],
    );
  }
}

class const _VocabularyTile({
  super.key,
  required final Vocabulary _vocabulary,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: switch (_vocabulary.image) {
        CustomImage(thumbnailPath: final thumbnailPath?) => _Thumbnail(
          image: FileImage(File(thumbnailPath)),
        ),
        CustomImage(thumbnailPath: null) => const _ThumbnailPlaceholder(),
        StockImage(:final thumbUrl) => _Thumbnail(image: NetworkImage(thumbUrl)),
        NoImage() => null,
      },
      title: Text(_vocabulary.target, style: context.t.titleMedium),
      subtitle: Text(_vocabulary.source, style: context.t.bodyMedium),
    );
  }
}

class const _Thumbnail({
  required final ImageProvider _image,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Spacing.radiusS),
      child: SizedBox.square(
        dimension: Spacing.xxxl,
        child: Image(
          image: _image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const _ThumbnailPlaceholder(),
        ),
      ),
    );
  }
}

class const _ThumbnailPlaceholder() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Spacing.radiusS),
      child: SizedBox.square(
        dimension: Spacing.xxxl,
        child: ColoredBox(
          color: context.c.surfaceContainerHighest,
          child: Icon(
            Icons.image_rounded,
            size: Spacing.iconM,
            color: context.c.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
