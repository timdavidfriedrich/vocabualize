import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

const _fontFamily = "Poppins";

const _primary = Color(0xFF22A2FF);
const _onPrimary = Color(0xFFFFFFFF);
const _secondary = Color(0xFFFFFFFF);
const _onSecondary = Color(0xFF000000);
const _error = Color(0xFFF44336);
const _onError = Color(0xFFFFFFFF);
const _surface = Color(0xFF000D1A);
const _onSurface = Color(0xFFFFFFFF);
const _onSurfaceVariant = Color(0x99FFFFFF);
const _outline = Color(0x66FFFFFF);
const _outlineVariant = Color(0x33FFFFFF);
const _surfaceContainerLowest = Color(0xFF000A14);
const _surfaceContainerLow = Color(0xFF002844);
const _surfaceContainer = Color(0xFF002E4E);
const _surfaceContainerHigh = Color(0xFF00355A);
const _surfaceContainerHighest = Color(0xFF003C66);

const _success = Color(0xFF81C784);
const _warning = Color(0xFFFFB74D);

const _levelNovice = Color(0xFF2196F3);
const _levelBeginner = Color(0xFFF44336);
const _levelAdvanced = Color(0xFFFF9800);
const _levelExpert = Color(0xFF4CAF50);

const _splash = Color(0x80002844);
const _pressedOpacity = 0.6;
const _dialogElevation = 8.0;
const _dimmedStates = {WidgetState.disabled, WidgetState.pressed, WidgetState.hovered};

const _buttonPadding = EdgeInsets.symmetric(horizontal: Spacing.xxl, vertical: Spacing.s);
const _inputPadding = EdgeInsets.symmetric(horizontal: Spacing.l, vertical: Spacing.xs);

abstract final class AppTheme {
  const AppTheme._();

  static ThemeData get dark {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: _primary,
      onPrimary: _onPrimary,
      secondary: _secondary,
      onSecondary: _onSecondary,
      error: _error,
      onError: _onError,
      surface: _surface,
      onSurface: _onSurface,
      onSurfaceVariant: _onSurfaceVariant,
      outline: _outline,
      outlineVariant: _outlineVariant,
      surfaceDim: _surface,
      surfaceBright: _surfaceContainerHigh,
      surfaceContainerLowest: _surfaceContainerLowest,
      surfaceContainerLow: _surfaceContainerLow,
      surfaceContainer: _surfaceContainer,
      surfaceContainerHigh: _surfaceContainerHigh,
      surfaceContainerHighest: _surfaceContainerHighest,
    );
    final baseTextTheme = ThemeData(brightness: Brightness.dark).textTheme;
    final textTheme = baseTextTheme
        .copyWith(
          headlineLarge: baseTextTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
          headlineMedium: baseTextTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          headlineSmall: baseTextTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          titleLarge: baseTextTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          labelLarge: baseTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
        )
        .apply(
          fontFamily: _fontFamily,
          bodyColor: _onSurface,
          displayColor: _onSurface,
        );
    const roundedButtonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusL)),
    );
    const inputRadius = BorderRadius.all(Radius.circular(Spacing.radiusL));
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: _fontFamily,
      textTheme: textTheme,
      scaffoldBackgroundColor: _surface,
      hintColor: _outline,
      splashColor: _splash,
      extensions: const [
        StatusColors(success: _success, warning: _warning),
        LevelColors(
          novice: _levelNovice,
          beginner: _levelBeginner,
          advanced: _levelAdvanced,
          expert: _levelExpert,
        ),
      ],
      appBarTheme: const AppBarTheme(
        backgroundColor: _surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      cardTheme: const CardThemeData(
        color: _surfaceContainerLow,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusL)),
        ),
      ),
      dialogTheme: const DialogThemeData(
        elevation: _dialogElevation,
        backgroundColor: _surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusXxl)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => states.any(_dimmedStates.contains)
                ? _onPrimary.withValues(alpha: _pressedOpacity)
                : _onPrimary,
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.disabled)
                ? _outline
                : states.any(_dimmedStates.contains)
                ? _primary.withValues(alpha: _pressedOpacity)
                : _primary,
          ),
          padding: const WidgetStatePropertyAll(_buttonPadding),
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
          elevation: const WidgetStatePropertyAll(0),
          shape: const WidgetStatePropertyAll(roundedButtonShape),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: _buttonPadding,
          shape: roundedButtonShape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.disabled) ? _outline : _onSurface,
          ),
          padding: const WidgetStatePropertyAll(_buttonPadding),
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
          elevation: const WidgetStatePropertyAll(0),
          shape: const WidgetStatePropertyAll(roundedButtonShape),
          side: WidgetStateProperty.resolveWith(
            (states) => BorderSide(
              color: states.contains(WidgetState.disabled) ? _outline : _primary,
              width: Spacing.borderWidthMedium,
            ),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: _onSurface),
      ),
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? _primary : _surfaceContainer,
        ),
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? _onPrimary : _onSurfaceVariant,
        ),
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: _primary,
        inactiveTrackColor: _surfaceContainer,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: _primary,
        selectionColor: _outline,
        selectionHandleColor: _primary,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: _outline),
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: _inputPadding,
        border: OutlineInputBorder(
          borderRadius: inputRadius,
          borderSide: BorderSide(color: _onSurface, width: Spacing.borderWidthMedium),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: inputRadius,
          borderSide: BorderSide(color: _onSurface, width: Spacing.borderWidthMedium),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: inputRadius,
          borderSide: BorderSide(color: _outline, width: Spacing.borderWidthMedium),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: inputRadius,
          borderSide: BorderSide(color: _primary, width: Spacing.borderWidthMedium),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: inputRadius,
          borderSide: BorderSide(color: _error, width: Spacing.borderWidthMedium),
        ),
      ),
    );
  }
}
