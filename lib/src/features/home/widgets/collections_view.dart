import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/usecases/tag/get_all_tags_use_case.dart';
import 'package:vocabualize/src/features/home/extensions/list_extensions.dart';
import 'package:vocabualize/src/features/home/widgets/collection_card_button.dart';

class CollectionsView extends ConsumerWidget {
  const CollectionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getAllTags = ref.watch(getAllTagsUseCaseProvider);

    const int threshold = 8;

    return getAllTags.when(
      loading: () {
        return const Center(child: CircularProgressIndicator.adaptive());
      },
      error: (error, stackStrace) {
        return const SizedBox();
      },
      data: (List<Tag> tags) {
        if (tags.isEmpty) {
          return const SizedBox();
        }
        List<Tag> firstTags;
        List<Tag> secondTags;
        (firstTags, secondTags) = tags.splitListInHalf(threshold: threshold);
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "Tags",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(height: 12),
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
                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TagCardButton(
                        tag: firstTags.elementAt(index - 1),
                      ),
                    );
                  },
                ),
              ),
              tags.length < threshold ? Container() : const SizedBox(height: 8),
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
                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TagCardButton(
                        tag: secondTags.elementAt(index - 1),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
