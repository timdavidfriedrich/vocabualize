import 'package:vocabualize/constants/common_imports.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/usecases/language/read_out_use_case.dart';
import 'package:vocabualize/src/common/presentation/providers/vocabulary_provider.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/details/screens/details_screen.dart';
import 'package:vocabualize/src/features/details/utils/details_arguments.dart';
import 'package:vocabualize/src/features/home/widgets/info_snackbar.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';

class VocabularyListTile extends StatelessWidget {
  final Vocabulary vocabulary;

  const VocabularyListTile({super.key, required this.vocabulary});

  @override
  Widget build(BuildContext context) {
    final speak = sl.get<ReadOutUseCase>();

    void showVocabularyInfo() {
      // Messenger.showStaticDialog(InfoDialog(vocabulary: vocabulary));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        content: InfoSnackBarContent(vocabulary: vocabulary),
        duration: const Duration(seconds: 2),
      ));
    }

    void editVocabualary() {
      Navigator.pushNamed(context, DetailsScreen.routeName, arguments: DetailsScreenArguments(vocabulary: vocabulary));
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Dismissible(
        key: Key(vocabulary.toString()),
        onDismissed: (direction) async => await Provider.of<VocabularyProvider>(context, listen: false).remove(vocabulary),
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
          child: Icon(Icons.delete_rounded, color: Theme.of(context).colorScheme.onError),
        ),
        background: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
          child: Icon(Icons.edit_rounded, color: Theme.of(context).colorScheme.onPrimary),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
              if (Provider.of<SettingsProvider>(context).areImagesEnabled)
                SizedBox(
                  width: 48,
                  height: 48,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: vocabulary.image,
                  ),
                ),
            ],
          ),
          title: Text(vocabulary.target),
          subtitle: Text(vocabulary.source, style: TextStyle(color: Theme.of(context).hintColor)),
          onLongPress: showVocabularyInfo,
          trailing: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            onPressed: () => speak(vocabulary),
            icon: const Icon(Icons.volume_up),
          ),
        ),
      ),
    );
  }
}
