import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/record/providers/active_provider.dart';
import 'package:vocabualize/features/record/widgets/mic_button.dart';
import 'package:vocabualize/features/record/widgets/type_button.dart';

class RecordSheet extends StatefulWidget {
  const RecordSheet({Key? key}) : super(key: key);

  @override
  State<RecordSheet> createState() => _RecordSheetState();
}

class _RecordSheetState extends State<RecordSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
      color: Theme.of(context).colorScheme.primary,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Provider.of<ActiveProvider>(context).typeIsActive ? Container() : const MicButton(),
          const TypeButton(),
        ],
      ),
    );
  }
}
