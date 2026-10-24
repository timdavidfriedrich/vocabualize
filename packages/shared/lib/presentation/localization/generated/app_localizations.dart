import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('uk'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Vocabualize'**
  String get appTitle;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection.'**
  String get errorConnection;

  /// No description provided for @errorApi.
  ///
  /// In en, this message translates to:
  /// **'Error while communicating with the server: {message}.'**
  String errorApi(String message);

  /// No description provided for @errorAuth.
  ///
  /// In en, this message translates to:
  /// **'You are not signed in.'**
  String get errorAuth;

  /// No description provided for @errorValidation.
  ///
  /// In en, this message translates to:
  /// **'The data received is invalid.'**
  String get errorValidation;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'Not found.'**
  String get errorNotFound;

  /// No description provided for @errorUnexpected.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get errorUnexpected;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'unknown'**
  String get unknown;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @okay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get okay;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @languagePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get languagePickerTitle;

  /// No description provided for @vocabularyDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete?'**
  String get vocabularyDeleteTitle;

  /// No description provided for @vocabularyDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete this vocabulary?'**
  String get vocabularyDeleteMessage;

  /// No description provided for @vocabularyCreatedLabel.
  ///
  /// In en, this message translates to:
  /// **'Created:'**
  String get vocabularyCreatedLabel;

  /// No description provided for @vocabularyReappearsLabel.
  ///
  /// In en, this message translates to:
  /// **'Reappears:'**
  String get vocabularyReappearsLabel;

  /// No description provided for @vocabularyReappearsNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get vocabularyReappearsNow;

  /// No description provided for @vocabularyReappearsLessThanMinute.
  ///
  /// In en, this message translates to:
  /// **'In less than a minute'**
  String get vocabularyReappearsLessThanMinute;

  /// No description provided for @notificationPracticeChannelName.
  ///
  /// In en, this message translates to:
  /// **'Practice vocabulary'**
  String get notificationPracticeChannelName;

  /// No description provided for @notificationPracticeChannelDescription.
  ///
  /// In en, this message translates to:
  /// **'Let’s practice 🎯'**
  String get notificationPracticeChannelDescription;

  /// No description provided for @notificationPracticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Let’s practice 🎯'**
  String get notificationPracticeTitle;

  /// No description provided for @notificationPracticeBody.
  ///
  /// In en, this message translates to:
  /// **'Some vocabulary may be due. You’ll rock this! :D'**
  String get notificationPracticeBody;

  /// No description provided for @welcomeSourceLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'I speak'**
  String get welcomeSourceLanguageTitle;

  /// No description provided for @welcomeTargetLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'I want to learn'**
  String get welcomeTargetLanguageTitle;

  /// No description provided for @welcomeStartButton.
  ///
  /// In en, this message translates to:
  /// **'Let’s start!'**
  String get welcomeStartButton;

  /// No description provided for @welcomeGoogleSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get welcomeGoogleSignInButton;

  /// No description provided for @welcomeContinueWithoutAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Continue without account'**
  String get welcomeContinueWithoutAccountButton;

  /// No description provided for @welcomeSignInFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in failed'**
  String get welcomeSignInFailedTitle;

  /// No description provided for @homeCollectionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get homeCollectionsTitle;

  /// No description provided for @homeAddFirstWordMessage.
  ///
  /// In en, this message translates to:
  /// **'Click the button\nto add your first word'**
  String get homeAddFirstWordMessage;

  /// No description provided for @homeAllWordsTitle.
  ///
  /// In en, this message translates to:
  /// **'All vocabulary'**
  String get homeAllWordsTitle;

  /// No description provided for @homeNewWordsTitle.
  ///
  /// In en, this message translates to:
  /// **'Recently added'**
  String get homeNewWordsTitle;

  /// No description provided for @homeNoNewWordsMessage.
  ///
  /// In en, this message translates to:
  /// **'Oh, it seems like you have not added any words for a while now. :('**
  String get homeNoNewWordsMessage;

  /// No description provided for @homeStatusFirstWordMessage.
  ///
  /// In en, this message translates to:
  /// **'You added your first word! Add some more and hit “practice”! :)'**
  String get homeStatusFirstWordMessage;

  /// No description provided for @homeStatusEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Why don’t you add some new words? :)'**
  String get homeStatusEmptyMessage;

  /// No description provided for @homePracticeButton.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get homePracticeButton;

  /// No description provided for @homeScanButton.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get homeScanButton;

  /// No description provided for @homeWriteButton.
  ///
  /// In en, this message translates to:
  /// **'Write'**
  String get homeWriteButton;

  /// No description provided for @homeWriteHint.
  ///
  /// In en, this message translates to:
  /// **'Type in word...'**
  String get homeWriteHint;

  /// No description provided for @detailsSourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get detailsSourceLabel;

  /// No description provided for @detailsTargetLabel.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get detailsTargetLabel;

  /// No description provided for @detailsReportTranslationButton.
  ///
  /// In en, this message translates to:
  /// **'Report faulty translation'**
  String get detailsReportTranslationButton;

  /// No description provided for @detailsAddCollectionButton.
  ///
  /// In en, this message translates to:
  /// **'Add collection'**
  String get detailsAddCollectionButton;

  /// No description provided for @detailsReplaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get detailsReplaceTitle;

  /// No description provided for @detailsReplaceMessage.
  ///
  /// In en, this message translates to:
  /// **'Retranslate and replace the vocabulary?'**
  String get detailsReplaceMessage;

  /// No description provided for @detailsDuplicateTitle.
  ///
  /// In en, this message translates to:
  /// **'Duplicate!'**
  String get detailsDuplicateTitle;

  /// No description provided for @detailsDuplicateAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get detailsDuplicateAddButton;

  /// No description provided for @detailsNoImageMessage.
  ///
  /// In en, this message translates to:
  /// **'Choose an image\nor save without one'**
  String get detailsNoImageMessage;

  /// No description provided for @detailsOpenGalleryButton.
  ///
  /// In en, this message translates to:
  /// **'Open Gallery'**
  String get detailsOpenGalleryButton;

  /// No description provided for @detailsRemoveImageButton.
  ///
  /// In en, this message translates to:
  /// **'Remove image'**
  String get detailsRemoveImageButton;

  /// No description provided for @detailsPexelsAttribution.
  ///
  /// In en, this message translates to:
  /// **'Images provided by Pexels.'**
  String get detailsPexelsAttribution;

  /// No description provided for @detailsSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get detailsSaveButton;

  /// No description provided for @detailsSaveWithoutImageButton.
  ///
  /// In en, this message translates to:
  /// **'Save without'**
  String get detailsSaveWithoutImageButton;

  /// No description provided for @detailsTakePictureButton.
  ///
  /// In en, this message translates to:
  /// **'Take picture'**
  String get detailsTakePictureButton;

  /// No description provided for @detailsCollectionNameHint.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get detailsCollectionNameHint;

  /// No description provided for @detailsCollectionNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Tag name'**
  String get detailsCollectionNameLabel;

  /// No description provided for @practiceDoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get practiceDoneTitle;

  /// No description provided for @practiceDoneMessage.
  ///
  /// In en, this message translates to:
  /// **'You’ve practiced all\nof your due words.'**
  String get practiceDoneMessage;

  /// No description provided for @practiceDoneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get practiceDoneButton;

  /// No description provided for @practiceForgotButton.
  ///
  /// In en, this message translates to:
  /// **'I didn’t know'**
  String get practiceForgotButton;

  /// No description provided for @practiceEasyButton.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get practiceEasyButton;

  /// No description provided for @practiceGoodButton.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get practiceGoodButton;

  /// No description provided for @practiceHardButton.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get practiceHardButton;

  /// No description provided for @practiceSolutionButton.
  ///
  /// In en, this message translates to:
  /// **'Solution'**
  String get practiceSolutionButton;

  /// No description provided for @practiceAnswerLabel.
  ///
  /// In en, this message translates to:
  /// **'Your answer'**
  String get practiceAnswerLabel;

  /// No description provided for @scanAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get scanAddButton;

  /// No description provided for @scanSuggestionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get scanSuggestionsTitle;

  /// No description provided for @scanNoSuggestionsMessage.
  ///
  /// In en, this message translates to:
  /// **'No objects could be recognized. Please try again later.'**
  String get scanNoSuggestionsMessage;

  /// No description provided for @reportBugTitle.
  ///
  /// In en, this message translates to:
  /// **'Report bug'**
  String get reportBugTitle;

  /// No description provided for @reportTranslationTitle.
  ///
  /// In en, this message translates to:
  /// **'Faulty translation'**
  String get reportTranslationTitle;

  /// No description provided for @reportTranslationNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get reportTranslationNoteHint;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSignInHint.
  ///
  /// In en, this message translates to:
  /// **'Sign in to sync your data across devices.'**
  String get settingsSignInHint;

  /// No description provided for @settingsSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get settingsSignInButton;

  /// No description provided for @settingsTypeAnswerDisabledTitle.
  ///
  /// In en, this message translates to:
  /// **'Disable Type Answer mode'**
  String get settingsTypeAnswerDisabledTitle;

  /// No description provided for @settingsTypeAnswerDisabledHint.
  ///
  /// In en, this message translates to:
  /// **'Only use Memory Recall with self-assessment'**
  String get settingsTypeAnswerDisabledHint;

  /// No description provided for @settingsCollectionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable collections'**
  String get settingsCollectionsTitle;

  /// No description provided for @settingsCollectionsHint.
  ///
  /// In en, this message translates to:
  /// **'Categorise words in collections'**
  String get settingsCollectionsHint;

  /// No description provided for @settingsImagesHiddenTitle.
  ///
  /// In en, this message translates to:
  /// **'Hide images'**
  String get settingsImagesHiddenTitle;

  /// No description provided for @settingsImagesHiddenHint.
  ///
  /// In en, this message translates to:
  /// **'Could decrease learning quality'**
  String get settingsImagesHiddenHint;

  /// No description provided for @settingsSourceLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Source language'**
  String get settingsSourceLanguageTitle;

  /// No description provided for @settingsSourceLanguageHint.
  ///
  /// In en, this message translates to:
  /// **'A language you know well'**
  String get settingsSourceLanguageHint;

  /// No description provided for @settingsTargetLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Target language'**
  String get settingsTargetLanguageTitle;

  /// No description provided for @settingsTargetLanguageHint.
  ///
  /// In en, this message translates to:
  /// **'The language you learn'**
  String get settingsTargetLanguageHint;

  /// No description provided for @settingsNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Toggle notifications'**
  String get settingsNotificationsTitle;

  /// No description provided for @settingsNotificationsHint.
  ///
  /// In en, this message translates to:
  /// **'Open app system settings to manage'**
  String get settingsNotificationsHint;

  /// No description provided for @vocabularyReappearsInMinutes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{In {count} minute} other{In {count} minutes}}'**
  String vocabularyReappearsInMinutes(int count);

  /// No description provided for @vocabularyReappearsInHours.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{In {count} hour} other{In {count} hours}}'**
  String vocabularyReappearsInHours(int count);

  /// No description provided for @vocabularyReappearsInDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{In {count} day} other{In {count} days}}'**
  String vocabularyReappearsInDays(int count);

  /// No description provided for @homeStatusTotalMessage.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{Your collection contains only {count} word. It’s feeling lonely. Add some more! :)} other{Your collection contains {count} words.}}'**
  String homeStatusTotalMessage(int count);

  /// No description provided for @homeStatusAddedTodayMessage.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{Wow, you already added {count} word today. Keep it up!} other{Wow, you already added {count} words today. Keep it up!}}'**
  String homeStatusAddedTodayMessage(int count);

  /// No description provided for @homeStatusManyInTotalMessage.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{Damn, you added {count} words in total. Not bad!}}'**
  String homeStatusManyInTotalMessage(int count);

  /// No description provided for @detailsDuplicateMessage.
  ///
  /// In en, this message translates to:
  /// **'It seems that “{word}” already exists in your collection.\n\nAdd it anyway?'**
  String detailsDuplicateMessage(String word);

  /// No description provided for @detailsPhotoByLabel.
  ///
  /// In en, this message translates to:
  /// **'Photo by {author}'**
  String detailsPhotoByLabel(String author);

  /// No description provided for @detailsReplaceButton.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get detailsReplaceButton;

  /// No description provided for @reportBugDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the bug...'**
  String get reportBugDescriptionHint;

  /// No description provided for @settingsAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccountTitle;

  /// No description provided for @errorSyncPending.
  ///
  /// In en, this message translates to:
  /// **'Your latest changes haven\'t been uploaded yet.'**
  String get errorSyncPending;

  /// No description provided for @settingsSignOutButton.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get settingsSignOutButton;

  /// No description provided for @settingsSignOutBlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Changes not uploaded'**
  String get settingsSignOutBlockedTitle;

  /// No description provided for @settingsSignOutBlockedMessage.
  ///
  /// In en, this message translates to:
  /// **'Some changes haven\'t reached the server yet. Connect to the internet and try again. If you sign out anyway, these changes are lost.'**
  String get settingsSignOutBlockedMessage;

  /// No description provided for @settingsSignOutAnywayButton.
  ///
  /// In en, this message translates to:
  /// **'Sign out anyway'**
  String get settingsSignOutAnywayButton;

  /// No description provided for @syncStatusConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting…'**
  String get syncStatusConnecting;

  /// No description provided for @syncStatusSynced.
  ///
  /// In en, this message translates to:
  /// **'All changes synced'**
  String get syncStatusSynced;

  /// No description provided for @syncStatusOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline. Changes sync once you\'re back online.'**
  String get syncStatusOffline;

  /// No description provided for @syncStatusUpdateRequired.
  ///
  /// In en, this message translates to:
  /// **'Update the app to keep syncing.'**
  String get syncStatusUpdateRequired;

  /// No description provided for @syncStatusSignInRequired.
  ///
  /// In en, this message translates to:
  /// **'Your session expired. Sign in again to keep syncing.'**
  String get syncStatusSignInRequired;

  /// No description provided for @gateUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Update required'**
  String get gateUpdateTitle;

  /// No description provided for @gateUpdateMessage.
  ///
  /// In en, this message translates to:
  /// **'This version of Vocabualize is no longer supported. Please update the app to keep learning.'**
  String get gateUpdateMessage;

  /// No description provided for @gateUpdateButton.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get gateUpdateButton;

  /// No description provided for @gateMaintenanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Under maintenance'**
  String get gateMaintenanceTitle;

  /// No description provided for @gateMaintenanceMessage.
  ///
  /// In en, this message translates to:
  /// **'Vocabualize is being updated. Please try again later.'**
  String get gateMaintenanceMessage;

  /// No description provided for @settingsBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get settingsBackupTitle;

  /// No description provided for @settingsExportBackupButton.
  ///
  /// In en, this message translates to:
  /// **'Export backup'**
  String get settingsExportBackupButton;

  /// No description provided for @settingsExportBackupHint.
  ///
  /// In en, this message translates to:
  /// **'Save all words and images as a file'**
  String get settingsExportBackupHint;

  /// No description provided for @settingsImportBackupButton.
  ///
  /// In en, this message translates to:
  /// **'Import backup'**
  String get settingsImportBackupButton;

  /// No description provided for @settingsImportBackupHint.
  ///
  /// In en, this message translates to:
  /// **'Add the words from a backup file'**
  String get settingsImportBackupHint;

  /// No description provided for @settingsImportBackupConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Import backup?'**
  String get settingsImportBackupConfirmTitle;

  /// No description provided for @settingsImportBackupConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'All words, collections and images from the backup are added to your collection. Your current words stay as they are.'**
  String get settingsImportBackupConfirmMessage;

  /// No description provided for @settingsImportBackupConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get settingsImportBackupConfirmButton;

  /// No description provided for @settingsImportBackupDone.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{Imported {count} word.} other{Imported {count} words.}}'**
  String settingsImportBackupDone(int count);

  /// No description provided for @errorInvalidBackup.
  ///
  /// In en, this message translates to:
  /// **'This file isn\'t a Vocabualize backup.'**
  String get errorInvalidBackup;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fr', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
