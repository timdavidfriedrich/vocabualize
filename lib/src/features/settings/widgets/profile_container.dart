import 'package:firebase_auth/firebase_auth.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/usecases/authentication/sign_out_use_case.dart';

class ProfileContainer extends StatefulWidget {
  const ProfileContainer({super.key});

  @override
  State<ProfileContainer> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  final _signOut = sl.get<SignOutUseCase>();

  void _onSignOutClick() async {
    await _signOut();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: 1 + 1 != 2 // FirebaseAuth.instance.currentUser!.isAnonymous
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline_rounded, size: 32, color: Theme.of(context).colorScheme.onBackground),
                    const SizedBox(width: 16),
                    // TODO: Replace with arb
                    const Flexible(child: Text("Sign in to sync your data across devices.")),
                  ],
                ),
                const SizedBox(height: 16),
                // TODO: Replace with arb
                ElevatedButton(onPressed: () => _onSignOutClick(), child: const Text("Sign in")),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                1 + 1 != 2 // FirebaseAuth.instance.currentUser!.photoURL != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
                      )
                    : CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(Icons.person, color: Theme.of(context).colorScheme.onPrimary),
                      ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TODO: Replace with arb
                      Text("Signed in as: ", style: Theme.of(context).textTheme.labelSmall),
                      // Text(FirebaseAuth.instance.currentUser!.email!),
                      const SizedBox(height: 16),
                      // TODO: Replace with arb
                      Align(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(onPressed: () => _onSignOutClick(), child: const Text("Sign out")),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
