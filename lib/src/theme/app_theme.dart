import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

const _fontFamily = "Poppins";

const _brand = Color(0xFF22A2FF);
const _white = Color(0xFFFFFFFF);
const _black = Color(0xFF000000);
const _navy = Color(0xFF000D1A);
const _error = Color(0xFFF44336);

const _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: _brand,
  onPrimary: _white,
  primaryContainer: Color(0xFF0B3B5F),
  onPrimaryContainer: _white,
  secondary: _white,
  onSecondary: _black,
  secondaryContainer: _white,
  onSecondaryContainer: _black,
  error: _error,
  onError: _white,
  errorContainer: Color(0xFF2F1921),
  onErrorContainer: _error,
  surface: _navy,
  onSurface: _white,
  onSurfaceVariant: Color(0x99FFFFFF),
  outline: Color(0x66FFFFFF),
  outlineVariant: Color(0x33FFFFFF),
  surfaceDim: _navy,
  surfaceBright: Color(0xFF00355A),
  surfaceContainerLowest: Color(0xFF001C30),
  surfaceContainerLow: Color(0xFF002844),
  surfaceContainer: Color(0xFF002E4E),
  surfaceContainerHigh: Color(0xFF00355A),
  surfaceContainerHighest: Color(0xFF003C66),
  inverseSurface: _white,
  onInverseSurface: _navy,
  scrim: _black,
);

const _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: _brand,
  onPrimary: _white,
  primaryContainer: Color(0xFFC7E7FF),
  onPrimaryContainer: Color(0xFF003A63),
  secondary: _navy,
  onSecondary: _white,
  secondaryContainer: _navy,
  onSecondaryContainer: _white,
  error: _error,
  onError: _white,
  errorContainer: Color(0xFFFDE4E2),
  onErrorContainer: Color(0xFFC62828),
  surface: _white,
  onSurface: _navy,
  onSurfaceVariant: Color(0x99000D1A),
  outline: Color(0x66000D1A),
  outlineVariant: Color(0x33000D1A),
  surfaceDim: Color(0xFFE6F4FF),
  surfaceBright: _white,
  surfaceContainerLowest: Color(0xFFEAF6FF),
  surfaceContainerLow: Color(0xFFD5EEFF),
  surfaceContainer: Color(0xFFCAE9FF),
  surfaceContainerHigh: Color(0xFFBFE4FF),
  surfaceContainerHighest: Color(0xFFB4DFFF),
  inverseSurface: _navy,
  onInverseSurface: _white,
  scrim: _black,
);

const _levelColors = LevelColors(
  novice: Color(0xFF2196F3),
  beginner: Color(0xFFF44336),
  advanced: Color(0xFFFF9800),
  expert: Color(0xFF4CAF50),
);
const _overlayColors = OverlayColors(scrim: _black, onScrim: _white);
const _accountProviderColors = AccountProviderColors(google: _white, onGoogle: _black);
const _darkStatusColors = StatusColors(success: Color(0xFF81C784), warning: Color(0xFFFFB74D));
const _lightStatusColors = StatusColors(success: Color(0xFF2E7D32), warning: Color(0xFFEF6C00));
const _darkMascotColors = MascotColors(backdrop: Color(0xFF00355A));
const _lightMascotColors = MascotColors(backdrop: Color(0xFF53A3DD));

const _splashOpacity = 0.5;
const _pressedOpacity = 0.6;
const _dialogElevation = 8.0;
const _dialogWidth = 560.0;
const _dimmedStates = {WidgetState.disabled, WidgetState.pressed, WidgetState.hovered};

const _buttonPadding = EdgeInsets.symmetric(horizontal: Spacing.xxl, vertical: Spacing.m);
const _buttonMinimumSize = Size(0, Spacing.xxxl + Spacing.xs);
const _disabledSwitchAlpha = 0.38;
const _sliderTrackHeight = Spacing.m;
const _sliderTrackGap = Spacing.xxs;
const _sliderThumbSize = Size(4, 44);
const _sliderPressedThumbSize = Size(2, 44);
const _inputPadding = EdgeInsets.symmetric(horizontal: Spacing.l, vertical: Spacing.xs);
const _roundedShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusL)),
);
const _inputRadius = BorderRadius.all(Radius.circular(Spacing.radiusL));

abstract final class AppTheme {
  const AppTheme._();

  static ThemeData get dark =>
      _theme(_darkColorScheme, status: _darkStatusColors, mascot: _darkMascotColors);

