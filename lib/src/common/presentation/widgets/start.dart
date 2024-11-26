import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:vocabualize/src/common/domain/entities/app_user.dart';
import 'package:vocabualize/src/common/domain/use_cases/authentication/get_current_user_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/notification/init_cloud_notifications_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/notification/init_local_notifications_use_case.dart';
import 'package:vocabualize/src/features/home/presentation/screens/home_screen.dart';
import 'package:vocabualize/src/features/onboarding/presentation/screens/verify_screen.dart';
import 'package:vocabualize/src/features/onboarding/presentation/screens/welcome_screen.dart';

class Start extends ConsumerWidget {
  static const routeName = "/";
  const Start({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(initCloudNotificationsUseCaseProvider)();
    ref.watch(initLocalNotificationsUseCaseProvider)();

    final currentUser = ref.watch(getCurrentUserUseCaseProvider);
    return currentUser.when(
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
      error: (error, stackTrace) {
        Log.error("Error getting current user: $error", exception: stackTrace);
        // TODO: Replace with Error widget
        return const Scaffold(
          body: Center(child: Text("Error getting current user")),
        );
      },
      data: (AppUser? user) {
        return switch (user?.verified) {
          true => const HomeScreen(),
          false => const VerifyScreen(),
          null => const WelcomeScreen(),
        };
      },
    );
  }
}
