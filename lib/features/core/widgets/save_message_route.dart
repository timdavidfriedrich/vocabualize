import 'package:flutter/material.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/record/widgets/save_message.dart';

class SaveMessageRoute extends OverlayRoute {
  SaveMessageRoute({required this.vocabulary});

  final Vocabulary vocabulary;

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    final overlays = <OverlayEntry>[];

    overlays.add(
      OverlayEntry(
        builder: (BuildContext context) {
          return SaveMessage(vocabulary: vocabulary);
        },
        maintainState: false,
        opaque: false,
      ),
    );

    return overlays;
  }
}
