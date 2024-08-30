import 'package:vocabualize/constants/common_imports.dart';
import 'package:flutter/scheduler.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/get_vocabularies_to_practise_use_case.dart';
import 'package:vocabualize/src/features/collections/utils/collection_arguments.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_database_data_source.dart';
import 'package:vocabualize/src/features/home/screens/home_screen.dart';
import 'package:vocabualize/src/features/home/widgets/status_card_indicator.dart';
import 'package:vocabualize/src/features/home/widgets/vocabulary_list_tile.dart';
import 'package:vocabualize/src/features/practise/screens/practise_screen.dart';
import 'package:vocabualize/src/features/practise/utils/practise_arguments.dart';

class CollectionScreen extends StatefulWidget {
  static const String routeName = "${HomeScreen.routeName}/Collection";

  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final getVocabulariesToPractise = sl.get<GetVocabulariesToPractiseUseCase>();
  Tag tag = Tag.empty();

  void _editTag() {
    // TODO: implement edit tag / collection
  }

  void _startPractise() async {
    final vocabulariesToPractise = await getVocabulariesToPractise(tag: tag);
    if (!mounted) return;
    Navigator.pushNamed(
      context,
      PractiseScreen.routeName,
      arguments: PractiseScreenArguments(
        vocabulariesToPractise: vocabulariesToPractise,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      CollectionScreenArguments arguments = ModalRoute.of(context)!.settings.arguments as CollectionScreenArguments;
      setState(() => tag = arguments.tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
          appBar: AppBar(
            title: Text(tag.name, style: Theme.of(context).textTheme.headlineMedium),
            actions: [IconButton(icon: const Icon(Icons.edit_rounded), onPressed: () => _editTag())],
          ),
          body: StreamBuilder<List<Vocabulary>>(
              stream: RemoteDatabaseDataSource.instance.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator.adaptive());
                }
                List<Vocabulary> vocabularyList = snapshot.data!;
                List<Vocabulary> vocabulariesWithTag = vocabularyList.where((vocabulary) => vocabulary.tags.contains(tag)).toList();
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
                          onPressed: () => _startPractise(),
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
              }),
        ),
      ),
    );
  }
}
