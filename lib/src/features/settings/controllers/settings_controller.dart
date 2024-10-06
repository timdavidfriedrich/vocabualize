import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/usecases/language/set_target_language_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/get_are_images_enabled_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/get_gather_notification_time_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/get_practise_notification_time_use_dart.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/get_source_language_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/get_target_language_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/get_use_premium_translator_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/set_are_images_enabled_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/set_gather_notification_time_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/set_practise_notification_time_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/set_source_language_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/set_use_premium_translator_use_case.dart';
import 'package:vocabualize/src/common/presentation/screens/language_picker_screen.dart';
import 'package:vocabualize/src/features/settings/states/settings_state.dart';

final settingsControllerProvider = AutoDisposeAsyncNotifierProvider<SettingsController, SettingsState>(() {
  return SettingsController();
});

class SettingsController extends AutoDisposeAsyncNotifier<SettingsState> {
  @override
  Future<SettingsState> build() async {
    state = const AsyncLoading();
    return SettingsState(
      sourceLanguage: await ref.watch(getSourceLanguageUseCaseProvider),
      targetLanguage: await ref.watch(getTargetLanguageUseCaseProvider),
      usePremiumTranslator: await ref.watch(getUsePremiumTranslatorUseCaseProvider),
      areImagesEnabled: await ref.watch(getAreImagesEnabledUseCaseProvider),
      gatherNotificationTime: await ref.watch(getGatherNotificationTimeUseCaseProvider),
      practiseNotificationTime: await ref.watch(getPractiseNotificationTimeUseCaseProvider),
    );
  }

  Future<void> selectSourceLanguage(BuildContext context) async {
    final seletectedLanguage = await Navigator.pushNamed(context, LanguagePickerScreen.routeName) as Language?;
    if (seletectedLanguage != null) {
      state = const AsyncLoading();
      await ref.read(setSourceLanguageUseCaseProvider(seletectedLanguage));
    }
  }

  Future<void> selectTargetLanguage(BuildContext context) async {
    final seletectedLanguage = await Navigator.pushNamed(context, LanguagePickerScreen.routeName) as Language?;
    if (seletectedLanguage != null) {
      state = const AsyncLoading();
      await ref.read(setTargetLanguageUseCaseProvider(seletectedLanguage));
    }
  }

  Future<void> setUsePremiumTranslator(bool value) async {
    state = const AsyncLoading();
    await ref.read(setUsePremiumTranslatorUseCaseProvider(value));
  }

  Future<void> setAreImagesEnabled(bool value) async {
    state = const AsyncLoading();
    await ref.read(setAreImagesEnabledUseCaseProvider(value));
  }

  Future<void> selectGatherNotificationTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null && context.mounted) {
      state = const AsyncLoading();
      await ref.read(setGatherNotificationTimeUseCaseProvider(time));
    }
  }

  Future<void> selectPractiseNotificationTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null && context.mounted) {
      state = const AsyncLoading();
      await ref.read(setPractiseNotificationTimeUseCaseProvider(time));
    }
  }

  /*
  Future<void> getSourceLanguage() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref.read(getSourceLanguageUseCaseProvider);
    }).then(
      (AsyncValue<Language> asyncLanguage) async {
        final newState = state.asData?.value.copyWith(
          sourceLanguage: asyncLanguage.value,
        );
        if (newState != null) {
          return AsyncData(newState);
        }
        return state;
      },
    );
  }
  */
}
