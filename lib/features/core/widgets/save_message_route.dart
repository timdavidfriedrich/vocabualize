import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/models/vocabulary.dart';
import 'package:vocabualize/features/core/widgets/save_message.dart';

class SaveMessageRoute extends OverlayRoute {
  final Vocabulary vocabulary;

  SaveMessageRoute({required this.vocabulary});

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
