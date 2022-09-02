import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/screens/collection.dart';
import 'package:vocabualize/screens/practise.dart';
import 'package:vocabualize/screens/practise_done.dart';
import 'package:vocabualize/screens/settings.dart';
import 'package:vocabualize/utils/providers/visible_provider.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';
import 'package:vocabualize/utils/teleport.dart';
import 'package:vocabualize/widgets/mic_button.dart';
import 'package:vocabualize/widgets/type_instead.dart';
import 'package:vocabualize/widgets/ui_core/buttons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Provider.of<VocProv>(context, listen: false).initVocabularyList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Vocabualize",
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
        child: Column(
          // physics: const BouncingScrollPhysics(),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(flex: 1),
            const MicButton(),
            const TypeInstead(),
            const Spacer(flex: 3),
            VisibilityButton(
              visible: !Provider.of<VisibleProv>(context).getMicIsActive(),
              background: Theme.of(context).colorScheme.secondary,
              foreground: Theme.of(context).colorScheme.onSecondary,
              onPressed: () => Navigator.push(
                context,
                Teleport(
                  child: Provider.of<VocProv>(context, listen: false).getAllToPractise().isEmpty ? const PractiseDone() : const Practise(),
                  type: "slide_bottom",
                ),
              ),
              child: const Text("Practise"),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                VisibilityButton(
                  visible: !Provider.of<VisibleProv>(context).getMicIsActive(),
                  onPressed: () => Navigator.push(context, Teleport(child: const Settings(), type: "slide_left")),
                  child: const Icon(Icons.settings_outlined),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: VisibilityButton(
                    visible: !Provider.of<VisibleProv>(context).getMicIsActive(),
                    onPressed: () => Navigator.push(context, Teleport(child: const Collection(), type: "slide_right")),
                    child: const Text("Collection"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
