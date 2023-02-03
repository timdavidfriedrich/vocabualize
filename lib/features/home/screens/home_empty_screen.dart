import 'package:vocabualize/constants/common_imports.dart';

class HomeEmptyScreen extends StatelessWidget {
  const HomeEmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        // TODO: Replace with arb
        "Swipe up to add your first word.",
        textAlign: TextAlign.center,
      ),
    );
  }
}
