import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:vocabualize/main.dart';
import 'package:vocabualize/config/themes/light_theme.dart';
import 'package:vocabualize/config/themes/dark_theme.dart';
//import 'package:vocabualize/utils/providers/color_provider.dart';

class ThemeHandler extends StatelessWidget {
  final Widget home;
  const ThemeHandler({Key? key, required this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(
        context,
        lightPrimary,
        lightOnPrimary,
        lightSecondary, //Provider.of<ColorProvider>(context).secondaryColor,
        lightOnSecondary,
        lightBackground,
        lightSurface,
        lightHint,
        lightBorder,
        lightError,
      ),
      darkTheme: theme(
        context,
        darkPrimary,
        darkOnPrimary,
        darkSecondary, //Provider.of<ColorProvider>(context).secondaryColor,
        darkOnSecondary,
        darkBackground,
        darkSurface,
        darkHint,
        darkBorder,
        darkError,
      ),
      home: home,
    );
  }

  theme(context, primary, onPrimary, secondary, onSecondary, background, surface, hint, border, error) {
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
        onSurface: onPrimary,
        background: background,
        onBackground: onPrimary,
        error: error,
        onError: onPrimary,
        brightness: Brightness.light,
      ),

      visualDensity: VisualDensity.adaptivePlatformDensity,

      ///* AppBar
      appBarTheme: AppBarTheme(color: background, elevation: 0, centerTitle: true),

      ///* Switch
      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.selected) ? secondary.withOpacity(0.5) : border),
        thumbColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.selected) ? secondary : onPrimary),
      ),

      ///* Icons
      iconTheme: IconThemeData(color: onPrimary),

      ///* ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(onSecondary),
          backgroundColor: MaterialStateProperty.all<Color>(surface),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.fromLTRB(18, 14, 18, 14),
          ),
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),

      ///* Text-Themes
      textTheme: TextTheme(
        titleSmall: GoogleFonts.poppins(color: Colors.blue[300]),
        titleMedium: GoogleFonts.poppins(color: onPrimary),
        titleLarge: GoogleFonts.poppins(
          color: onPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: GoogleFonts.poppins(color: Colors.pink[300]),
        headlineMedium: GoogleFonts.poppins(color: Colors.pink[600]),
        headlineLarge: GoogleFonts.poppins(color: Colors.pink[900]),
        displaySmall: GoogleFonts.poppins(
          color: onPrimary,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        displayMedium: GoogleFonts.poppins(
          color: onPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        displayLarge: GoogleFonts.poppins(
          color: onPrimary,
          fontSize: 72,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: GoogleFonts.inter(color: onPrimary, fontSize: 11),
        bodyMedium: GoogleFonts.inter(
          color: onPrimary,
          fontSize: 18,
          height: 1.5,
        ),
        bodyLarge: GoogleFonts.inter(color: Colors.amber[900]),
        labelSmall: GoogleFonts.inter(
          color: onPrimary,
          fontSize: 12,
        ),
        labelMedium: GoogleFonts.inter(
          color: onPrimary,
          fontSize: 16,
        ),
        labelLarge: GoogleFonts.inter(
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
        hintStyle: TextStyle(color: primary),
        labelStyle: TextStyle(color: primary),
        alignLabelWithHint: true,
        filled: false,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: secondary, width: 4), borderRadius: BorderRadius.circular(16)),
        disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: hint, width: 4), borderRadius: BorderRadius.circular(16)),
        border: OutlineInputBorder(borderSide: BorderSide(color: secondary, width: 4), borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: secondary, width: 4), borderRadius: BorderRadius.circular(16)),
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
