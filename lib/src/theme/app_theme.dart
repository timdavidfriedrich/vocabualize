import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

const _seedColor = Color(0xFF3F51B5);
const _successLight = Color(0xFF2E7D32);
const _successDark = Color(0xFF81C784);
const _warningLight = Color(0xFFED6C02);
const _warningDark = Color(0xFFFFB74D);

abstract final class AppTheme {
  const AppTheme._();

  static ThemeData get light => _build(Brightness.light);

  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _seedColor, brightness: brightness),
      extensions: [
        StatusColors(
          success: isLight ? _successLight : _successDark,
          warning: isLight ? _warningLight : _warningDark,
        ),
      ],
      cardTheme: const CardThemeData(
        elevation: Spacing.elevationS,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusM)),
        ),
      ),
    );
  }
}
