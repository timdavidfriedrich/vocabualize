import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:vocabualize/src/common/domain/entities/app_user.dart';
import 'package:vocabualize/src/common/domain/use_cases/authentication/get_current_user_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/notification/init_cloud_notifications_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/notification/init_local_notifications_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/notification/schedule_gather_notification_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/notification/schedule_practise_notification_use_case.dart';
import 'package:vocabualize/src/features/home/presentation/screens/home_screen.dart';
import 'package:vocabualize/src/features/onboarding/presentation/screens/verify_screen.dart';
import 'package:vocabualize/src/features/onboarding/presentation/screens/welcome_screen.dart';

class Start extends ConsumerWidget {
  static const routeName = "/";
  const Start({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          true => const _HomeScreen(),
          false => const VerifyScreen(),
          null => const WelcomeScreen(),
        };
      },
    );
  }
}

class _HomeScreen extends ConsumerWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> scheduleNotification() async {
      ref.read(initCloudNotificationsUseCaseProvider)();
      ref.read(initLocalNotificationsUseCaseProvider)().then((_) async {
        await ref.read(scheduleGatherNotificationUseCaseProvider)();
        await ref.read(schedulePractiseNotificationUseCaseProvider)();
      });
    }

    return FutureBuilder(
      future: scheduleNotification(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        return const HomeScreen();
      },
    );
  }
}
