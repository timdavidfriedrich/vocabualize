import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/delete_vocabulary_use_case.dart';
import 'package:vocabualize/src/features/details/screens/details_screen.dart';
import 'package:vocabualize/src/features/details/utils/details_arguments.dart';
import 'package:vocabualize/src/features/home/controllers/home_controller.dart';
import 'package:vocabualize/src/features/home/widgets/info_snackbar.dart';

class VocabularyListTile extends ConsumerWidget {
  final bool areImagesEnabled;
  final Vocabulary vocabulary;

  const VocabularyListTile({
    required this.areImagesEnabled,
    required this.vocabulary,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showVocabularyInfo() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        content: InfoSnackBarContent(vocabulary: vocabulary),
        duration: const Duration(seconds: 2),
      ));
    }

    void editVocabualary() {
      Log.debug("Editing vocabulary: $vocabulary");
      Navigator.pushNamed(
        context,
        DetailsScreen.routeName,
        arguments: DetailsScreenArguments(
          vocabulary: vocabulary,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Dismissible(
        key: Key(vocabulary.toString()),
        onDismissed: (direction) async {
          return await ref.read(deleteVocabularyUseCaseProvider(vocabulary));
        },
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            editVocabualary();
            return false;
          } else {
            return true;
          }
        },
        secondaryBackground: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.error),
          child: Icon(
            Icons.delete_rounded,
            color: Theme.of(context).colorScheme.onError,
          ),
        ),
        background: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Icon(
            Icons.edit_rounded,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.zero,
                margin: const EdgeInsets.symmetric(vertical: 8),
                color: vocabulary.level.color,
                width: 4,
              ),
              const SizedBox(width: 12),
              if (areImagesEnabled)
                SizedBox(
                  width: 48,
                  height: 48,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image(
                      image: NetworkImage(
                        vocabulary.image.url,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
          title: Text(vocabulary.target),
          subtitle: Text(
            vocabulary.source,
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
          onLongPress: showVocabularyInfo,
          trailing: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            style: const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              ref.read(homeControllerProvider.notifier).readOut(vocabulary);
            },
            icon: const Icon(Icons.volume_up),
          ),
        ),
      ),
    );
  }
}
