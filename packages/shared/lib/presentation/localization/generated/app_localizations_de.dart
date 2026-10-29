// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Vocabualize';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get close => 'Schließen';

  @override
  String get back => 'Zurück';

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String get error => 'Fehler';

  @override
  String get errorConnection =>
      'Der Server ist nicht erreichbar. Prüfe deine Internetverbindung und versuche es erneut.';

  @override
  String errorApi(String message) {
    return 'Fehler bei der Kommunikation mit dem Server: $message.';
  }

  @override
  String get errorAuth => 'Du bist nicht angemeldet.';

  @override
  String get errorValidation => 'Die empfangenen Daten sind ungültig.';

  @override
  String get errorNotFound => 'Nicht gefunden.';

  @override
  String get errorUnexpected => 'Ein unerwarteter Fehler ist aufgetreten.';

  @override
  String get unknown => 'unbekannt';

  @override
  String get no => 'Nein';

  @override
  String get yes => 'Ja';

  @override
  String get okay => 'Okay';

  @override
  String get submit => 'Absenden';

  @override
  String get delete => 'Löschen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get languagePickerTitle => 'Sprache auswählen';

  @override
  String get vocabularyDeleteTitle => 'Löschen?';

  @override
  String get vocabularyDeleteMessage => 'Bist du sicher, dass du diese Vokabel löschen möchtest?';

  @override
  String get vocabularyCreatedLabel => 'Erstellt:';

  @override
  String get vocabularyReappearsLabel => 'Fällig:';

  @override
  String get vocabularyReappearsNow => 'Jetzt';

  @override
  String get vocabularyReappearsLessThanMinute => 'In weniger als einer Minute';

  @override
  String get notificationPracticeChannelName => 'Erinnerung zum Üben';

  @override
  String get notificationPracticeChannelDescription => 'Lass uns üben 🎯';

  @override
  String get notificationPracticeTitle => 'Lass uns üben 🎯';

  @override
  String get notificationPracticeBody => 'Einige Vokabeln sind fällig. Du wirst das rocken! :D';

  @override
  String get welcomeSourceLanguageTitle => 'Ich spreche';

  @override
  String get welcomeTargetLanguageTitle => 'Ich lerne';

  @override
  String get welcomeStartButton => 'Auf geht\'s!';

  @override
  String get welcomeGoogleSignInButton => 'Mit Google anmelden';

  @override
  String get welcomeContinueWithoutAccountButton => 'Weiter ohne Konto';

  @override
  String get welcomeSignInFailedTitle => 'Anmeldung fehlgeschlagen';

  @override
  String get homeCollectionsTitle => 'Sammlungen';

  @override
  String get homeAddFirstWordMessage => 'Klicke auf den Button,\num dein erstes Wort hinzuzufügen!';

  @override
  String get homeAllWordsTitle => 'Alle Wörter';

  @override
  String get homeNewWordsTitle => 'Neue Wörter';

  @override
  String get homePracticeButton => 'Üben';

  @override
  String get homeScanButton => 'Scannen';

  @override
  String get homeWriteButton => 'Eingeben';

  @override
  String get homeWriteHint => 'Wort eingeben...';

  @override
  String get detailsSourceLabel => 'Quellwort';

  @override
  String get detailsTargetLabel => 'Übersetzung';

  @override
  String get detailsReportTranslationButton => 'Fehlerhafte Übersetzung melden';

  @override
  String get detailsAddCollectionButton => 'Sammlung hinzufügen';

  @override
  String get detailsReplaceTitle => 'Ersetzen?';

  @override
  String get detailsReplaceMessage => 'Vokabel neu übersetzen und ersetzen?';

  @override
  String get detailsDuplicateTitle => 'Duplikat!';

  @override
  String get detailsDuplicateAddButton => 'Hinzufügen';

  @override
  String get detailsNoImageMessage => 'Wähle ein Bild aus\noder speichere ohne';

  @override
  String get detailsOpenGalleryButton => 'Galerie öffnen';

  @override
  String get detailsRemoveImageButton => 'Bild entfernen';

  @override
  String get detailsPexelsAttribution => 'Stock-Bilder von Pexels.';

  @override
  String get detailsSaveButton => 'Speichern';

  @override
  String get detailsSaveWithoutImageButton => 'Ohne speichern';

  @override
  String get detailsTakePictureButton => 'Bild aufnehmen';

  @override
  String get detailsCollectionNameHint => 'Unbenannt';

  @override
  String get detailsCollectionNameLabel => 'Tag-Name';

  @override
  String get practiceDoneTitle => 'Gut gemacht!';

  @override
  String get practiceDoneMessage => 'Du hast alle\nfälligen Wörter geübt.';

  @override
  String get practiceDoneButton => 'Startseite';

  @override
  String get practiceForgotButton => 'Wusste ich nicht';

  @override
  String get practiceEasyButton => 'Leicht';

  @override
  String get practiceGoodButton => 'Gut';

  @override
  String get practiceHardButton => 'Hart';

  @override
  String get practiceSolutionButton => 'Lösung';

  @override
  String get practiceAnswerLabel => 'Lösung eingeben';

  @override
  String get scanAddButton => 'Okay';

  @override
  String get scanSuggestionsTitle => 'Vorschläge';

  @override
  String get scanNoSuggestionsMessage =>
      'Es konnten keine Objekte erkannt werden. Versuche es später erneut.';

  @override
  String get reportTranslationTitle => 'Fehlerhafte Übersetzung';

  @override
  String get reportTranslationNoteHint => 'Anmerkung (optional)';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsSignInHint => 'Melde dich an, um deine Daten zu synchronisieren.';

  @override
  String get settingsSignInButton => 'Anmelden';

  @override
  String get settingsTypeAnswerDisabledTitle => 'Schreib-Übungsmodus deaktivieren';

  @override
  String get settingsTypeAnswerDisabledHint => 'Nur Abrufübung mit Selbstbeurteilung nutzen';

  @override
  String get settingsCollectionsTitle => 'Sammlungen aktivieren';

  @override
  String get settingsCollectionsHint => 'Kategorisiere Wörter in Sammlungen';

  @override
  String get settingsImagesHiddenTitle => 'Bilder verstecken';

  @override
  String get settingsImagesHiddenHint => 'Könnte Lernerfolg beeinträchtigen';

  @override
  String get settingsSourceLanguageTitle => 'Meine Sprache';

  @override
  String get settingsSourceLanguageHint => 'Eine Sprache, die du beherrschst';

  @override
  String get settingsTargetLanguageTitle => 'Zielsprache';

  @override
  String get settingsTargetLanguageHint => 'Die Sprache, die du lernst';

  @override
  String vocabularyReappearsInMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'In $count Minuten',
      one: 'In $count Minute',
    );
    return '$_temp0';
  }

  @override
  String vocabularyReappearsInHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'In $count Stunden',
      one: 'In $count Stunde',
    );
    return '$_temp0';
  }

  @override
  String vocabularyReappearsInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'In $count Tagen',
      one: 'In $count Tag',
    );
    return '$_temp0';
  }

  @override
  String detailsDuplicateMessage(String word) {
    return 'Es scheint so, als existiere „$word“ bereits in deiner Sammlung.\n\nTrotzdem hinzufügen?';
  }

  @override
  String detailsPhotoByLabel(String author) {
    return 'Foto von $author';
  }

  @override
  String get detailsReplaceButton => 'Ersetzen';

  @override
  String get errorSyncPending => 'Deine letzten Änderungen wurden noch nicht hochgeladen.';

  @override
  String get settingsSignOutButton => 'Abmelden';

  @override
  String get settingsSignOutBlockedTitle => 'Änderungen nicht hochgeladen';

  @override
  String get settingsSignOutBlockedMessage =>
      'Einige Änderungen sind noch nicht auf dem Server angekommen. Verbinde dich mit dem Internet und versuche es erneut. Wenn du dich trotzdem abmeldest, gehen diese Änderungen verloren.';

  @override
  String get settingsSignOutAnywayButton => 'Trotzdem abmelden';

  @override
  String get syncStatusConnecting => 'Verbinde…';

  @override
  String get syncStatusSyncing => 'Wird synchronisiert…';

  @override
  String get syncStatusSynced => 'Alle Änderungen synchronisiert';

  @override
  String get syncStatusOffline =>
      'Offline. Änderungen werden synchronisiert, sobald du wieder online bist.';

  @override
  String get syncStatusUpdateRequired => 'Aktualisiere die App, um weiter zu synchronisieren.';

  @override
  String get syncStatusSignInRequired =>
      'Deine Sitzung ist abgelaufen. Melde dich erneut an, um weiter zu synchronisieren.';

  @override
  String get gateUpdateTitle => 'Update erforderlich';

  @override
  String get gateUpdateMessage =>
      'Diese Version von Vocabualize wird nicht mehr unterstützt. Bitte aktualisiere die App, um weiterzulernen.';

  @override
  String get gateUpdateButton => 'Aktualisieren';

  @override
  String get gateMaintenanceTitle => 'Wartungsarbeiten';

  @override
  String get gateMaintenanceMessage =>
      'Vocabualize wird gerade aktualisiert. Bitte versuche es später erneut.';

  @override
  String get settingsExportBackupButton => 'Sicherung exportieren';

  @override
  String get settingsExportBackupHint => 'Alle Wörter und Bilder als Datei speichern';

  @override
  String get settingsImportBackupButton => 'Sicherung importieren';

  @override
  String get settingsImportBackupHint => 'Die Wörter aus einer Sicherungsdatei hinzufügen';

  @override
  String get settingsImportBackupConfirmTitle => 'Sicherung importieren?';

  @override
  String get settingsImportBackupConfirmMessage =>
      'Alle Wörter, Sammlungen und Bilder aus der Sicherung werden zu deiner Sammlung hinzugefügt. Deine vorhandenen Wörter bleiben unverändert.';

  @override
  String get settingsImportBackupConfirmButton => 'Importieren';

  @override
  String settingsImportBackupDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wörter importiert.',
      one: '$count Wort importiert.',
    );
    return '$_temp0';
  }

  @override
  String get errorInvalidBackup => 'Diese Datei ist keine Vocabualize-Sicherung.';

  @override
  String get languageEnglish => 'Englisch';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageSpanish => 'Spanisch';

  @override
  String get languageFrench => 'Französisch';

  @override
  String get languagePolish => 'Polnisch';

  @override
  String get languageItalian => 'Italienisch';

  @override
  String get languageGreek => 'Griechisch';

  @override
  String get languageRomanian => 'Rumänisch';

  @override
  String languagePairLabel(String source, String target) {
    return '$source → $target';
  }

  @override
  String get languageSelectionTitle => 'Deine Sprachen';

  @override
  String get languageSelectionContinueButton => 'Weiter';

  @override
  String get languageSelectionSaveButton => 'Speichern';

  @override
  String get dataOfflineTitle => 'Du bist offline';

  @override
  String get dataOfflineMessage => 'Deine Wörter werden geladen, sobald du wieder online bist.';

  @override
  String get dataRetryButton => 'Erneut versuchen';

  @override
  String get dataSignInRequiredTitle => 'Erneut anmelden';

  @override
  String get dataSignInRequiredMessage =>
      'Deine Sitzung ist abgelaufen. Melde dich an, um deine Wörter zu laden.';

  @override
  String get dataSignInButton => 'Anmelden';

  @override
  String get syncStatusServerUnreachable =>
      'Der Server ist nicht erreichbar. Änderungen werden synchronisiert, sobald er wieder da ist.';

  @override
  String get syncStatusClockWrong =>
      'Die Uhr deines Handys geht falsch. Aktiviere die automatische Zeit, um weiter zu synchronisieren.';

  @override
  String get syncStatusFailed =>
      'Synchronisierung fehlgeschlagen. Deine Wörter sind auf diesem Handy sicher.';

  @override
  String get dataServerUnreachableTitle => 'Server nicht erreichbar';

  @override
  String get dataServerUnreachableMessage =>
      'Der Server von Vocabualize ist gerade nicht erreichbar. Deine Wörter sind auf diesem Handy sicher.';

  @override
  String get gateClockWrongTitle => 'Die Uhr deines Handys geht falsch';

  @override
  String get gateClockWrongMessage =>
      'Zum Synchronisieren braucht es die richtige Zeit. Aktiviere Datum und Uhrzeit automatisch und komm dann zurück.';

  @override
  String get gateOpenTimeSettingsButton => 'Zeiteinstellungen öffnen';

  @override
  String get dataSyncFailedTitle => 'Synchronisierung fehlgeschlagen';

  @override
  String get dataSyncFailedMessage =>
      'Beim Synchronisieren ist etwas schiefgelaufen. Deine Wörter sind auf diesem Handy sicher.';

  @override
  String get accountConflictTitle => 'Konto wechseln?';

  @override
  String accountConflictMessage(String previous, String next) {
    return 'Auf diesem Handy warst du als $previous angemeldet. Noch nicht hochgeladene Änderungen gehören zu diesem Konto. Sie gehen verloren, wenn du zu $next wechselst.';
  }

  @override
  String accountConflictKeepButton(String previous) {
    return 'Stattdessen $previous verwenden';
  }

  @override
  String accountConflictSwitchButton(String previous, String next) {
    return 'Daten von $previous löschen und $next verwenden';
  }

  @override
  String get accountConflictUnknownAccount => 'unbekanntes Konto';

  @override
  String get settingsSignInAgainButton => 'Erneut anmelden';

  @override
  String loadingProgressLabel(int current, int total) {
    return '$current / $total';
  }

  @override
  String get errorClockWrong =>
      'Die Uhr deines Handys geht falsch. Aktiviere Datum und Uhrzeit automatisch und versuche es dann erneut.';

  @override
  String get homeAllDoneMessage => 'Fürs Erste alles erledigt';

  @override
  String get homeStatusFirstWordMessage =>
      'Du hast dein erstes Wort hinzugefügt! Sammle weitere oder tippe auf „Üben“! :)';

  @override
  String get homeStatusEmptyMessage => 'Warum fügst du nicht ein paar Wörter hinzu? :)';

  @override
  String get homeStatusOnlyOneWordMessage =>
      'Deine Sammlung enthält nur ein Wort. Lass es nicht im Stich und füg weitere hinzu! :)';

  @override
  String homeStatusAddedTodayMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wow, du hast heute schon $count Wörter hinzugefügt. Weiter so!',
      one: 'Wow, du hast heute schon $count Wort hinzugefügt. Weiter so!',
    );
    return '$_temp0';
  }

  @override
  String homeStatusManyWordsMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Krass, du hast insgesamt $count Wörter hinzugefügt. Nicht schlecht!',
      one: 'Krass, du hast insgesamt $count Wort hinzugefügt. Nicht schlecht!',
    );
    return '$_temp0';
  }

  @override
  String homeStatusDefaultMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Deine Sammlung enthält $count Wörter.',
      one: 'Deine Sammlung enthält $count Wort.',
    );
    return '$_temp0';
  }

  @override
  String homeNextDueTodayMessage(String time) {
    return 'Nächstes Wort um $time';
  }

  @override
  String homeNextDueLaterMessage(String date) {
    return 'Nächstes Wort am $date';
  }

  @override
  String get vocabularySpeakTooltip => 'Vorlesen';

  @override
  String get vocabularySearchTooltip => 'Suchen';

  @override
  String get vocabularySearchHint => 'Vokabeln durchsuchen...';

  @override
  String get vocabularySearchClearTooltip => 'Leeren';

  @override
  String get vocabularySearchEmptyMessage => 'Keine Vokabel passt zu deiner Suche.';

  @override
  String get vocabularyFilterDueLabel => 'Fällig';

  @override
  String get vocabularyLevelNovice => 'Neu';

  @override
  String get vocabularyLevelBeginner => 'Anfänger';

  @override
  String get vocabularyLevelAdvanced => 'Fortgeschritten';

  @override
  String get vocabularyLevelExpert => 'Experte';

  @override
  String get errorTextToSpeechUnavailable =>
      'Auf diesem Handy ist keine Stimme für diese Sprache installiert.';

  @override
  String get detailsRetakeImageButton => 'Bild neu aufnehmen';

  @override
  String errorTranslationQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Du hast deine $limit Übersetzungen der letzten 24 Stunden verbraucht. Gib die Übersetzung selbst ein oder versuche es später erneut.',
      one:
          'Du hast deine $limit Übersetzung der letzten 24 Stunden verbraucht. Gib die Übersetzung selbst ein oder versuche es später erneut.',
    );
    return '$_temp0';
  }

  @override
  String errorStockImageQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Du hast deine $limit Fotosuchen der letzten 24 Stunden verbraucht. Mach selbst ein Foto oder versuche es später erneut.',
      one:
          'Du hast deine $limit Fotosuche der letzten 24 Stunden verbraucht. Mach selbst ein Foto oder versuche es später erneut.',
    );
    return '$_temp0';
  }

  @override
  String get errorServiceUnavailable => 'Automatische Vorschläge sind gerade nicht verfügbar.';

  @override
  String get collectionsDeleteButton => 'Sammlung löschen';

  @override
  String get collectionsDeleteTitle => 'Sammlung löschen?';

  @override
  String get collectionsDeleteMessage => 'Die Wörter bleiben. Nur die Sammlung wird gelöscht.';

  @override
  String get scanTypeHint => 'Wort eingeben...';

  @override
  String get scanOpenSettingsButton => 'Einstellungen öffnen';

  @override
  String get errorCameraPermission => 'Erlaube den Zugriff auf die Kamera, um Fotos aufzunehmen.';

  @override
  String get errorCameraUnavailable => 'Die Kamera kann gerade nicht verwendet werden.';

  @override
  String errorImageLabelingQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Du hast deine $limit Scans der letzten 24 Stunden verbraucht. Gib das Wort selbst ein oder versuche es später erneut.',
      one:
          'Du hast deinen $limit Scan der letzten 24 Stunden verbraucht. Gib das Wort selbst ein oder versuche es später erneut.',
    );
    return '$_temp0';
  }

  @override
  String errorImageLabelingMonthlyQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Du hast deine $limit Scans für diesen Monat verbraucht. Gib das Wort selbst ein oder versuche es nächsten Monat erneut.',
      one:
          'Du hast deinen $limit Scan für diesen Monat verbraucht. Gib das Wort selbst ein oder versuche es nächsten Monat erneut.',
    );
    return '$_temp0';
  }

  @override
  String errorQuotaSignInForMore(String message) {
    return '$message Melde dich mit Google an, um mehr zu bekommen.';
  }

  @override
  String get connectToInternet => 'Mit Internet verbinden';

  @override
  String get scanOfflineMessage =>
      'Für Vorschläge brauchst du eine Internetverbindung. Du kannst das Wort auch selbst eingeben.';

  @override
  String get detailsOfflineMessage =>
      'Für Übersetzung und Fotosuche brauchst du eine Internetverbindung.';

  @override
  String get welcomeOfflineMessage =>
      'Für die Anmeldung mit Google brauchst du eine Internetverbindung.';

  @override
  String get settingsSignInOfflineMessage =>
      'Für die Anmeldung brauchst du eine Internetverbindung.';

  @override
  String get settingsPracticeReminderTitle => 'Erinnerung zum Üben';

  @override
  String get settingsPracticeReminderHint => 'Nur an Tagen, an denen Wörter zum Üben anstehen';

  @override
  String get settingsReminderTimeTitle => 'Uhrzeit';

  @override
  String get settingsNotificationsBlockedMessage =>
      'Benachrichtigungen sind für Vocabualize ausgeschaltet.';

  @override
  String get settingsOpenNotificationSettingsButton => 'Einstellungen öffnen';

  @override
  String get reminderPracticeTitle => 'Zeit zum Üben';

  @override
  String get reminderPracticeBody => 'Deine Wörter warten. Ein paar Minuten halten sie frisch.';

  @override
  String get reminderPracticeChannel => 'Erinnerungen zum Üben';

  @override
  String get errorReportLimit =>
      'Du hast in letzter Zeit mehrere Meldungen gesendet. Versuche es später erneut.';

  @override
  String get errorReportUnavailable =>
      'Meldungen können gerade nicht gesendet werden. Versuche es später erneut.';

  @override
  String get reportFeedbackTitle => 'Feedback & Fehler';

  @override
  String get reportFeedbackMessage =>
      'Erzähl uns, was dir gefällt, was fehlt oder was schiefgelaufen ist.';

  @override
  String get reportFeedbackFieldHint => 'Deine Nachricht...';

  @override
  String get reportFeedbackContextHint =>
      'Mitgesendet: App-Version, Android-Version, App-Sprache und dein Sprachpaar.';

  @override
  String get reportSendButton => 'Senden';

  @override
  String get reportFeedbackSentMessage => 'Danke! Deine Nachricht wurde gesendet.';

  @override
  String get reportTranslationSentMessage => 'Danke! Die Übersetzung wurde gemeldet.';

  @override
  String get reportOfflineMessage => 'Zum Senden brauchst du eine Internetverbindung.';

  @override
  String get settingsDeleteAccountButton => 'Konto löschen';

  @override
  String get settingsDeleteDataButton => 'Alle Daten löschen';

  @override
  String get settingsDeleteAccountTitle => 'Konto löschen?';

  @override
  String get settingsDeleteAccountMessage =>
      'Dadurch werden dein Konto und alles darin auf allen deinen Geräten endgültig gelöscht: Wörter, Fotos, Sammlungen und Fortschritt. Das kann nicht rückgängig gemacht werden.';

  @override
  String get settingsDeleteDataTitle => 'Alle Daten löschen?';

  @override
  String get settingsDeleteDataMessage =>
      'Dadurch werden alle Wörter, Fotos, Sammlungen und dein Fortschritt auf diesem Handy endgültig gelöscht. Das kann nicht rückgängig gemacht werden.';

  @override
  String get settingsDeleteConfirmWord => 'LÖSCHEN';

  @override
  String settingsDeleteConfirmHint(String word) {
    return 'Gib $word ein, um zu bestätigen';
  }

  @override
  String get settingsDeleteConfirmButton => 'Löschen';

  @override
  String get settingsDeleteAccountOfflineMessage =>
      'Zum Löschen deines Kontos brauchst du eine Internetverbindung.';

  @override
  String streakTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage in Folge',
      one: '$count Tag in Folge',
      zero: 'Noch keine Serie',
    );
    return '$_temp0';
  }

  @override
  String get streakStartMessage => 'Übe oder füge ein Wort hinzu, um eine Serie zu starten.';

  @override
  String get streakDoneMessage => 'Für heute erledigt. Bis morgen!';

  @override
  String get streakPendingMessage =>
      'Übe heute oder füge ein Wort hinzu, um deine Serie zu halten.';

  @override
  String get streakLongestLabel => 'Längste Serie';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage',
      one: '$count Tag',
    );
    return '$_temp0';
  }

  @override
  String get streakFreezesLabel => 'Serienschutz';

  @override
  String streakFreezesValue(int count, int max) {
    return '$count von $max';
  }

  @override
  String streakFreezeExplanation(int days, int max) {
    return 'Alle $days aktiven Tage in Folge bekommst du einen Serienschutz (max. $max). Er rettet deine Serie an einem verpassten Tag.';
  }

  @override
  String get streakDayActive => 'Aktiv';

  @override
  String get streakDayFrozen => 'Durch Serienschutz gerettet';

  @override
  String get streakDayPending => 'Noch offen';

  @override
  String get streakDayMissed => 'Verpasst';

  @override
  String get settingsStreakReminderTitle => 'Erinnerung an die Serie';

  @override
  String get settingsStreakReminderHint => 'Nur an Tagen, an denen deine Serie in Gefahr ist';

  @override
  String get reminderStreakChannel => 'Erinnerungen an die Serie';

  @override
  String get reminderStreakKeepTitle => 'Halte deine Serie';

  @override
  String reminderStreakKeepBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Übe heute ein paar Wörter, um deine Serie von $count Tagen zu halten.',
      one: 'Übe heute ein paar Wörter, um deine Serie von $count Tag zu halten.',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakLookAroundTitle => 'Schau dich um';

  @override
  String get reminderStreakLookAroundBody =>
      'Siehst du etwas, das du noch nicht benennen kannst? Füge es als neues Wort hinzu.';

  @override
  String get reminderStreakQuickRoundTitle => 'Kurze Runde?';

  @override
  String reminderStreakQuickRoundBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Eine kurze Übungsrunde hält deine $count Tage am Leben.',
      one: 'Eine kurze Übungsrunde hält deine Serie am Leben.',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakNearbyTitle => 'Ein neues Wort in der Nähe?';

  @override
  String get reminderStreakNearbyBody =>
      'Such dir etwas in deiner Umgebung aus und lerne, wie es heißt.';

  @override
  String reminderStreakInARowTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage in Folge',
      one: '$count Tag in Folge',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakInARowBody => 'Hör jetzt nicht auf. Übe heute oder füge ein Wort hinzu.';

  @override
  String get settingsPrivacyPolicyButton => 'Datenschutzerklärung';

  @override
  String get scanReportSuggestionButton => 'Vorschlag melden';
}
