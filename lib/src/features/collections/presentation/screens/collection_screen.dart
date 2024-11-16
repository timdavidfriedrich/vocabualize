import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/features/collections/presentation/controllers/collection_controller.dart';
import 'package:vocabualize/src/features/collections/presentation/states/collection_state.dart';
import 'package:vocabualize/src/features/home/presentation/screens/home_screen.dart';
import 'package:vocabualize/src/features/home/presentation/widgets/status_card_indicator.dart';
import 'package:vocabualize/src/features/home/presentation/widgets/vocabulary_list_tile.dart';

class CollectionScreenArguments {
  final Tag tag;
  CollectionScreenArguments({required this.tag});
}

class CollectionScreen extends ConsumerWidget {
  static const String routeName = "${HomeScreen.routeName}/Collection";

  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Tag tag = const Tag();
    CollectionScreenArguments? arguments = ModalRoute.of(context)?.settings.arguments as CollectionScreenArguments?;
    if (arguments != null) {
      tag = arguments.tag;
    }

    final asyncState = ref.watch(collectionControllerProvider(tag));

    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: asyncState.when(
          loading: () {
            return const Center(child: CircularProgressIndicator.adaptive());
          },
          error: (error, stackTrace) {
            // TODO: Replace with error widget and arb
            return const Center(child: Text("Error getting vocabularies"));
          },
          data: (CollectionState state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(state.tag.name, style: Theme.of(context).textTheme.headlineMedium),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit_rounded),
                    onPressed: () {
                      ref.read(collectionControllerProvider(tag).notifier).editTag();
                    },
                  ),
                ],
              ),
              body: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 16),
                  StatusCardIndicator(
                    tag: tag,
                    parent: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ref.read(collectionControllerProvider(tag).notifier).startPractise(context: context, tag: tag);
                        },
                        child: Text(AppLocalizations.of(context)?.home_statusCard_practiseButton ?? ""),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List<Widget>.generate(
                      state.tagVocabularies.length,
                      (index) => VocabularyListTile(
                        areImagesEnabled: state.areImagesEnabled,
                        vocabulary: state.tagVocabularies.elementAt(index),
                      ),
                    ).reversed.toList(),
                  ),
                  const SizedBox(height: 96),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
