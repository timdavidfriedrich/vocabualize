import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/localization/generated/app_localizations.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get s => AppLocalizations.of(this);

  ColorScheme get c => Theme.of(this).colorScheme;

  TextTheme get t => Theme.of(this).textTheme;

  StatusColors get status => Theme.of(this).extension<StatusColors>()!;

  void showToast(String message, {SnackBarAction? action}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message), action: action));
  }
}
