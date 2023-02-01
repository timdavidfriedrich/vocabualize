import 'package:provider/provider.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/home/widgets/tag_card_button.dart';

class CollectionsView extends StatelessWidget {
  const CollectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    int threshhold = 8;

    List<List<String>> splitListInHalf(List<String> list) {
      List<List<String>> result = [];
      if (list.length >= threshhold) {
        int breakpoint = (list.length / 2).ceil();
        result.add(list.sublist(0, breakpoint));
        result.add(list.sublist(breakpoint));
      } else {
        result.add(list);
        result.add([]);
      }
      return result;
    }

    return SingleChildScrollView(
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
              splitListInHalf(Provider.of<VocabularyProvider>(context).allTags)[0].length + 2,
              (index) => index == 0 || index == splitListInHalf(Provider.of<VocabularyProvider>(context).allTags)[0].length + 1
                  ? index == 0
                      ? const SizedBox(width: 16)
                      : const SizedBox(width: 24)
                  : Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TagCardButton(
                        tag: splitListInHalf(Provider.of<VocabularyProvider>(context).allTags)[0].elementAt(index - 1),
                      ),
                    ),
            ),
          ),
          Provider.of<VocabularyProvider>(context).allTags.length < threshhold ? Container() : const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              splitListInHalf(Provider.of<VocabularyProvider>(context).allTags)[1].length + 2,
              (index) => index == 0 || index == splitListInHalf(Provider.of<VocabularyProvider>(context).allTags)[1].length + 1
                  ? index == 0
                      ? const SizedBox(width: 16)
                      : const SizedBox(width: 24)
                  : Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TagCardButton(
                        tag: splitListInHalf(Provider.of<VocabularyProvider>(context).allTags)[1].elementAt(index - 1),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
