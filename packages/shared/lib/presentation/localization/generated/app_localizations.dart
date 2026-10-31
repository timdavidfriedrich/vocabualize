import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ro.dart';
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
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ro'),
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
  /// **'Couldn\'t reach the server. Check your internet connection and try again.'**
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

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

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

  /// No description provided for @settingsStrictCorrectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Strict correction'**
  String get settingsStrictCorrectionTitle;

  /// No description provided for @settingsStrictCorrectionHint.
  ///
  /// In en, this message translates to:
  /// **'Accents and special characters must be typed exactly'**
  String get settingsStrictCorrectionHint;

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

  /// No description provided for @settingsDefaultGatherTitle.
  ///
  /// In en, this message translates to:
  /// **'Default way to add words'**
  String get settingsDefaultGatherTitle;

  /// No description provided for @settingsDefaultGatherHint.
  ///
  /// In en, this message translates to:
  /// **'The + button starts it right away, a long press shows all options'**
  String get settingsDefaultGatherHint;

  /// No description provided for @settingsDefaultGatherNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get settingsDefaultGatherNone;

  /// No description provided for @settingsAppearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearanceTitle;

  /// No description provided for @settingsAppearanceHint.
  ///
  /// In en, this message translates to:
  /// **'Light, dark or like your phone'**
  String get settingsAppearanceHint;

  /// No description provided for @settingsAppearanceSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsAppearanceSystem;

  /// No description provided for @settingsAppearanceLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsAppearanceLight;

  /// No description provided for @settingsAppearanceDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsAppearanceDark;

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

  /// No description provided for @detailsDuplicateMessage.
  ///
  /// In en, this message translates to:
  /// **'It seems that “{word}” already exists in your collection.\n\nAdd it anyway?'**
  String detailsDuplicateMessage(String word);

  /// No description provided for @vocabularyPhotoByLabel.
  ///
  /// In en, this message translates to:
  /// **'Photo by {author}'**
  String vocabularyPhotoByLabel(String author);

  /// No description provided for @detailsReplaceButton.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get detailsReplaceButton;

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

  /// No description provided for @syncStatusSyncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing…'**
  String get syncStatusSyncing;

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

  /// No description provided for @languageEnglishUk.
  ///
  /// In en, this message translates to:
  /// **'English (UK)'**
  String get languageEnglishUk;

  /// No description provided for @languageEnglishUs.
  ///
  /// In en, this message translates to:
  /// **'English (US)'**
  String get languageEnglishUs;

  /// No description provided for @languageSpanishSpain.
  ///
  /// In en, this message translates to:
  /// **'Spanish (Spain)'**
  String get languageSpanishSpain;

  /// No description provided for @languageSpanishLatinAmerica.
  ///
  /// In en, this message translates to:
  /// **'Spanish (Latin America)'**
  String get languageSpanishLatinAmerica;

  /// No description provided for @languageFrenchFrance.
  ///
  /// In en, this message translates to:
  /// **'French (France)'**
  String get languageFrenchFrance;

  /// No description provided for @languageFrenchCanada.
  ///
  /// In en, this message translates to:
  /// **'French (Canada)'**
  String get languageFrenchCanada;

  /// No description provided for @languageGermanGermany.
  ///
  /// In en, this message translates to:
  /// **'German (Germany)'**
  String get languageGermanGermany;

  /// No description provided for @languageGermanSwitzerland.
  ///
  /// In en, this message translates to:
  /// **'German (Switzerland)'**
  String get languageGermanSwitzerland;

  /// No description provided for @languagePolish.
  ///
  /// In en, this message translates to:
  /// **'Polish'**
  String get languagePolish;

  /// No description provided for @languageItalian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get languageItalian;

  /// No description provided for @languageGreek.
  ///
  /// In en, this message translates to:
  /// **'Greek'**
  String get languageGreek;

  /// No description provided for @languageRomanian.
  ///
  /// In en, this message translates to:
  /// **'Romanian'**
  String get languageRomanian;

  /// No description provided for @languagePairLabel.
  ///
  /// In en, this message translates to:
  /// **'{source} → {target}'**
  String languagePairLabel(String source, String target);

  /// No description provided for @dataOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline'**
  String get dataOfflineTitle;

  /// No description provided for @dataOfflineMessage.
  ///
  /// In en, this message translates to:
  /// **'Your words will download as soon as you\'re connected.'**
  String get dataOfflineMessage;

  /// No description provided for @dataRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get dataRetryButton;

  /// No description provided for @dataSignInRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in again'**
  String get dataSignInRequiredTitle;

  /// No description provided for @dataSignInRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Sign in to load your words.'**
  String get dataSignInRequiredMessage;

  /// No description provided for @dataSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get dataSignInButton;

  /// No description provided for @syncStatusServerUnreachable.
  ///
  /// In en, this message translates to:
  /// **'The server can\'t be reached. Changes sync as soon as it\'s back.'**
  String get syncStatusServerUnreachable;

  /// No description provided for @syncStatusClockWrong.
  ///
  /// In en, this message translates to:
  /// **'Your phone\'s clock is off. Turn on automatic time to keep syncing.'**
  String get syncStatusClockWrong;

  /// No description provided for @syncStatusFailed.
  ///
  /// In en, this message translates to:
  /// **'Syncing failed. Your words are safe on this phone.'**
  String get syncStatusFailed;

  /// No description provided for @dataServerUnreachableTitle.
  ///
  /// In en, this message translates to:
  /// **'Server not reachable'**
  String get dataServerUnreachableTitle;

  /// No description provided for @dataServerUnreachableMessage.
  ///
  /// In en, this message translates to:
  /// **'Vocabualize\'s server can\'t be reached right now. Your words are safe on this phone.'**
  String get dataServerUnreachableMessage;

  /// No description provided for @gateClockWrongTitle.
  ///
  /// In en, this message translates to:
  /// **'Your phone\'s clock is off'**
  String get gateClockWrongTitle;

  /// No description provided for @gateClockWrongMessage.
  ///
  /// In en, this message translates to:
  /// **'Syncing needs the correct time. Turn on automatic date and time, then come back.'**
  String get gateClockWrongMessage;

  /// No description provided for @gateOpenTimeSettingsButton.
  ///
  /// In en, this message translates to:
  /// **'Open time settings'**
  String get gateOpenTimeSettingsButton;

  /// No description provided for @dataSyncFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Syncing failed'**
  String get dataSyncFailedTitle;

  /// No description provided for @dataSyncFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while syncing. Your words are safe on this phone.'**
  String get dataSyncFailedMessage;

  /// No description provided for @accountConflictTitle.
  ///
  /// In en, this message translates to:
  /// **'Switch account?'**
  String get accountConflictTitle;

  /// No description provided for @accountConflictMessage.
  ///
  /// In en, this message translates to:
  /// **'You were signed in on this phone as {previous}. Changes that weren\'t uploaded yet belong to that account. They are lost if you switch to {next}.'**
  String accountConflictMessage(String previous, String next);

  /// No description provided for @accountConflictKeepButton.
  ///
  /// In en, this message translates to:
  /// **'Use {previous} instead'**
  String accountConflictKeepButton(String previous);

  /// No description provided for @accountConflictSwitchButton.
  ///
  /// In en, this message translates to:
  /// **'Delete data of {previous} and use {next}'**
  String accountConflictSwitchButton(String previous, String next);

  /// No description provided for @accountConflictUnknownAccount.
  ///
  /// In en, this message translates to:
  /// **'an unknown account'**
  String get accountConflictUnknownAccount;

  /// No description provided for @settingsSignInAgainButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in again'**
  String get settingsSignInAgainButton;

  /// No description provided for @loadingProgressLabel.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String loadingProgressLabel(int current, int total);

  /// No description provided for @errorClockWrong.
  ///
  /// In en, this message translates to:
  /// **'Your phone\'s clock is off. Turn on automatic date and time, then try again.'**
  String get errorClockWrong;

  /// No description provided for @homeAllDoneMessage.
  ///
  /// In en, this message translates to:
  /// **'All done for now'**
  String get homeAllDoneMessage;

  /// No description provided for @homeStatusFirstWordMessage.
  ///
  /// In en, this message translates to:
  /// **'You added your first word! Add some more and hit “Practice”! :)'**
  String get homeStatusFirstWordMessage;

  /// No description provided for @homeStatusEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Why don’t you add some new words? :)'**
  String get homeStatusEmptyMessage;

  /// No description provided for @homeStatusOnlyOneWordMessage.
  ///
  /// In en, this message translates to:
  /// **'Your collection contains only one word. It’s feeling lonely. Add some more! :)'**
  String get homeStatusOnlyOneWordMessage;

  /// No description provided for @homeStatusAddedTodayMessage.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{Wow, you already added {count} word today. Keep it up!} other{Wow, you already added {count} words today. Keep it up!}}'**
  String homeStatusAddedTodayMessage(int count);

  /// No description provided for @homeStatusManyWordsMessage.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{Damn, you added {count} word in total. Not bad!} other{Damn, you added {count} words in total. Not bad!}}'**
  String homeStatusManyWordsMessage(int count);

  /// No description provided for @homeStatusDefaultMessage.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{Your collection contains {count} word.} other{Your collection contains {count} words.}}'**
  String homeStatusDefaultMessage(int count);

  /// No description provided for @homeNextDueTodayMessage.
  ///
  /// In en, this message translates to:
  /// **'Next word at {time}'**
  String homeNextDueTodayMessage(String time);

  /// No description provided for @homeNextDueLaterMessage.
  ///
  /// In en, this message translates to:
  /// **'Next word on {date}'**
  String homeNextDueLaterMessage(String date);

  /// No description provided for @vocabularySpeakTooltip.
  ///
  /// In en, this message translates to:
  /// **'Read out'**
  String get vocabularySpeakTooltip;

  /// No description provided for @vocabularyTranslationPendingLabel.
  ///
  /// In en, this message translates to:
  /// **'Translation pending'**
  String get vocabularyTranslationPendingLabel;

  /// No description provided for @vocabularySearchTooltip.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get vocabularySearchTooltip;

  /// No description provided for @vocabularySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search vocabulary...'**
  String get vocabularySearchHint;

  /// No description provided for @vocabularySearchClearTooltip.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get vocabularySearchClearTooltip;

  /// No description provided for @vocabularySearchEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No vocabulary matches your search.'**
  String get vocabularySearchEmptyMessage;

  /// No description provided for @vocabularyFilterDueLabel.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get vocabularyFilterDueLabel;

  /// No description provided for @vocabularyLevelNovice.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get vocabularyLevelNovice;

  /// No description provided for @vocabularyLevelBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get vocabularyLevelBeginner;

  /// No description provided for @vocabularyLevelAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get vocabularyLevelAdvanced;

  /// No description provided for @vocabularyLevelExpert.
  ///
  /// In en, this message translates to:
  /// **'Expert'**
  String get vocabularyLevelExpert;

  /// No description provided for @errorTextToSpeechUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No voice for this language is installed on this phone.'**
  String get errorTextToSpeechUnavailable;

  /// No description provided for @detailsRetakeImageButton.
  ///
  /// In en, this message translates to:
  /// **'Retake image'**
  String get detailsRetakeImageButton;

  /// No description provided for @errorTranslationQuotaExceeded.
  ///
  /// In en, this message translates to:
  /// **'{limit, plural, one{You\'ve used your {limit} translation for the last 24 hours. Type the translation yourself or try again later.} other{You\'ve used your {limit} translations for the last 24 hours. Type the translation yourself or try again later.}}'**
  String errorTranslationQuotaExceeded(int limit);

  /// No description provided for @errorStockImageQuotaExceeded.
  ///
  /// In en, this message translates to:
  /// **'{limit, plural, one{You\'ve used your {limit} photo search for the last 24 hours. Take your own photo or try again later.} other{You\'ve used your {limit} photo searches for the last 24 hours. Take your own photo or try again later.}}'**
  String errorStockImageQuotaExceeded(int limit);

  /// No description provided for @errorServiceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Automatic suggestions aren\'t available right now.'**
  String get errorServiceUnavailable;

  /// No description provided for @collectionsDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete collection'**
  String get collectionsDeleteButton;

  /// No description provided for @collectionsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete collection?'**
  String get collectionsDeleteTitle;

  /// No description provided for @collectionsDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'The words stay. Only the collection is deleted.'**
  String get collectionsDeleteMessage;

  /// No description provided for @scanTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Type in word...'**
  String get scanTypeHint;

  /// No description provided for @scanOpenSettingsButton.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get scanOpenSettingsButton;

  /// No description provided for @errorCameraPermission.
  ///
  /// In en, this message translates to:
  /// **'Allow camera access to take photos.'**
  String get errorCameraPermission;

  /// No description provided for @errorCameraUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The camera can\'t be used right now.'**
  String get errorCameraUnavailable;

  /// No description provided for @errorImageLabelingQuotaExceeded.
  ///
  /// In en, this message translates to:
  /// **'{limit, plural, one{You\'ve used your {limit} scan for the last 24 hours. Type the word yourself or try again later.} other{You\'ve used your {limit} scans for the last 24 hours. Type the word yourself or try again later.}}'**
  String errorImageLabelingQuotaExceeded(int limit);

  /// No description provided for @errorImageLabelingMonthlyQuotaExceeded.
  ///
  /// In en, this message translates to:
  /// **'{limit, plural, one{You\'ve used your {limit} scan for this month. Type the word yourself or try again next month.} other{You\'ve used your {limit} scans for this month. Type the word yourself or try again next month.}}'**
  String errorImageLabelingMonthlyQuotaExceeded(int limit);

  /// No description provided for @errorQuotaSignInForMore.
  ///
  /// In en, this message translates to:
  /// **'{message} Sign in with Google for more.'**
  String errorQuotaSignInForMore(String message);

  /// No description provided for @connectToInternet.
  ///
  /// In en, this message translates to:
  /// **'Connect to internet'**
  String get connectToInternet;

  /// No description provided for @scanOfflineMessage.
  ///
  /// In en, this message translates to:
  /// **'Suggestions need an internet connection. You can also type the word yourself.'**
  String get scanOfflineMessage;

  /// No description provided for @detailsOfflineMessage.
  ///
  /// In en, this message translates to:
  /// **'Translation and photo search need an internet connection.'**
  String get detailsOfflineMessage;

  /// No description provided for @welcomeOfflineMessage.
  ///
  /// In en, this message translates to:
  /// **'Signing in with Google needs an internet connection.'**
  String get welcomeOfflineMessage;

  /// No description provided for @settingsSignInOfflineMessage.
  ///
  /// In en, this message translates to:
  /// **'Signing in needs an internet connection.'**
  String get settingsSignInOfflineMessage;

  /// No description provided for @settingsPracticeReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice reminder'**
  String get settingsPracticeReminderTitle;

  /// No description provided for @settingsPracticeReminderHint.
  ///
  /// In en, this message translates to:
  /// **'Only on days with words to practice'**
  String get settingsPracticeReminderHint;

  /// No description provided for @settingsReminderTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get settingsReminderTimeTitle;

  /// No description provided for @settingsNotificationsBlockedMessage.
  ///
  /// In en, this message translates to:
  /// **'Notifications are turned off for Vocabualize.'**
  String get settingsNotificationsBlockedMessage;

  /// No description provided for @settingsOpenNotificationSettingsButton.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get settingsOpenNotificationSettingsButton;

  /// No description provided for @reminderPracticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Time to practice'**
  String get reminderPracticeTitle;

  /// No description provided for @reminderPracticeBody.
  ///
  /// In en, this message translates to:
  /// **'Your words are ready. A few minutes keep them fresh.'**
  String get reminderPracticeBody;

  /// No description provided for @reminderPracticeChannel.
  ///
  /// In en, this message translates to:
  /// **'Practice reminders'**
  String get reminderPracticeChannel;

  /// No description provided for @errorReportLimit.
  ///
  /// In en, this message translates to:
  /// **'You\'ve sent several reports recently. Please try again later.'**
  String get errorReportLimit;

  /// No description provided for @errorReportUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Reports can\'t be sent right now. Please try again later.'**
  String get errorReportUnavailable;

  /// No description provided for @reportFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Feedback & bugs'**
  String get reportFeedbackTitle;

  /// No description provided for @reportFeedbackMessage.
  ///
  /// In en, this message translates to:
  /// **'Tell us what you like, what\'s missing or what went wrong.'**
  String get reportFeedbackMessage;

  /// No description provided for @reportFeedbackFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Your message...'**
  String get reportFeedbackFieldHint;

  /// No description provided for @reportFeedbackContextHint.
  ///
  /// In en, this message translates to:
  /// **'Sent along: app version, Android version, app language and your language pair.'**
  String get reportFeedbackContextHint;

  /// No description provided for @reportSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get reportSendButton;

  /// No description provided for @reportFeedbackSentMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you! Your message was sent.'**
  String get reportFeedbackSentMessage;

  /// No description provided for @reportTranslationSentMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you! The translation was reported.'**
  String get reportTranslationSentMessage;

  /// No description provided for @reportOfflineMessage.
  ///
  /// In en, this message translates to:
  /// **'Sending needs an internet connection.'**
  String get reportOfflineMessage;

  /// No description provided for @settingsDeleteAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get settingsDeleteAccountButton;

  /// No description provided for @settingsDeleteDataButton.
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get settingsDeleteDataButton;

  /// No description provided for @settingsDeleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account?'**
  String get settingsDeleteAccountTitle;

  /// No description provided for @settingsDeleteAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes your account and everything in it on all your devices: words, photos, collections and progress. This can\'t be undone.'**
  String get settingsDeleteAccountMessage;

  /// No description provided for @settingsDeleteDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all data?'**
  String get settingsDeleteDataTitle;

  /// No description provided for @settingsDeleteDataMessage.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes all words, photos, collections and progress on this phone. This can\'t be undone.'**
  String get settingsDeleteDataMessage;

  /// No description provided for @settingsDeleteConfirmWord.
  ///
  /// In en, this message translates to:
  /// **'DELETE'**
  String get settingsDeleteConfirmWord;

  /// No description provided for @settingsDeleteConfirmHint.
  ///
  /// In en, this message translates to:
  /// **'Type {word} to confirm'**
  String settingsDeleteConfirmHint(String word);

  /// No description provided for @settingsDeleteConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get settingsDeleteConfirmButton;

  /// No description provided for @settingsDeleteAccountOfflineMessage.
  ///
  /// In en, this message translates to:
  /// **'Deleting your account needs an internet connection.'**
  String get settingsDeleteAccountOfflineMessage;

  /// No description provided for @streakTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No streak yet} one{{count}-day streak} other{{count}-day streak}}'**
  String streakTitle(int count);

  /// No description provided for @streakStartMessage.
  ///
  /// In en, this message translates to:
  /// **'Practice or add a word to start a streak.'**
  String get streakStartMessage;

  /// No description provided for @streakDoneMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'re done for today. See you tomorrow!'**
  String get streakDoneMessage;

  /// No description provided for @streakPendingMessage.
  ///
  /// In en, this message translates to:
  /// **'Practice or add a word today to keep your streak.'**
  String get streakPendingMessage;

  /// No description provided for @streakLongestLabel.
  ///
  /// In en, this message translates to:
  /// **'Longest streak'**
  String get streakLongestLabel;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} day} other{{count} days}}'**
  String streakDays(int count);

  /// No description provided for @streakFreezesLabel.
  ///
  /// In en, this message translates to:
  /// **'Freezes'**
  String get streakFreezesLabel;

  /// No description provided for @streakFreezesValue.
  ///
  /// In en, this message translates to:
  /// **'{count} of {max}'**
  String streakFreezesValue(int count, int max);

  /// No description provided for @streakFreezeExplanation.
  ///
  /// In en, this message translates to:
  /// **'Every {days} active days in a row earn a freeze (max. {max}). A freeze saves your streak on a day you miss.'**
  String streakFreezeExplanation(int days, int max);

  /// No description provided for @streakDayActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get streakDayActive;

  /// No description provided for @streakDayFrozen.
  ///
  /// In en, this message translates to:
  /// **'Saved by a freeze'**
  String get streakDayFrozen;

  /// No description provided for @streakDayPending.
  ///
  /// In en, this message translates to:
  /// **'Still open'**
  String get streakDayPending;

  /// No description provided for @streakDayMissed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get streakDayMissed;

  /// No description provided for @settingsStreakReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Streak reminder'**
  String get settingsStreakReminderTitle;

  /// No description provided for @settingsStreakReminderHint.
  ///
  /// In en, this message translates to:
  /// **'Only on days your streak is at risk'**
  String get settingsStreakReminderHint;

  /// No description provided for @reminderStreakChannel.
  ///
  /// In en, this message translates to:
  /// **'Streak reminders'**
  String get reminderStreakChannel;

  /// No description provided for @reminderStreakKeepTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep your streak'**
  String get reminderStreakKeepTitle;

  /// No description provided for @reminderStreakKeepBody.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{Practice a few words today to keep your {count}-day streak.} other{Practice a few words today to keep your {count}-day streak.}}'**
  String reminderStreakKeepBody(int count);

  /// No description provided for @reminderStreakLookAroundTitle.
  ///
  /// In en, this message translates to:
  /// **'Look around'**
  String get reminderStreakLookAroundTitle;

  /// No description provided for @reminderStreakLookAroundBody.
  ///
  /// In en, this message translates to:
  /// **'See something you can\'t name yet? Add it as a new word.'**
  String get reminderStreakLookAroundBody;

  /// No description provided for @reminderStreakQuickRoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick round?'**
  String get reminderStreakQuickRoundTitle;

  /// No description provided for @reminderStreakQuickRoundBody.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{One short practice round keeps your streak going.} other{One short practice round keeps your {count} days going.}}'**
  String reminderStreakQuickRoundBody(int count);

  /// No description provided for @reminderStreakNearbyTitle.
  ///
  /// In en, this message translates to:
  /// **'A new word nearby?'**
  String get reminderStreakNearbyTitle;

  /// No description provided for @reminderStreakNearbyBody.
  ///
  /// In en, this message translates to:
  /// **'Pick one thing around you and learn what it\'s called.'**
  String get reminderStreakNearbyBody;

  /// No description provided for @reminderStreakInARowTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} day in a row} other{{count} days in a row}}'**
  String reminderStreakInARowTitle(int count);

  /// No description provided for @reminderStreakInARowBody.
  ///
  /// In en, this message translates to:
  /// **'Don\'t stop now. Add or practice a word today.'**
  String get reminderStreakInARowBody;

  /// No description provided for @settingsPrivacyPolicyButton.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacyPolicyButton;

  /// No description provided for @scanReportSuggestionButton.
  ///
  /// In en, this message translates to:
  /// **'Report a suggestion'**
  String get scanReportSuggestionButton;

  /// No description provided for @languagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Your languages'**
  String get languagesTitle;

  /// No description provided for @languagesSpeakTitle.
  ///
  /// In en, this message translates to:
  /// **'I speak'**
  String get languagesSpeakTitle;

  /// No description provided for @languagesSpeakHint.
  ///
  /// In en, this message translates to:
  /// **'A language you know well'**
  String get languagesSpeakHint;

  /// No description provided for @languagesLearnTitle.
  ///
  /// In en, this message translates to:
  /// **'I learn'**
  String get languagesLearnTitle;

  /// No description provided for @languagesLearnHint.
  ///
  /// In en, this message translates to:
  /// **'Choose one or more'**
  String get languagesLearnHint;

  /// No description provided for @languagesContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get languagesContinueButton;

  /// No description provided for @languagesPausedTitle.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get languagesPausedTitle;

  /// No description provided for @languagesChangeButton.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get languagesChangeButton;

  /// No description provided for @languagesAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add a language'**
  String get languagesAddButton;

  /// No description provided for @languagesWordCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 word} other{{count} words}}'**
  String languagesWordCount(int count);

  /// No description provided for @languagesPickTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a language'**
  String get languagesPickTitle;

  /// No description provided for @languagesMainClashTitle.
  ///
  /// In en, this message translates to:
  /// **'Speak {language}?'**
  String languagesMainClashTitle(String language);

  /// No description provided for @languagesMainClashMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'re learning {language}. If you speak it, it gets paused. Its progress stays.'**
  String languagesMainClashMessage(String language);

  /// No description provided for @languagesMainClashButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get languagesMainClashButton;

  /// No description provided for @learnedLanguageAskMeInLabel.
  ///
  /// In en, this message translates to:
  /// **'Ask me in'**
  String get learnedLanguageAskMeInLabel;

  /// No description provided for @learnedLanguageAddAskMeInButton.
  ///
  /// In en, this message translates to:
  /// **'Ask me in another language'**
  String get learnedLanguageAddAskMeInButton;

  /// No description provided for @learnedLanguageAskMeInHelpMessage.
  ///
  /// In en, this message translates to:
  /// **'Cards ask in {askMeIn} instead of {main}, for words you already know well in {askMeIn}. You can always show the {main} word. This keeps your {askMeIn} active while you learn {learned}.'**
  String learnedLanguageAskMeInHelpMessage(String askMeIn, String main, String learned);

  /// No description provided for @learnedLanguageAskMeInHelpTooltip.
  ///
  /// In en, this message translates to:
  /// **'What does this mean?'**
  String get learnedLanguageAskMeInHelpTooltip;

  /// No description provided for @learnedLanguageRemoveAskMeInTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get learnedLanguageRemoveAskMeInTooltip;

  /// No description provided for @learnedLanguageFromLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'From level: {level}'**
  String learnedLanguageFromLevelLabel(String level);

  /// No description provided for @learnedLanguageNewWordsTitle.
  ///
  /// In en, this message translates to:
  /// **'New words per practice'**
  String get learnedLanguageNewWordsTitle;

  /// No description provided for @learnedLanguageAllNewWords.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get learnedLanguageAllNewWords;

  /// No description provided for @learnedLanguageWordsTitle.
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get learnedLanguageWordsTitle;

  /// No description provided for @learnedLanguageWordsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} of {total}'**
  String learnedLanguageWordsCount(int count, int total);

  /// No description provided for @learnedLanguageChooseWordsButton.
  ///
  /// In en, this message translates to:
  /// **'Choose words'**
  String get learnedLanguageChooseWordsButton;

  /// No description provided for @learnedLanguagePauseButton.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get learnedLanguagePauseButton;

  /// No description provided for @learnedLanguageResumeButton.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get learnedLanguageResumeButton;

  /// No description provided for @learnedLanguageLastActiveHint.
  ///
  /// In en, this message translates to:
  /// **'You need at least one language to learn.'**
  String get learnedLanguageLastActiveHint;

  /// No description provided for @learnedLanguageDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete {language}?'**
  String learnedLanguageDeleteTitle(String language);

  /// No description provided for @learnedLanguageDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Your progress in {language} is deleted. Your words stay in your other languages.'**
  String learnedLanguageDeleteMessage(String language);

  /// No description provided for @learnedLanguageResumeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back to {language}'**
  String learnedLanguageResumeTitle(String language);

  /// No description provided for @learnedLanguageResumeMessage.
  ///
  /// In en, this message translates to:
  /// **'Continue where you left off, or start over?'**
  String get learnedLanguageResumeMessage;

  /// No description provided for @learnedLanguageStartOverButton.
  ///
  /// In en, this message translates to:
  /// **'Start over'**
  String get learnedLanguageStartOverButton;

  /// No description provided for @languageWordsTitle.
  ///
  /// In en, this message translates to:
  /// **'Words in {language}'**
  String languageWordsTitle(String language);

  /// No description provided for @languageWordsAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn {language} too?'**
  String languageWordsAddTitle(String language);

  /// No description provided for @languageWordsAddQuestion.
  ///
  /// In en, this message translates to:
  /// **'Which of your words do you want to learn in {language}?'**
  String languageWordsAddQuestion(String language);

  /// No description provided for @languageWordsAllOption.
  ///
  /// In en, this message translates to:
  /// **'All words ({count})'**
  String languageWordsAllOption(int count);

  /// No description provided for @languageWordsChooseOption.
  ///
  /// In en, this message translates to:
  /// **'Choose collections'**
  String get languageWordsChooseOption;

  /// No description provided for @languageWordsNoneOption.
  ///
  /// In en, this message translates to:
  /// **'None, start fresh'**
  String get languageWordsNoneOption;

  /// No description provided for @languageWordsLeftOutHint.
  ///
  /// In en, this message translates to:
  /// **'Words you leave out stay in your other languages. You can add them to {language} any time.'**
  String languageWordsLeftOutHint(String language);

  /// No description provided for @languageWordsUntaggedLabel.
  ///
  /// In en, this message translates to:
  /// **'Not in a collection'**
  String get languageWordsUntaggedLabel;

  /// No description provided for @languageWordsCount.
  ///
  /// In en, this message translates to:
  /// **'({count})'**
  String languageWordsCount(int count);

  /// No description provided for @languageWordsPartialCount.
  ///
  /// In en, this message translates to:
  /// **'({count} of {total})'**
  String languageWordsPartialCount(int count, int total);

  /// No description provided for @languageWordsStartButton.
  ///
  /// In en, this message translates to:
  /// **'Start {language}'**
  String languageWordsStartButton(String language);

  /// No description provided for @languageWordsSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get languageWordsSaveButton;

  /// No description provided for @languageWordsSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Save changes?'**
  String get languageWordsSummaryTitle;

  /// No description provided for @languageWordsSummaryAdded.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No words are added.} =1{1 word is added.} other{{count} words are added.}}'**
  String languageWordsSummaryAdded(int count);

  /// No description provided for @languageWordsSummaryRemoved.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No words are removed.} =1{1 word is removed.} other{{count} words are removed.}}'**
  String languageWordsSummaryRemoved(int count);

  /// No description provided for @languageWordsSummaryRestartHint.
  ///
  /// In en, this message translates to:
  /// **'Removed words start over if you add them again.'**
  String get languageWordsSummaryRestartHint;

  /// No description provided for @languageWordsSummaryAlsoElsewhere.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 of them is also in another collection.} other{{count} of them are also in other collections.}}'**
  String languageWordsSummaryAlsoElsewhere(int count);

  /// No description provided for @languageWordsNoWordsHint.
  ///
  /// In en, this message translates to:
  /// **'You have no words yet. Words you add are learned in {language} too.'**
  String languageWordsNoWordsHint(String language);

  /// No description provided for @homeManageLanguagesButton.
  ///
  /// In en, this message translates to:
  /// **'Manage languages'**
  String get homeManageLanguagesButton;

  /// No description provided for @homeEmptyLanguageMessage.
  ///
  /// In en, this message translates to:
  /// **'None of your words are in {language} yet.'**
  String homeEmptyLanguageMessage(String language);

  /// No description provided for @homeChooseWordsButton.
  ///
  /// In en, this message translates to:
  /// **'Choose words'**
  String get homeChooseWordsButton;

  /// No description provided for @homeLanguageButtonTooltip.
  ///
  /// In en, this message translates to:
  /// **'Switch language'**
  String get homeLanguageButtonTooltip;

  /// No description provided for @settingsLanguagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get settingsLanguagesTitle;

  /// No description provided for @learnedLanguageAskMeInAlwaysHelpMessage.
  ///
  /// In en, this message translates to:
  /// **'Cards ask in {askMeIn} instead of {main}. You can always show the {main} word. This keeps your {askMeIn} active while you learn {learned}.'**
  String learnedLanguageAskMeInAlwaysHelpMessage(String askMeIn, String main, String learned);

  /// No description provided for @detailsPausedLanguagesTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Paused language (1)} other{Paused languages ({count})}}'**
  String detailsPausedLanguagesTitle(int count);

  /// No description provided for @detailsLearnSwitchLabel.
  ///
  /// In en, this message translates to:
  /// **'Learn in {language}'**
  String detailsLearnSwitchLabel(String language);

  /// No description provided for @detailsExistingTitle.
  ///
  /// In en, this message translates to:
  /// **'Already saved'**
  String get detailsExistingTitle;

  /// No description provided for @detailsExistingMessage.
  ///
  /// In en, this message translates to:
  /// **'“{word}” is already saved ({language}: {translation}). Add it to {target}?'**
  String detailsExistingMessage(String word, String language, String translation, String target);

  /// No description provided for @detailsExistingAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add to {language}'**
  String detailsExistingAddButton(String language);

  /// No description provided for @practiceCustomTooltip.
  ///
  /// In en, this message translates to:
  /// **'Custom practice'**
  String get practiceCustomTooltip;

  /// No description provided for @customPracticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Custom practice'**
  String get customPracticeTitle;

  /// No description provided for @customPracticeLanguagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get customPracticeLanguagesTitle;

  /// No description provided for @customPracticeAllOption.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get customPracticeAllOption;

  /// No description provided for @customPracticeCollectionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get customPracticeCollectionsTitle;

  /// No description provided for @customPracticeChooseOption.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get customPracticeChooseOption;

  /// No description provided for @customPracticeWordsTitle.
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get customPracticeWordsTitle;

  /// No description provided for @customPracticeDueOption.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get customPracticeDueOption;

  /// No description provided for @customPracticeAllWordsOption.
  ///
  /// In en, this message translates to:
  /// **'All words'**
  String get customPracticeAllWordsOption;

  /// No description provided for @customPracticeNewWordsTitle.
  ///
  /// In en, this message translates to:
  /// **'New words'**
  String get customPracticeNewWordsTitle;

  /// No description provided for @customPracticeNoNewWordsOption.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get customPracticeNoNewWordsOption;

  /// No description provided for @customPracticeUpToLimitOption.
  ///
  /// In en, this message translates to:
  /// **'Up to the limit'**
  String get customPracticeUpToLimitOption;

  /// No description provided for @customPracticeAllWaitingOption.
  ///
  /// In en, this message translates to:
  /// **'All waiting'**
  String get customPracticeAllWaitingOption;

  /// No description provided for @customPracticeStartButton.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No words to practice} =1{Start 1 word} other{Start {count} words}}'**
  String customPracticeStartButton(int count);

  /// No description provided for @customPracticeReplaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Replace your custom practice?'**
  String get customPracticeReplaceTitle;

  /// No description provided for @customPracticeReplaceMessage.
  ///
  /// In en, this message translates to:
  /// **'Your unfinished custom practice ends when you start a new one.'**
  String get customPracticeReplaceMessage;

  /// No description provided for @customPracticeReplaceButton.
  ///
  /// In en, this message translates to:
  /// **'Start new'**
  String get customPracticeReplaceButton;

  /// No description provided for @homeCustomPracticeProgress.
  ///
  /// In en, this message translates to:
  /// **'Custom practice: {remaining} of {total} left'**
  String homeCustomPracticeProgress(int remaining, int total);

  /// No description provided for @homeCustomPracticeContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get homeCustomPracticeContinueButton;

  /// No description provided for @homeCustomPracticeEndButton.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get homeCustomPracticeEndButton;

  /// No description provided for @practiceIntroSkipButton.
  ///
  /// In en, this message translates to:
  /// **'Skip in {language}'**
  String practiceIntroSkipButton(String language);

  /// No description provided for @practiceIntroGotItButton.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get practiceIntroGotItButton;

  /// No description provided for @practiceShowMainButton.
  ///
  /// In en, this message translates to:
  /// **'Show {language}'**
  String practiceShowMainButton(String language);

  /// No description provided for @collectionEmptyLanguageMessage.
  ///
  /// In en, this message translates to:
  /// **'None of these words are in {language} yet.'**
  String collectionEmptyLanguageMessage(String language);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'el', 'en', 'es', 'fr', 'it', 'ro', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ro':
      return AppLocalizationsRo();
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
