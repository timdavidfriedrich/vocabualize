import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/features/home/extensions/list_extensions.dart';
import 'package:vocabualize/src/features/home/states/home_state.dart';
import 'package:vocabualize/src/features/home/widgets/collection_card_button.dart';

class CollectionsView extends StatelessWidget {
  final HomeState state;
  const CollectionsView({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    const int threshold = 8;

    if (state.tags.isEmpty) {
      return const SizedBox();
    }
    List<Tag> firstTags;
    List<Tag> secondTags;
    (firstTags, secondTags) = state.tags.splitListInHalf(threshold: threshold);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            // TODO: Replace with arb
            "Tags",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  firstTags.length + 2,
                  (index) {
                    if (index == 0) {
                      return const SizedBox(width: 16);
                    }
                    if (index == firstTags.length + 1) {
                      return const SizedBox(width: 24);
                    }
                    final tag = firstTags.elementAt(index - 1);
                    final tagVocabularies = state.vocabularies.where((element) {
                      return element.tagIds.contains(tag.id);
                    }).toList();
                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TagCardButton(
                        areImagesEnabled: state.areImagesEnabled,
                        tag: firstTags.elementAt(index - 1),
                        tagVocabularies: tagVocabularies,
                      ),
                    );
                  },
                ),
              ),
              state.tags.length < threshold ? Container() : const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  secondTags.length + 2,
                  (index) {
                    if (index == 0) {
                      return const SizedBox(width: 16);
                    }
                    if (index == secondTags.length + 1) {
                      return const SizedBox(width: 24);
                    }
                    final tag = secondTags.elementAt(index - 1);
                    final tagVocabularies = state.vocabularies.where((element) {
                      return element.tagIds.contains(tag.id);
                    }).toList();
                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TagCardButton(
                        areImagesEnabled: state.areImagesEnabled,
                        tag: tag,
                        tagVocabularies: tagVocabularies,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
