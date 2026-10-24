import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/image_pick_source.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';

const _imageAspectRatio = 1.0;

class const DetailsScreen({
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final sourceController = useTextEditingController();
    final targetController = useTextEditingController();
    final fields = useMemoized(() => Listenable.merge([sourceController, targetController]));
    final hasText = useListenableSelector(
      fields,
      () => sourceController.text.trim().isNotEmpty && targetController.text.trim().isNotEmpty,
    );
    return BlocListener<DetailsBloc, DetailsState>(
      listenWhen: (previous, current) => switch ((previous, current)) {
        (_, DetailsSaved()) => true,
        (DetailsEditing(error: null), DetailsEditing(error: _?)) => true,
        _ => false,
      },
      listener: (context, state) => switch (state) {
        DetailsSaved() => context.closeScreen(),
        DetailsEditing(:final error?) => context.showToast(error.toMessage(context)),
        DetailsEditing() => null,
      },
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          padding: const EdgeInsets.all(Spacing.xl),
          children: [
            const _ImageSection(),
            const SizedBox(height: Spacing.xl),
            TextField(
              controller: sourceController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: context.s.detailsSourceLabel),
            ),
            const SizedBox(height: Spacing.l),
            TextField(
              controller: targetController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: context.s.detailsTargetLabel),
            ),
            const SizedBox(height: Spacing.xl),
            BlocBuilder<DetailsBloc, DetailsState>(
              builder: (context, state) => FilledButton(
                onPressed: switch (state) {
                  DetailsEditing(isBusy: false) when hasText => () => context.read<DetailsBloc>().add(
                    DetailsSaveRequested(
                      source: sourceController.text,
                      target: targetController.text,
                    ),
                  ),
                  DetailsEditing() || DetailsSaved() => null,
                },
                child: Text(context.s.detailsSaveButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class const _ImageSection() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) {
        final (image, isBusy) = switch (state) {
          DetailsEditing(:final image, :final isBusy) => (image, isBusy),
          DetailsSaved() => (null, true),
        };
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Spacing.radiusL),
              child: AspectRatio(
                aspectRatio: _imageAspectRatio,
                child: switch (image) {
                  final image? => Image.memory(
                    image.fullBytes,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),
                  null => ColoredBox(
                    color: context.c.surfaceContainerHighest,
                    child: Center(
                      child: isBusy
                          ? const CircularProgressIndicator()
                          : Text(
                              context.s.detailsNoImageMessage,
                              textAlign: TextAlign.center,
                              style: context.t.bodyLarge?.copyWith(
                                color: context.c.onSurfaceVariant,
                              ),
                            ),
                    ),
                  ),
                },
              ),
            ),
            const SizedBox(height: Spacing.m),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isBusy ? null : () => _pick(context, ImagePickSource.gallery),
                    icon: const Icon(Icons.photo_library_rounded),
                    label: Text(context.s.detailsOpenGalleryButton),
                  ),
                ),
                const SizedBox(width: Spacing.s),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isBusy ? null : () => _pick(context, ImagePickSource.camera),
                    icon: const Icon(Icons.photo_camera_rounded),
                    label: Text(context.s.detailsTakePictureButton),
                  ),
                ),
                if (image != null) ...[
                  const SizedBox(width: Spacing.s),
                  IconButton(
                    onPressed: isBusy
                        ? null
                        : () => context.read<DetailsBloc>().add(const DetailsImageRemoved()),
                    icon: const Icon(Icons.delete_rounded),
                    tooltip: context.s.detailsRemoveImageButton,
                  ),
                ],
              ],
            ),
          ],
        );
      },
    );
  }

  void _pick(BuildContext context, ImagePickSource source) {
    context.read<DetailsBloc>().add(DetailsImagePickRequested(source: source));
  }
}
