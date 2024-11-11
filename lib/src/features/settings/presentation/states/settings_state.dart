import 'package:flutter/material.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';

class SettingsState {
  final Language sourceLanguage;
  final Language targetLanguage;
  final bool areImagesEnabled;
  final bool usePremiumTranslator;
  final TimeOfDay gatherNotificationTime;
  final TimeOfDay practiseNotificationTime;

  const SettingsState({
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.areImagesEnabled,
    required this.usePremiumTranslator,
    required this.gatherNotificationTime,
    required this.practiseNotificationTime,
  });

  SettingsState copyWith({
    Language? sourceLanguage,
    Language? targetLanguage,
    bool? areImagesEnabled,
    bool? usePremiumTranslator,
    TimeOfDay? gatherNotificationTime,
    TimeOfDay? practiseNotificationTime,
  }) {
    return SettingsState(
      sourceLanguage: sourceLanguage ?? this.sourceLanguage,
      targetLanguage: targetLanguage ?? this.targetLanguage,
      areImagesEnabled: areImagesEnabled ?? this.areImagesEnabled,
      usePremiumTranslator: usePremiumTranslator ?? this.usePremiumTranslator,
      gatherNotificationTime: gatherNotificationTime ?? this.gatherNotificationTime,
      practiseNotificationTime: practiseNotificationTime ?? this.practiseNotificationTime,
    );
  }
}
