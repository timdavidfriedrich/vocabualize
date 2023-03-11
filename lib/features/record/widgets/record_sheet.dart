
import 'package:vocabualize/constants/common_imports.dart';
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
      // ! TODO: Replace padding with relative screen size and/or min() for tablet support
      padding: const EdgeInsets.symmetric(horizontal: 48),
      color: Theme.of(context).colorScheme.primary,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 48),
          Provider.of<ActiveProvider>(context).typeIsActive ? Container() : const MicButton(),
          const SizedBox(height: 48),
          const TypeButton(),
        ],
      ),
    );
  }
}
