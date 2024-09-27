import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/get_vocabularies_use_case.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/home/screens/home_screen.dart';
import 'package:vocabualize/src/features/home/widgets/status_card_indicator.dart';
import 'package:vocabualize/src/features/home/widgets/vocabulary_list_tile.dart';
import 'package:vocabualize/src/features/practise/screens/practise_screen.dart';
import 'package:vocabualize/src/features/practise/utils/practise_arguments.dart';

class CollectionScreen extends ConsumerWidget {
  static const String routeName = "${HomeScreen.routeName}/Collection";

  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getVocabularies = ref.watch(getVocabulariesUseCaseProvider(null));

    Tag tag = Tag.empty();

    void editTag() {
      // TODO: implement edit tag / collection
    }

    void startPractise() {
      Navigator.pushNamed(
        context,
        PractiseScreen.routeName,
        arguments: PractiseScreenArguments(
          tag: tag,
        ),
      );
    }

    // TODO ARCHITECTURE: What to do with CollectionScreenArguments?
    /*
    SchedulerBinding.instance.addPostFrameCallback((_) {
      CollectionScreenArguments arguments = ModalRoute.of(context)!.settings.arguments as CollectionScreenArguments;
      setState(() => tag = arguments.tag);
    });
    */

    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
          appBar: AppBar(
            title: Text(tag.name, style: Theme.of(context).textTheme.headlineMedium),
            actions: [IconButton(icon: const Icon(Icons.edit_rounded), onPressed: () => editTag())],
          ),
          body: getVocabularies.when(
            loading: () {
              return const Center(child: CircularProgressIndicator.adaptive());
            },
            data: (List<Vocabulary> vocabularies) {
              List<Vocabulary> vocabulariesWithTag = vocabularies.where((vocabulary) {
                return vocabulary.tags.contains(tag);
              }).toList();
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 16),
                  StatusCardIndicator(
                    tag: tag,
                    parent: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => startPractise(),
                        child: Text(AppLocalizations.of(context)?.home_statusCard_practiseButton ?? ""),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List<Widget>.generate(
                      vocabulariesWithTag.length,
                      (index) => VocabularyListTile(
                        vocabulary: vocabulariesWithTag.elementAt(index),
                      ),
                    ).reversed.toList(),
                  ),
                  const SizedBox(height: 96),
                ],
              );
            },
            error: (error, stackTrace) {
              // TODO: Replace with error widget and arb
              return const Center(child: Text("Error getting vocabularies"));
            },
          ),
        ),
      ),
    );
  }
}
