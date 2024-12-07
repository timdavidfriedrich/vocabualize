import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:vocabualize/constants/dimensions.dart';

import 'package:vocabualize/src/common/domain/extensions/object_extensions.dart';
import 'package:vocabualize/src/features/record/presentation/controllers/record_controller.dart';
import 'package:vocabualize/src/features/record/presentation/states/record_state.dart';

class RecordScreen extends ConsumerWidget {
  static const String routeName = "/Record";
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = recordControllerProvider;
    final notifier = provider.notifier;
    final asyncState = ref.watch(provider);

    return asyncState.when(
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
      error: (error, stackTrace) {
        // TODO: Replace with Error widget
        const errorMessage = "Error RecordScreen";
        Log.error(errorMessage);
        return Scaffold(
          appBar: AppBar(title: null),
          body: const Center(
            child: Text(errorMessage),
          ),
        );
      },
      data: (RecordState state) {
        return PopScope(
          canPop: state.imageBytes == null,
          onPopInvoked: (didPop) {
            ref.read(notifier).retakePhoto();
          },
          child: Scaffold(
            appBar: AppBar(title: null),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.largeSpacing,
              ),
              child: Column(
                children: [
                  const SizedBox(height: Dimensions.mediumSpacing),
                  AspectRatio(
                    aspectRatio: 1 / 1,
                    child: _CameraBox(state: state, notifier: notifier),
                  ),
                  if (state.imageBytes == null) ...[
                    const Spacer(),
                    _TakePhotoButton(notifier: notifier),
                  ] else ...[
                    const SizedBox(height: Dimensions.largeSpacing),
                    _ManualSourceField(state: state, notifier: notifier),
                    if (state.labels.isNotEmpty) ...[
                      const SizedBox(height: Dimensions.semiLargeSpacing),
                      const Align(
                        alignment: Alignment.centerLeft,
                        // TODO: Replace with arb
                        child: Text("Suggestions:"),
                      ),
                      const SizedBox(height: Dimensions.semiSmallSpacing),
                      _SuggestionsList(state: state, notifier: notifier),
                      const SizedBox(height: Dimensions.largeSpacing)
                    ] else ...[
                      const Spacer(),
                    ],
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CameraBox extends ConsumerWidget {
  final RecordState state;
  final Refreshable<RecordController> notifier;
  const _CameraBox({
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        Dimensions.largeBorderRadius,
      ),
      child: state.imageBytes == null
          ? CameraPreview(state.cameraController)
          : state.imageBytes?.let((bytes) {
              return Image.memory(
                bytes,
                fit: BoxFit.cover,
              );
            }),
    );
  }
}

class _TakePhotoButton extends ConsumerWidget {
  final Refreshable<RecordController> notifier;
  const _TakePhotoButton({
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.large(
      onPressed: () {
        ref.read(notifier).takePhotoAndScan();
      },
      child: const Icon(Icons.camera_alt_rounded),
    );
  }
}

class _ManualSourceField extends ConsumerWidget {
  final RecordState state;
  final Refreshable<RecordController> notifier;
  const _ManualSourceField({
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: InputDecoration(
        hintText:
            // TODO: Replace with arb
            "Type in ${state.sourceLanguage?.name ?? "Source"} word",
      ),
      onSubmitted: (value) {
        ref.read(notifier).validateAndGoToDetails(context, source: value);
      },
    );
  }
}

class _SuggestionsList extends ConsumerWidget {
  final RecordState state;
  final Refreshable<RecordController> notifier;
  const _SuggestionsList({
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: state.labels.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final label = state.labels.elementAt(index);
        return Padding(
          padding: const EdgeInsets.only(
            bottom: Dimensions.smallSpacing,
          ),
          child: ListTile(
            title: Text(label),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                Dimensions.mediumBorderRadius,
              ),
            ),
            tileColor: Theme.of(context).colorScheme.surface,
            onTap: () {
              ref.read(notifier).validateAndGoToDetails(context, source: label);
            },
          ),
        );
      },
    );
  }
}
