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
  String get unknown => 'unknown';

  @override
  String get no => 'No';

  @override
  String get yes => 'Yes';

  @override
  String get okay => 'Okay';

  @override
  String get submit => 'Submit';

  @override
  String get delete => 'Delete';

  @override
  String get languagePickerTitle => 'Select language';

  @override
  String get vocabularyDeleteTitle => 'Delete?';

  @override
  String get vocabularyDeleteMessage => 'Do you really want to delete this vocabulary?';

  @override
  String get vocabularyCreatedLabel => 'Created:';

  @override
  String get vocabularyReappearsLabel => 'Reappears:';

  @override
  String get vocabularyReappearsNow => 'Now';

  @override
  String get vocabularyReappearsLessThanMinute => 'In less than a minute';

  @override
  String get notificationPracticeChannelName => 'Practice vocabulary';

  @override
  String get notificationPracticeChannelDescription => 'Let’s practice 🎯';

  @override
  String get notificationPracticeTitle => 'Let’s practice 🎯';

  @override
  String get notificationPracticeBody => 'Some vocabulary may be due. You’ll rock this! :D';

  @override
  String get welcomeSourceLanguageTitle => 'I speak';

  @override
  String get welcomeTargetLanguageTitle => 'I want to learn';

  @override
  String get welcomeStartButton => 'Let’s start!';

  @override
  String get welcomeGoogleSignInButton => 'Sign in with Google';

  @override
  String get welcomeContinueWithoutAccountButton => 'Continue without account';

  @override
  String get welcomeSignInFailedTitle => 'Sign in failed';

  @override
  String get homeCollectionsTitle => 'Collections';

  @override
  String get homeAddFirstWordMessage => 'Click the button\nto add your first word';

  @override
  String get homeAllWordsTitle => 'All vocabulary';

  @override
  String get homeNewWordsTitle => 'Recently added';

  @override
  String get homeNoNewWordsMessage =>
      'Oh, it seems like you have not added any words for a while now. :(';

  @override
  String get homeStatusFirstWordMessage =>
      'You added your first word! Add some more and hit “practice”! :)';

  @override
  String get homeStatusEmptyMessage => 'Why don’t you add some new words? :)';

  @override
  String get homePracticeButton => 'Practice';

  @override
  String get homeScanButton => 'Scan';

  @override
  String get homeWriteButton => 'Write';

  @override
  String get homeWriteHint => 'Type in word...';

  @override
  String get detailsSourceLabel => 'Source';

  @override
  String get detailsTargetLabel => 'Target';

  @override
  String get detailsReportTranslationButton => 'Report faulty translation';

  @override
  String get detailsAddCollectionButton => 'Add collection';

  @override
  String get detailsReplaceTitle => 'Replace';

  @override
  String get detailsReplaceMessage => 'Retranslate and replace the vocabulary?';

  @override
  String get detailsDuplicateTitle => 'Duplicate!';

  @override
  String get detailsDuplicateAddButton => 'Add';

  @override
  String get detailsNoImageMessage => 'Choose an image\nor save without one';

  @override
  String get detailsOpenGalleryButton => 'Open Gallery';

  @override
  String get detailsRemoveImageButton => 'Remove image';

  @override
  String get detailsPexelsAttribution => 'Images provided by Pexels.';

  @override
  String get detailsSaveButton => 'Save';

  @override
  String get detailsSaveWithoutImageButton => 'Save without';

  @override
  String get detailsTakePictureButton => 'Take picture';

  @override
  String get detailsCollectionNameHint => 'Untitled';

  @override
  String get detailsCollectionNameLabel => 'Tag name';

  @override
  String get practiceDoneTitle => 'Congratulations!';

  @override
  String get practiceDoneMessage => 'You’ve practiced all\nof your due words.';

  @override
  String get practiceDoneButton => 'Done';

  @override
  String get practiceForgotButton => 'I didn’t know';

  @override
  String get practiceEasyButton => 'Easy';

  @override
  String get practiceGoodButton => 'Good';

  @override
  String get practiceHardButton => 'Hard';

  @override
  String get practiceSolutionButton => 'Solution';

  @override
  String get practiceAnswerLabel => 'Your answer';

  @override
  String get scanAddButton => 'Add';

  @override
  String get scanSuggestionsTitle => 'Suggestions';

  @override
  String get scanNoSuggestionsMessage => 'No objects could be recognized. Please try again later.';

  @override
  String get reportBugTitle => 'Report bug';

  @override
  String get reportTranslationTitle => 'Faulty translation';

  @override
  String get reportTranslationNoteHint => 'Note (optional)';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSignInHint => 'Sign in to sync your data across devices.';

  @override
  String get settingsSignInButton => 'Sign in';

  @override
  String get settingsTypeAnswerDisabledTitle => 'Disable Type Answer mode';

  @override
  String get settingsTypeAnswerDisabledHint => 'Only use Memory Recall with self-assessment';

  @override
  String get settingsCollectionsTitle => 'Enable collections';

  @override
  String get settingsCollectionsHint => 'Categorise words in collections';

  @override
  String get settingsImagesHiddenTitle => 'Hide images';

  @override
  String get settingsImagesHiddenHint => 'Could decrease learning quality';

  @override
  String get settingsSourceLanguageTitle => 'Source language';

  @override
  String get settingsSourceLanguageHint => 'A language you know well';

  @override
  String get settingsTargetLanguageTitle => 'Target language';

  @override
  String get settingsTargetLanguageHint => 'The language you learn';

  @override
  String get settingsNotificationsTitle => 'Toggle notifications';

  @override
  String get settingsNotificationsHint => 'Open app system settings to manage';

  @override
  String vocabularyReappearsInMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'In $count minutes',
      one: 'In $count minute',
    );
    return '$_temp0';
  }

  @override
  String vocabularyReappearsInHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'In $count hours',
      one: 'In $count hour',
    );
    return '$_temp0';
  }

  @override
  String vocabularyReappearsInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'In $count days',
      one: 'In $count day',
    );
    return '$_temp0';
  }

  @override
  String homeStatusTotalMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Your collection contains $count words.',
      one: 'Your collection contains only $count word. It’s feeling lonely. Add some more! :)',
    );
    return '$_temp0';
  }

  @override
  String homeStatusAddedTodayMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wow, you already added $count words today. Keep it up!',
      one: 'Wow, you already added $count word today. Keep it up!',
    );
    return '$_temp0';
  }

  @override
  String homeStatusManyInTotalMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Damn, you added $count words in total. Not bad!',
    );
    return '$_temp0';
  }

  @override
  String detailsDuplicateMessage(String word) {
    return 'It seems that “$word” already exists in your collection.\n\nAdd it anyway?';
  }

  @override
  String detailsPhotoByLabel(String author) {
    return 'Photo by $author';
  }

  @override
  String get detailsReplaceButton => 'Replace';

  @override
  String get reportBugDescriptionHint => 'Describe the bug...';

  @override
  String get settingsAccountTitle => 'Account';

  @override
  String get errorSyncPending => 'Your latest changes haven\'t been uploaded yet.';

  @override
  String get settingsSignOutButton => 'Sign out';

  @override
  String get settingsSignOutBlockedTitle => 'Changes not uploaded';

  @override
  String get settingsSignOutBlockedMessage =>
      'Some changes haven\'t reached the server yet. Connect to the internet and try again. If you sign out anyway, these changes are lost.';

  @override
  String get settingsSignOutAnywayButton => 'Sign out anyway';

  @override
  String get syncStatusConnecting => 'Connecting…';

  @override
  String get syncStatusSynced => 'All changes synced';

  @override
  String get syncStatusOffline => 'Offline. Changes sync once you\'re back online.';

  @override
  String get syncStatusUpdateRequired => 'Update the app to keep syncing.';

  @override
  String get syncStatusSignInRequired => 'Your session expired. Sign in again to keep syncing.';

  @override
  String get gateUpdateTitle => 'Update required';

  @override
  String get gateUpdateMessage =>
      'This version of Vocabualize is no longer supported. Please update the app to keep learning.';

  @override
  String get gateUpdateButton => 'Update';

  @override
  String get gateMaintenanceTitle => 'Under maintenance';

  @override
  String get gateMaintenanceMessage => 'Vocabualize is being updated. Please try again later.';

  @override
  String get settingsBackupTitle => 'Backup';

  @override
  String get settingsExportBackupButton => 'Export backup';

  @override
  String get settingsExportBackupHint => 'Save all words and images as a file';

  @override
  String get settingsImportBackupButton => 'Import backup';

  @override
  String get settingsImportBackupHint => 'Add the words from a backup file';

  @override
  String get settingsImportBackupConfirmTitle => 'Import backup?';

  @override
  String get settingsImportBackupConfirmMessage =>
      'All words, collections and images from the backup are added to your collection. Your current words stay as they are.';

  @override
  String get settingsImportBackupConfirmButton => 'Import';

  @override
  String settingsImportBackupDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Imported $count words.',
      one: 'Imported $count word.',
    );
    return '$_temp0';
  }

  @override
  String get errorInvalidBackup => 'This file isn\'t a Vocabualize backup.';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageGerman => 'German';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get languageFrench => 'French';

  @override
  String get languagePolish => 'Polish';

  @override
  String languagePairLabel(String source, String target) {
    return '$source → $target';
  }

  @override
  String get languageSelectionTitle => 'Your languages';

  @override
  String get languageSelectionContinueButton => 'Continue';

  @override
  String get settingsLanguagesTitle => 'Languages';

  @override
  String get languageSelectionSaveButton => 'Save';

  @override
  String get dataOfflineTitle => 'You\'re offline';

  @override
  String get dataOfflineMessage => 'Your words will download as soon as you\'re connected.';

  @override
  String get dataRetryButton => 'Try again';

  @override
  String get dataSignInRequiredTitle => 'Sign in again';

  @override
  String get dataSignInRequiredMessage => 'Your session has expired. Sign in to load your words.';

  @override
  String get dataSignInButton => 'Sign in';

  @override
  String get syncStatusServerUnreachable =>
      'The server can\'t be reached. Changes sync as soon as it\'s back.';

  @override
  String get syncStatusClockWrong =>
      'Your phone\'s clock is off. Turn on automatic time to keep syncing.';

  @override
  String get syncStatusFailed => 'Syncing failed. Your words are safe on this phone.';

  @override
  String get dataServerUnreachableTitle => 'Server not reachable';

  @override
  String get dataServerUnreachableMessage =>
      'Vocabualize\'s server can\'t be reached right now. Your words are safe on this phone.';

  @override
  String get gateClockWrongTitle => 'Your phone\'s clock is off';

  @override
  String get gateClockWrongMessage =>
      'Syncing needs the correct time. Turn on automatic date and time, then come back.';

  @override
  String get gateOpenTimeSettingsButton => 'Open time settings';

  @override
  String get dataSyncFailedTitle => 'Syncing failed';

  @override
  String get dataSyncFailedMessage =>
      'Something went wrong while syncing. Your words are safe on this phone.';

  @override
  String get accountConflictTitle => 'Switch account?';

  @override
  String accountConflictMessage(String previous, String next) {
    return 'You were signed in on this phone as $previous. Changes that weren\'t uploaded yet belong to that account. They are lost if you switch to $next.';
  }

  @override
  String accountConflictKeepButton(String previous) {
    return 'Use $previous instead';
  }

  @override
  String accountConflictSwitchButton(String previous, String next) {
    return 'Delete data of $previous and use $next';
  }

  @override
  String get accountConflictUnknownAccount => 'an unknown account';

  @override
  String get settingsSignInAgainButton => 'Sign in again';

  @override
  String loadingProgressLabel(int current, int total) {
    return '$current / $total';
  }

  @override
  String get errorClockWrong =>
      'Your phone\'s clock is off. Turn on automatic date and time, then try again.';
}
