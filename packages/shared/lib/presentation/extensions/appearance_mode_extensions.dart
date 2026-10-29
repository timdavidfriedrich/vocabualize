import 'package:flutter/material.dart';
import 'package:shared/domain/entities/appearance_mode.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

extension AppearanceModeExtensions on AppearanceMode {
  ThemeMode toThemeMode() => switch (this) {
    AppearanceMode.system => ThemeMode.system,
    AppearanceMode.light => ThemeMode.light,
    AppearanceMode.dark => ThemeMode.dark,
  };

  String toLabel(BuildContext context) => switch (this) {
    AppearanceMode.system => context.s.settingsAppearanceSystem,
    AppearanceMode.light => context.s.settingsAppearanceLight,
    AppearanceMode.dark => context.s.settingsAppearanceDark,
  };
}
