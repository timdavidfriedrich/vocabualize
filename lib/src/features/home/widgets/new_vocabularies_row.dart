import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/get_new_vocabularies_use_case.dart';
import 'package:vocabualize/src/features/home/widgets/new_vocabulary_card.dart';

class NewVocabulariesRow extends ConsumerWidget {
  const NewVocabulariesRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getNewVocabularies = ref.watch(getNewVocabulariesUseCaseProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            AppLocalizations.of(context)?.home_newWords ?? "",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 12),
        getNewVocabularies.when(
          loading: () {
            return const SizedBox();
          },
          error: (error, stackTrace) {
            return const SizedBox();
          },
          data: (List<Vocabulary> newVocabularies) {
            if (newVocabularies.isEmpty) {
              return Text(
                AppLocalizations.of(context)?.home_noNewWords ?? "",
                style: Theme.of(context).textTheme.bodySmall,
              );
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  newVocabularies.length + 2,
                  (index) {
                    if (index == 0) {
                      return const SizedBox(width: 16);
                    }
                    if (index == newVocabularies.length + 1) {
                      return const SizedBox(width: 24);
                    }
                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: NewVocabularyCard(
                        vocabulary: newVocabularies.elementAt(index - 1),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
