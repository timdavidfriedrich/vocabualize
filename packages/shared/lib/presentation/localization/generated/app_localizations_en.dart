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
  String get errorConnection =>
      'Couldn\'t reach the server. Check your internet connection and try again.';

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
  String get settingsNotificationsTitle => 'Notifications';

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

  @override
  String homeDueMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count words to practice',
      one: '$count word to practice',
    );
    return '$_temp0';
  }

  @override
  String get homeAllDoneMessage => 'All done for now';

  @override
  String homeTotalWordsMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count words in total',
      one: '$count word in total',
    );
    return '$_temp0';
  }

  @override
  String homeNextDueTodayMessage(String time) {
    return 'Next word at $time';
  }

  @override
  String homeNextDueLaterMessage(String date) {
    return 'Next word on $date';
  }

  @override
  String get vocabularySpeakTooltip => 'Read out';

  @override
  String get errorTextToSpeechUnavailable =>
      'No voice for this language is installed on this phone.';

  @override
  String get detailsRetakeImageButton => 'Retake image';

  @override
  String errorTranslationQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'You\'ve used your $limit translations for the last 24 hours. Type the translation yourself or try again later.',
      one:
          'You\'ve used your $limit translation for the last 24 hours. Type the translation yourself or try again later.',
    );
    return '$_temp0';
  }

  @override
  String errorStockImageQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'You\'ve used your $limit photo searches for the last 24 hours. Take your own photo or try again later.',
      one:
          'You\'ve used your $limit photo search for the last 24 hours. Take your own photo or try again later.',
    );
    return '$_temp0';
  }

  @override
  String get errorServiceUnavailable => 'Automatic suggestions aren\'t available right now.';

  @override
  String get collectionsDeleteButton => 'Delete collection';

  @override
  String get collectionsDeleteTitle => 'Delete collection?';

  @override
  String get collectionsDeleteMessage => 'The words stay. Only the collection is deleted.';

  @override
  String get scanTypeHint => 'Type in word...';

  @override
  String get scanOpenSettingsButton => 'Open settings';

  @override
  String get errorCameraPermission => 'Allow camera access to take photos.';

  @override
  String get errorCameraUnavailable => 'The camera can\'t be used right now.';

  @override
  String errorImageLabelingQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'You\'ve used your $limit scans for the last 24 hours. Type the word yourself or try again later.',
      one:
          'You\'ve used your $limit scan for the last 24 hours. Type the word yourself or try again later.',
    );
    return '$_temp0';
  }

  @override
  String errorImageLabelingMonthlyQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'You\'ve used your $limit scans for this month. Type the word yourself or try again next month.',
      one:
          'You\'ve used your $limit scan for this month. Type the word yourself or try again next month.',
    );
    return '$_temp0';
  }

  @override
  String errorQuotaSignInForMore(String message) {
    return '$message Sign in with Google for more.';
  }

  @override
  String get connectToInternet => 'Connect to internet';

  @override
  String get scanOfflineMessage =>
      'Suggestions need an internet connection. You can also type the word yourself.';

  @override
  String get detailsOfflineMessage => 'Translation and photo search need an internet connection.';

  @override
  String get welcomeOfflineMessage => 'Signing in with Google needs an internet connection.';

  @override
  String get settingsSignInOfflineMessage => 'Signing in needs an internet connection.';

  @override
  String get settingsSignOutOfflineMessage =>
      'Signing out needs an internet connection, so your latest changes can be uploaded first.';

  @override
  String get settingsLearningTitle => 'Learning';

  @override
  String get settingsPracticeReminderTitle => 'Practice reminder';

  @override
  String get settingsPracticeReminderHint => 'Only on days with words to practice';

  @override
  String get settingsReminderTimeTitle => 'Time';

  @override
  String get settingsNotificationsBlockedMessage => 'Notifications are turned off for Vocabualize.';

  @override
  String get settingsOpenNotificationSettingsButton => 'Open settings';

  @override
  String get reminderPracticeTitle => 'Time to practice';

  @override
  String get reminderPracticeBody => 'Your words are ready. A few minutes keep them fresh.';

  @override
  String get reminderPracticeChannel => 'Practice reminders';

  @override
  String get errorReportLimit => 'You\'ve sent several reports recently. Please try again later.';

  @override
  String get errorReportUnavailable => 'Reports can\'t be sent right now. Please try again later.';

  @override
  String get reportFeedbackTitle => 'Feedback & bugs';

  @override
  String get reportFeedbackMessage => 'Tell us what you like, what\'s missing or what went wrong.';

  @override
  String get reportFeedbackFieldHint => 'Your message...';

  @override
  String get reportFeedbackContextHint =>
      'Sent along: app version, Android version, app language and your language pair.';

  @override
  String get reportSendButton => 'Send';

  @override
  String get reportFeedbackSentMessage => 'Thank you! Your message was sent.';

  @override
  String get reportTranslationSentMessage => 'Thank you! The translation was reported.';

  @override
  String get reportOfflineMessage => 'Sending needs an internet connection.';

  @override
  String get settingsFeedbackButton => 'Feedback & bugs';

  @override
  String get settingsFeedbackHint => 'Ideas, problems or questions';

  @override
  String get settingsDeleteAccountButton => 'Delete account';

  @override
  String get settingsDeleteDataButton => 'Delete all data';

  @override
  String get settingsDeleteAccountTitle => 'Delete account?';

  @override
  String get settingsDeleteAccountMessage =>
      'This permanently deletes your account and everything in it on all your devices: words, photos, collections and progress. This can\'t be undone.';

  @override
  String get settingsDeleteDataTitle => 'Delete all data?';

  @override
  String get settingsDeleteDataMessage =>
      'This permanently deletes all words, photos, collections and progress on this phone. This can\'t be undone.';

  @override
  String get settingsDeleteConfirmWord => 'DELETE';

  @override
  String settingsDeleteConfirmHint(String word) {
    return 'Type $word to confirm';
  }

  @override
  String get settingsDeleteConfirmButton => 'Delete';

  @override
  String get settingsDeleteAccountOfflineMessage =>
      'Deleting your account needs an internet connection.';

  @override
  String streakTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count-day streak',
      one: '$count-day streak',
      zero: 'No streak yet',
    );
    return '$_temp0';
  }

  @override
  String get streakStartMessage => 'Practice or add a word to start a streak.';

  @override
  String get streakDoneMessage => 'You\'re done for today. See you tomorrow!';

  @override
  String get streakPendingMessage => 'Practice or add a word today to keep your streak.';

  @override
  String get streakLongestLabel => 'Longest streak';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '$count day',
    );
    return '$_temp0';
  }

  @override
  String get streakFreezesLabel => 'Freezes';

  @override
  String streakFreezesValue(int count, int max) {
    return '$count of $max';
  }

  @override
  String streakFreezeExplanation(int days, int max) {
    return 'Every $days active days in a row earn a freeze (max. $max). A freeze saves your streak on a day you miss.';
  }

  @override
  String get streakDayActive => 'Active';

  @override
  String get streakDayFrozen => 'Saved by a freeze';

  @override
  String get streakDayPending => 'Still open';

  @override
  String get streakDayMissed => 'Missed';

  @override
  String get settingsStreakReminderTitle => 'Streak reminder';

  @override
  String get settingsStreakReminderHint => 'Only on days your streak is at risk';

  @override
  String get reminderStreakChannel => 'Streak reminders';

  @override
  String get reminderStreakKeepTitle => 'Keep your streak';

  @override
  String reminderStreakKeepBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Practice a few words today to keep your $count-day streak.',
      one: 'Practice a few words today to keep your $count-day streak.',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakLookAroundTitle => 'Look around';

  @override
  String get reminderStreakLookAroundBody =>
      'See something you can\'t name yet? Add it as a new word.';

  @override
  String get reminderStreakQuickRoundTitle => 'Quick round?';

  @override
  String reminderStreakQuickRoundBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'One short practice round keeps your $count days going.',
      one: 'One short practice round keeps your streak going.',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakNearbyTitle => 'A new word nearby?';

  @override
  String get reminderStreakNearbyBody => 'Pick one thing around you and learn what it\'s called.';

  @override
  String reminderStreakInARowTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days in a row',
      one: '$count day in a row',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakInARowBody => 'Don\'t stop now. Add or practice a word today.';

  @override
  String get settingsPrivacyPolicyButton => 'Privacy policy';

  @override
  String get scanReportSuggestionButton => 'Report a suggestion';
}
