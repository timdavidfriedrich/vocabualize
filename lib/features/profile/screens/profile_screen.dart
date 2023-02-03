import 'package:vocabualize/constants/common_imports.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = "/Profile";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(),
      ),
    );
  }
}
