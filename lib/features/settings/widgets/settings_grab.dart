import 'package:vocabualize/constants/common_imports.dart';

class SettingsGrab extends StatelessWidget {
  const SettingsGrab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
        boxShadow: [BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.42))],
      ),
      padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
      child: Center(
        child: Container(
          width: 48,
          height: 6,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}
