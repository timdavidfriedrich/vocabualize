import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/get_new_vocabularies_use_case.dart';
import 'package:vocabualize/src/features/home/states/home_state.dart';
import 'package:vocabualize/src/features/home/widgets/new_vocabulary_card.dart';

class NewVocabulariesRow extends ConsumerWidget {
  final HomeState state;
  const NewVocabulariesRow({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO ARCHITECTURE: Move getNewVocabularies to HomeController?
    final newVocabularies = ref.watch(getNewVocabulariesUseCaseProvider);
    if (newVocabularies.isEmpty) {
      return const SizedBox();
    }
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
        SingleChildScrollView(
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
                    state: state,
                    vocabulary: newVocabularies.elementAt(index - 1),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
