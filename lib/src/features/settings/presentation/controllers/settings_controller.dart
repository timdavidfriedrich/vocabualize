import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/extensions/object_extensions.dart';
import 'package:vocabualize/src/common/domain/use_cases/authentication/get_current_user_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/authentication/sign_out_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_are_images_enabled_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_gather_notification_time_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_practise_notification_time_use_dart.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_source_language_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_target_language_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_use_premium_translator_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/set_are_images_enabled_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/set_gather_notification_time_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/set_practise_notification_time_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/set_source_language_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/set_target_language_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/set_use_premium_translator_use_case.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';
import 'package:vocabualize/src/common/presentation/screens/language_picker_screen.dart';
import 'package:vocabualize/src/features/settings/presentation/states/settings_state.dart';

final settingsControllerProvider =
    AutoDisposeAsyncNotifierProvider<SettingsController, SettingsState>(() {
  return SettingsController();
});

class SettingsController extends AutoDisposeAsyncNotifier<SettingsState> {
  @override
  Future<SettingsState> build() async {
    return SettingsState(
      currentUser: ref.read(getCurrentUserUseCaseProvider).value,
      sourceLanguage: await ref.read(getSourceLanguageUseCaseProvider),
      targetLanguage: await ref.read(getTargetLanguageUseCaseProvider),
      areImagesEnabled:
          await ref.read(getAreImagesEnabledUseCaseProvider.future),
      usePremiumTranslator:
          await ref.read(getUsePremiumTranslatorUseCaseProvider.future),
      gatherNotificationTime:
          await ref.read(getGatherNotificationTimeUseCaseProvider),
      practiseNotificationTime:
          await ref.read(getPractiseNotificationTimeUseCaseProvider),
    );
  }

  Future<void> signIn(BuildContext context) async {
    // TODO: Implement signIn button for SettingsScreen
    // * Basically, this should be a sign out, but keep the data and save all data to a new user
    // ? What happens if user signs in with an existing account? Should we merge the data?
    await ref.watch(signOutUseCaseProvider)().whenComplete(() {
      context.pop();
    });
  }

  Future<void> signOut(BuildContext context) async {
    await ref.watch(signOutUseCaseProvider)().whenComplete(() {
      context.pop();
    });
  }

  Future<void> selectSourceLanguage(BuildContext context) async {
    state.value?.let((value) async {
      final seletectedLanguage =
          await context.pushNamed(LanguagePickerScreen.routeName) as Language?;
      seletectedLanguage?.let((language) async {
        state = const AsyncLoading();
        state = await AsyncValue.guard(() async {
          await ref.read(setSourceLanguageUseCaseProvider(language));
          return value.copyWith(sourceLanguage: language);
        });
      });
    });
  }

  Future<void> selectTargetLanguage(BuildContext context) async {
    state.value?.let((value) async {
      final seletectedLanguage =
          await context.pushNamed(LanguagePickerScreen.routeName) as Language?;
      seletectedLanguage?.let((language) async {
        state = const AsyncLoading();
        state = await AsyncValue.guard(() async {
          await ref.read(setTargetLanguageUseCaseProvider(language));
          return value.copyWith(targetLanguage: language);
        });
      });
    });
  }

  Future<void> setAreImagesEnabled(bool areImagesEnabled) async {
    state.value?.let((value) async {
      state = await AsyncValue.guard(() async {
        await ref.read(setAreImagesEnabledUseCaseProvider(
          areImagesEnabled,
        ).future);
        return value.copyWith(areImagesEnabled: areImagesEnabled);
      });
    });
  }

  Future<void> setUsePremiumTranslator(bool usePremiumTranslator) async {
    state.value?.let((value) async {
      state = await AsyncValue.guard(() async {
        await ref.read(setUsePremiumTranslatorUseCaseProvider(
          usePremiumTranslator,
        ).future);
        return value.copyWith(usePremiumTranslator: usePremiumTranslator);
      });
    });
  }

  Future<void> selectGatherNotificationTime(BuildContext context) async {
    state.value?.let((value) async {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: value.gatherNotificationTime,
      );
      selectedTime?.let((time) async {
        state = const AsyncLoading();
        state = await AsyncValue.guard(() async {
          await ref.read(setGatherNotificationTimeUseCaseProvider(time));
          return value.copyWith(gatherNotificationTime: time);
        });
      });
    });
  }

  Future<void> selectPractiseNotificationTime(BuildContext context) async {
    state.value?.let((value) async {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: value.practiseNotificationTime,
      );
      selectedTime?.let((time) async {
        state = const AsyncLoading();
        state = await AsyncValue.guard(() async {
          await ref.read(setPractiseNotificationTimeUseCaseProvider(time));
          return value.copyWith(practiseNotificationTime: time);
        });
      });
    });
  }
}
