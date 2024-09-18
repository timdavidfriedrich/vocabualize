import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/usecases/tag/get_all_tags_use_case.dart';
import 'package:vocabualize/src/features/home/widgets/collection_card_button.dart';

class CollectionsView extends StatelessWidget {
  const CollectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final getAllTags = sl.get<GetAllTagsUseCase>();
    int threshhold = 8;

    List<List<Tag>> splitListInHalf(List<Tag> list) {
      List<List<Tag>> result = [];
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

    return FutureBuilder<List<Tag>>(
      future: getAllTags(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final allTags = snapshot.data;

        if (allTags == null || allTags.isEmpty) {
          return const SizedBox();
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
                  splitListInHalf(allTags)[0].length + 2,
                  (index) => index == 0 || index == splitListInHalf(allTags)[0].length + 1
                      ? index == 0
                          ? const SizedBox(width: 16)
                          : const SizedBox(width: 24)
                      : Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TagCardButton(
                            tag: splitListInHalf(allTags)[0].elementAt(index - 1),
                          ),
                        ),
                ),
              ),
              allTags.length < threshhold ? Container() : const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  splitListInHalf(allTags)[1].length + 2,
                  (index) => index == 0 || index == splitListInHalf(allTags)[1].length + 1
                      ? index == 0
                          ? const SizedBox(width: 16)
                          : const SizedBox(width: 24)
                      : Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TagCardButton(
                            tag: splitListInHalf(allTags)[1].elementAt(index - 1),
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
