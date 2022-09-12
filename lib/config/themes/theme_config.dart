import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vocabualize/config/themes/light_theme.dart';
import 'package:vocabualize/config/themes/dark_theme.dart';
import 'package:vocabualize/constants/keys.dart';
//import 'package:vocabualize/utils/providers/color_provider.dart';

class ThemeHandler extends StatelessWidget {
  final Widget home;
  const ThemeHandler({Key? key, required this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      navigatorKey: Keys.navigatorState,
      theme: theme(
        context,
        lightPrimary,
        lightOnPrimary,
        lightSecondary,
        lightOnSecondary,
        lightBackground,
        lightOnBackground,
        lightSurface,
        lightOnSurface,
        lightHint,
        lightBorder,
        lightError,
      ),
      darkTheme: theme(
        context,
        darkPrimary,
        darkOnPrimary,
        darkSecondary,
        darkOnSecondary,
        darkBackground,
        darkOnBackground,
        darkSurface,
        darkOnSurface,
        darkHint,
        darkBorder,
        darkError,
      ),
      home: home,
    );
  }

  theme(context, primary, onPrimary, secondary, onSecondary, background, onBackground, surface, onSurface, hint, border, error) {
    //
    return ThemeData(
      //
      ///* Colors
      primaryColor: primary,
      //primarySwatch: customSwatch(primaryColor.value),
      //accentColor: secondaryColor,
      focusColor: secondary,
      cardColor: surface,
      canvasColor: surface,
      disabledColor: secondary.withOpacity(0.2),
      backgroundColor: background,
      scaffoldBackgroundColor: background,
      errorColor: error,
      hintColor: hint,
      dividerColor: hint,
      //buttonColor: secondaryColor,
      hoverColor: primary,
      indicatorColor: secondary,
      bottomAppBarColor: primary,
      dialogBackgroundColor: surface,

      ///* ColorScheme
      colorScheme: ColorScheme(
        primary: primary,
        //primaryVariant: borderColor,
        onPrimary: onPrimary,
        secondary: secondary,
        //secondaryVariant: secondaryColor,
        onSecondary: onSecondary,
        surface: surface,
        onSurface: onSurface,
        background: background,
        onBackground: onBackground,
        error: error,
        onError: onPrimary,
        brightness: Brightness.light,
      ),

      //splashColor: surface,

      visualDensity: VisualDensity.adaptivePlatformDensity,

      useMaterial3: true,

      ///* AppBar
      appBarTheme: AppBarTheme(color: background, elevation: 0, centerTitle: true),

      ///* Switch
      switchTheme: SwitchThemeData(
        trackColor:
            MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.selected) ? secondary.withOpacity(0.5) : border),
        thumbColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.selected) ? secondary : onPrimary),
      ),

      ///* Icons
      iconTheme: IconThemeData(color: onBackground),

      ///* ListTile
      listTileTheme: ListTileThemeData(iconColor: onBackground, selectedTileColor: surface),

      ///* ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(onPrimary),
          backgroundColor: MaterialStateProperty.all<Color>(primary),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.fromLTRB(32, 12, 32, 12),
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            GoogleFonts.poppins(
              color: onSurface,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),

      // ///* Dialog
      // dialogTheme: DialogTheme(
      //   elevation: 8,
      //   backgroundColor: background,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      // ),

      ///* Text-Themes
      textTheme: TextTheme(
        titleSmall: GoogleFonts.poppins(color: Colors.blue[300]),
        titleMedium: GoogleFonts.poppins(
          color: onBackground, // color: onPrimary,
        ),
        titleLarge: GoogleFonts.poppins(
          color: onBackground, // color: onPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: GoogleFonts.poppins(
          color: onBackground,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: GoogleFonts.poppins(
          color: onBackground,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: GoogleFonts.poppins(
          color: onBackground,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.poppins(
          color: onBackground,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        displayMedium: GoogleFonts.poppins(
          color: onBackground,
          fontSize: 16,
        ),
        displayLarge: GoogleFonts.poppins(
          color: onBackground,
          fontSize: 72,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: GoogleFonts.poppins(
          color: onBackground,
          fontSize: 11,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: onBackground,
          fontSize: 18,
          height: 1.5,
        ),
        bodyLarge: GoogleFonts.poppins(
          color: onBackground,
          fontSize: 24,
        ),
        labelSmall: GoogleFonts.poppins(
          color: onPrimary,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
        labelMedium: GoogleFonts.poppins(
          color: onPrimary,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        labelLarge: GoogleFonts.poppins(
          color: onPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

      ///* TextField-Themes etc.
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primary,
        selectionColor: secondary,
        selectionHandleColor: hint,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: onPrimary),
        labelStyle: TextStyle(color: primary),
        alignLabelWithHint: true,
        filled: false,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: onBackground, width: 4), borderRadius: BorderRadius.circular(16)),
        disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: hint, width: 4), borderRadius: BorderRadius.circular(16)),
        border: OutlineInputBorder(borderSide: BorderSide(color: onBackground, width: 4), borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: onBackground, width: 4), borderRadius: BorderRadius.circular(16)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: error), borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  ///* Color to ColorSwatch
  customSwatch(color) {
    return MaterialColor(
      color,
      <int, Color>{
        50: Color(color),
        100: Color(color),
        200: Color(color),
        300: Color(color),
        400: Color(color),
        500: Color(color),
        600: Color(color),
        700: Color(color),
        800: Color(color),
        900: Color(color),
      },
    );
  }
}
