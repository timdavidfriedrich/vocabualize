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
    final initCloudNotificationsUseCase = ref.watch(initCloudNotificationsUseCaseProvider);
    final initLocalNotificationsUseCase = ref.watch(initLocalNotificationsUseCaseProvider);
    final currentUser = ref.watch(getCurrentUserUseCaseProvider);

    initCloudNotificationsUseCase();
    initLocalNotificationsUseCase();

    return currentUser.when(
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
      data: (AppUser? user) {
        if (user == null) {
          return const WelcomeScreen();
        }
        if (!user.verified) {
          return const VerifyScreen();
        }
        return const HomeScreen();
      },
      error: (error, stackTrace) {
        Log.error("Error getting current user: $error", exception: stackTrace);
        return const Scaffold(body: Center(child: Text("Error getting current user")));
      },
    );
  }
}
