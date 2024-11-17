import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/extensions/object_extensions.dart';
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
import 'package:vocabualize/src/common/presentation/screens/language_picker_screen.dart';
import 'package:vocabualize/src/features/settings/presentation/states/settings_state.dart';

final settingsControllerProvider = AutoDisposeAsyncNotifierProvider<SettingsController, SettingsState>(() {
  return SettingsController();
});

class SettingsController extends AutoDisposeAsyncNotifier<SettingsState> {
  @override
  Future<SettingsState> build() async {
    return SettingsState(
      sourceLanguage: await ref.watch(getSourceLanguageUseCaseProvider),
      targetLanguage: await ref.watch(getTargetLanguageUseCaseProvider),
      areImagesEnabled: await ref.watch(getAreImagesEnabledUseCaseProvider.future),
      usePremiumTranslator: await ref.watch(getUsePremiumTranslatorUseCaseProvider.future),
      gatherNotificationTime: await ref.watch(getGatherNotificationTimeUseCaseProvider),
      practiseNotificationTime: await ref.watch(getPractiseNotificationTimeUseCaseProvider),
    );
  }

  Future<void> selectSourceLanguage(BuildContext context) async {
    final seletectedLanguage = await Navigator.pushNamed(context, LanguagePickerScreen.routeName) as Language?;
    seletectedLanguage?.let((language) async {
      state = const AsyncLoading();
      await ref.read(setSourceLanguageUseCaseProvider(language));
    });
  }

  Future<void> selectTargetLanguage(BuildContext context) async {
    final seletectedLanguage = await Navigator.pushNamed(context, LanguagePickerScreen.routeName) as Language?;
    seletectedLanguage?.let((language) async {
      state = const AsyncLoading();
      await ref.read(setTargetLanguageUseCaseProvider(language));
    });
  }

  Future<void> setAreImagesEnabled(bool areImagesEnabled) async {
    state.value?.let((value) async {
      await ref.read(setAreImagesEnabledUseCaseProvider(areImagesEnabled).future);
      state = AsyncData(
        value.copyWith(
          areImagesEnabled: areImagesEnabled,
        ),
      );
    });
  }

  Future<void> setUsePremiumTranslator(bool usePremiumTranslator) async {
    state.value?.let((value) async {
      await ref.read(setUsePremiumTranslatorUseCaseProvider(usePremiumTranslator).future);
      state = AsyncData(
        value.copyWith(
          usePremiumTranslator: usePremiumTranslator,
        ),
      );
    });
  }

  Future<void> selectGatherNotificationTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    time?.let((t) async {
      await ref.read(setGatherNotificationTimeUseCaseProvider(t));
    });
  }

  Future<void> selectPractiseNotificationTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    time?.let((t) async {
      await ref.read(setPractiseNotificationTimeUseCaseProvider(t));
    });
  }
}
