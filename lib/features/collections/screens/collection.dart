import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/collections/services/collection_arguments.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/home/widgets/vocabulary_list_tile.dart';

class Collection extends StatefulWidget {
  const Collection({super.key});

  static const routeName = "/Collection";

  @override
  State<Collection> createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  String tag = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      CollectionArguments arguments = ModalRoute.of(context)!.settings.arguments as CollectionArguments;
      setState(() => tag = arguments.tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
          appBar: AppBar(title: Text(tag, style: Theme.of(context).textTheme.headlineLarge)),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List<Widget>.generate(
                        Provider.of<VocabularyProvider>(context).getVocabulariesByTag(tag).length,
                        (index) => VocabularyListTile(
                          vocabulary: Provider.of<VocabularyProvider>(context).getVocabulariesByTag(tag).elementAt(index),
                        ),
                      ).reversed.toList(),
                    ),
                    const SizedBox(height: 96),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
