import 'package:vocabualize/constants/common_imports.dart';

class RecordGrab extends StatelessWidget {
  const RecordGrab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        // BorderRadius.only(topLeft: Radius.elliptical(42, 36), topRight: Radius.elliptical(42, 36)),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
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
