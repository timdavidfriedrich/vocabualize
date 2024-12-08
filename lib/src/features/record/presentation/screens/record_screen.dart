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
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.largeSpacing,
                    ),
                    children: [
                      const SizedBox(height: Dimensions.mediumSpacing),
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: _CameraBox(state: state, notifier: notifier),
                      ),
                      if (state.imageBytes != null) ...[
                        const SizedBox(height: Dimensions.largeSpacing),
                        _ManualSourceField(state: state, notifier: notifier),
                        if (state.suggestions.isNotEmpty) ...[
                          const SizedBox(height: Dimensions.semiLargeSpacing),
                          const Align(
                            alignment: Alignment.centerLeft,
                            // TODO: Replace with arb
                            child: Text("Suggestions:"),
                          ),
                          const SizedBox(height: Dimensions.semiSmallSpacing),
                          _SuggestionsList(state: state, notifier: notifier),
                          const SizedBox(height: Dimensions.largeSpacing)
                        ],
                      ],
                    ],
                  ),
                ),
                if (state.imageBytes == null) ...[
                  _TakePhotoButton(notifier: notifier),
                  const SizedBox(height: Dimensions.largeSpacing)
                ]
              ],
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
          ? FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: state.cameraController.value.previewSize?.height,
                height: state.cameraController.value.previewSize?.width,
                child: CameraPreview(state.cameraController),
              ),
            )
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
      backgroundColor: Theme.of(context).colorScheme.surface,
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
    // TODO: Add the source language's flag as a leading?
    return TextField(
      decoration: InputDecoration(
        hintText:
            // TODO: Replace with arb
            "Type ${state.sourceLanguage?.name ?? "source"} word",
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
    return GridView.builder(
      restorationId: "SuggestionsList",
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: state.suggestions.length == 1 ? 1 : 2,
        childAspectRatio: 5 / 2,
      ),
      shrinkWrap: true,
      itemCount: state.suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = state.suggestions.elementAt(index);
        return Card(
          child: ListTile(
            title: Text(suggestion),
            onTap: () => ref
                .read(notifier)
                .validateAndGoToDetails(context, source: suggestion),
          ),
        );
      },
    );
  }
}
