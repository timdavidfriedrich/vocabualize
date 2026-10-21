// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Vocabualize';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get back => 'Back';

  @override
  String get tryAgain => 'Try again';

  @override
  String get error => 'Error';

  @override
  String get errorConnection => 'No internet connection.';

  @override
  String errorApi(String message) {
    return 'Error while communicating with the server: $message.';
  }

  @override
  String get errorAuth => 'You are not signed in.';

  @override
  String get errorValidation => 'The data received is invalid.';

  @override
  String get errorNotFound => 'Not found.';

  @override
  String get errorUnexpected => 'An unexpected error occurred.';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeEmptyMessage => 'Nothing here yet.';
}