  static ThemeData get light =>
      _theme(_lightColorScheme, status: _lightStatusColors, mascot: _lightMascotColors);

  static ThemeData _theme(
    ColorScheme colors, {
    required StatusColors status,
    required MascotColors mascot,
  }) {
    final baseTextTheme = ThemeData(brightness: colors.brightness).textTheme;
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
          bodyColor: colors.onSurface,
          displayColor: colors.onSurface,
        );
    final buttonTextStyle = textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
    BorderSide inputSide(Color color) {
      return BorderSide(color: color, width: Spacing.borderWidthMedium);
    }

    return ThemeData(
      useMaterial3: true,
      colorScheme: colors,
      fontFamily: _fontFamily,
      textTheme: textTheme,
      scaffoldBackgroundColor: colors.surface,
      hintColor: colors.outline,
      splashColor: colors.surfaceContainerLow.withValues(alpha: _splashOpacity),
      extensions: [status, mascot, _levelColors, _overlayColors, _accountProviderColors],
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colors.inverseSurface,
        contentTextStyle: textTheme.bodyLarge?.copyWith(color: colors.onInverseSurface),
        actionTextColor: colors.primary,
        insetPadding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusXxl)),
        ),
      ),
      cardTheme: CardThemeData(
        color: colors.surfaceContainerLow,
        elevation: 0,
        shape: _roundedShape,
      ),
      dialogTheme: DialogThemeData(
        constraints: const BoxConstraints(minWidth: _dialogWidth, maxWidth: _dialogWidth),
        elevation: _dialogElevation,
        backgroundColor: colors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusXxl)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => states.any(_dimmedStates.contains)
                ? colors.onPrimary.withValues(alpha: _pressedOpacity)
                : colors.onPrimary,
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.disabled)
                ? colors.outline
                : states.any(_dimmedStates.contains)
                ? colors.primary.withValues(alpha: _pressedOpacity)
                : colors.primary,
          ),
          padding: const WidgetStatePropertyAll(_buttonPadding),
          minimumSize: const WidgetStatePropertyAll(_buttonMinimumSize),
          textStyle: WidgetStatePropertyAll(buttonTextStyle),
          elevation: const WidgetStatePropertyAll(0),
          shape: const WidgetStatePropertyAll(StadiumBorder()),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: _buttonPadding,
          minimumSize: _buttonMinimumSize,
          shape: const StadiumBorder(),
          textStyle: buttonTextStyle,
        ),
      ),
      searchBarTheme: SearchBarThemeData(
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(colors.surfaceContainerLow),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: colors.onSurface),
      ),
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith(
          (states) => switch ((
            states.contains(WidgetState.selected),
            states.contains(WidgetState.disabled),
          )) {
            (true, false) => colors.primary,
            (true, true) => colors.primary.withValues(alpha: _disabledSwitchAlpha),
            (false, _) => colors.surfaceContainer,
          },
        ),
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => switch ((
            states.contains(WidgetState.selected),
            states.contains(WidgetState.disabled),
          )) {
            (true, _) => colors.onPrimary,
            (false, false) => colors.onSurfaceVariant,
            (false, true) => colors.onSurfaceVariant.withValues(alpha: _disabledSwitchAlpha),
          },
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: colors.primary,
        inactiveTrackColor: colors.surfaceContainer,
        trackHeight: _sliderTrackHeight,
        trackGap: _sliderTrackGap,
        trackShape: const GappedSliderTrackShape(),
        thumbShape: const HandleThumbShape(),
        thumbSize: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.dragged) || states.contains(WidgetState.focused)
              ? _sliderPressedThumbSize
              : _sliderThumbSize,
        ),
        overlayColor: Colors.transparent,
        valueIndicatorShape: const RoundedRectSliderValueIndicatorShape(),
      ),
      menuTheme: const MenuThemeData(
        style: MenuStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.zero),
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          shadowColor: WidgetStatePropertyAll(Colors.transparent),
          surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
          elevation: WidgetStatePropertyAll(0),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.primary,
        selectionColor: colors.outline,
        selectionHandleColor: colors.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: colors.outline),
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: _inputPadding,
        border: OutlineInputBorder(
          borderRadius: _inputRadius,
          borderSide: inputSide(colors.onSurface),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _inputRadius,
          borderSide: inputSide(colors.onSurface),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: _inputRadius,
          borderSide: inputSide(colors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _inputRadius,
          borderSide: inputSide(colors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: _inputRadius,
          borderSide: inputSide(colors.error),
        ),
      ),
    );
  }
}
