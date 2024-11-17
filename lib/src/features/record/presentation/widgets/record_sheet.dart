import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/src/features/record/presentation/providers/active_provider.dart';
import 'package:vocabualize/src/features/record/presentation/widgets/mic_button.dart';
import 'package:vocabualize/src/features/record/presentation/widgets/type_button.dart';

class RecordSheet extends StatefulWidget {
  const RecordSheet({super.key});

  @override
  State<RecordSheet> createState() => _RecordSheetState();
}

class _RecordSheetState extends State<RecordSheet> {
  final paddingFactor = 0.135;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        // * Calculates the "perfect" padding value according to screen size
        horizontal: MediaQuery.of(context).size.height * MediaQuery.of(context).size.aspectRatio * paddingFactor,
      ),
      color: Theme.of(context).colorScheme.primary,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Provider.of<ActiveProvider>(context).typeIsActive
              ? Container()
              : const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 48),
                    MicButton(),
                    SizedBox(height: 48),
                  ],
                ),
          const TypeButton(),
        ],
      ),
    );
  }
}
