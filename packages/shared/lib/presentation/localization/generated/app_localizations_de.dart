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
  String homeAddFirstWordMessage(String plus) {
    return 'Klicke auf den $plus-Button,\num dein erstes Wort hinzuzufügen!';
  }

  @override
  String get homeLookAroundTitle => 'Schau dich um!\nWas siehst du?';

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
  String get detailsReportTranslationButton => 'Fehlerhafte Übersetzung melden';

  @override
  String get detailsReplaceTitle => 'Ersetzen?';

  @override
  String get detailsReplaceMessage => 'Vokabel neu übersetzen und ersetzen?';

  @override
  String get detailsDuplicateTitle => 'Duplikat!';

  @override
  String get detailsDuplicateAddButton => 'Hinzufügen';

  @override
  String get detailsOpenGalleryButton => 'Aus der Galerie';

  @override
  String get detailsRemoveImageButton => 'Bild entfernen';

  @override
  String get detailsPexelsAttribution => 'Bilder von Pexels';

  @override
  String get detailsSaveButton => 'Speichern';

  @override
  String get detailsTakePictureButton => 'Foto aufnehmen';

  @override
  String get detailsCollectionNameHint => 'Unbenannt';

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
  String get practiceAnswerLabel => 'Deine Antwort';

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
  String get settingsStrictCorrectionTitle => 'Strenge Korrektur';

  @override
  String get settingsStrictCorrectionHint => 'Akzente und Sonderzeichen müssen genau stimmen';

  @override
  String get settingsCollectionsTitle => 'Sammlungen aktivieren';

  @override
  String get settingsCollectionsHint => 'Kategorisiere Wörter in Sammlungen';

  @override
  String get settingsImagesHiddenTitle => 'Bilder verstecken';

  @override
  String get settingsImagesHiddenHint => 'Könnte Lernerfolg beeinträchtigen';

  @override
  String get settingsDefaultGatherTitle => 'Standard beim Hinzufügen';

  @override
  String get settingsDefaultGatherHint =>
      'Der +-Button startet direkt, langes Drücken zeigt alle Optionen';

  @override
  String get settingsDefaultGatherNone => 'Keiner';

  @override
  String get settingsAppearanceTitle => 'Erscheinungsbild';

  @override
  String get settingsAppearanceHint => 'Hell, dunkel oder wie dein Handy';

  @override
  String get settingsAppearanceSystem => 'System';

  @override
  String get settingsAppearanceLight => 'Hell';

  @override
  String get settingsAppearanceDark => 'Dunkel';

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
  String vocabularyPhotoByLabel(String author) {
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
  String get languageEnglishUk => 'Englisch (UK)';

  @override
  String get languageEnglishUs => 'Englisch (USA)';

  @override
  String get languageSpanishSpain => 'Spanisch (Spanien)';

  @override
  String get languageSpanishLatinAmerica => 'Spanisch (Lateinamerika)';

  @override
  String get languageFrenchFrance => 'Französisch (Frankreich)';

  @override
  String get languageFrenchCanada => 'Französisch (Kanada)';

  @override
  String get languageGermanGermany => 'Deutsch (Deutschland)';

  @override
  String get languageGermanSwitzerland => 'Deutsch (Schweiz)';

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
  String homeStatusManyWordsMessage(int count, String language) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Du hast schon $count Wörter auf $language hinzugefügt, stark!',
      one: 'Du hast schon $count Wort auf $language hinzugefügt, stark!',
    );
    return '$_temp0';
  }

  @override
  String homeStatusDefaultMessage(int count, String language) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Du hast $count Wörter auf $language.',
      one: 'Du hast $count Wort auf $language.',
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
  String get vocabularyTranslationPendingLabel => 'Übersetzung folgt';

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
  String get detailsRetakeImageButton => 'Neues Foto aufnehmen';

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
    return 'Alle $days aktiven Tage in Folge bekommst du einen Serienschutz, bis zu $max. Er rettet deine Serie an einem verpassten Tag.';
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

  @override
  String get languagesTitle => 'Deine Sprachen';

  @override
  String get languagesSpeakTitle => 'Ich spreche';

  @override
  String get languagesLearnTitle => 'Ich lerne';

  @override
  String get languagesLearnHint => 'Wähle eine oder mehrere';

  @override
  String get languagesContinueButton => 'Weiter';

  @override
  String get languagesPausedTitle => 'Pausiert';

  @override
  String get languagesChangeButton => 'Ändern';

  @override
  String get languagesAddButton => 'Sprache hinzufügen';

  @override
  String languagesWordCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wörter',
      one: '1 Wort',
    );
    return '$_temp0';
  }

  @override
  String get languagesPickTitle => 'Sprache wählen';

  @override
  String get learnedLanguageAskMeInLabel => 'Frag mich auf';

  @override
  String get learnedLanguageAddAskMeInButton => 'Frag mich auf einer anderen Sprache';

  @override
  String learnedLanguageAskMeInHelpMessage(String askMeIn, String main, String learned) {
    return 'Karten fragen auf $askMeIn statt auf $main, bei Wörtern, die du auf $askMeIn schon gut kannst. Das Wort auf $main kannst du jederzeit anzeigen. So bleibt dein $askMeIn aktiv, während du $learned lernst.';
  }

  @override
  String get learnedLanguageAskMeInHelpTooltip => 'Was bedeutet das?';

  @override
  String get learnedLanguageRemoveAskMeInTooltip => 'Entfernen';

  @override
  String get learnedLanguageNewWordsTitle => 'Neue Wörter pro Übung';

  @override
  String get learnedLanguageAllNewWords => 'Alle';

  @override
  String learnedLanguagePauseButton(String language) {
    return '$language pausieren';
  }

  @override
  String learnedLanguageResumeButton(String language) {
    return '$language fortsetzen';
  }

  @override
  String get learnedLanguageLastActiveHint => 'Du brauchst mindestens eine Sprache zum Lernen.';

  @override
  String get learnedLanguageStartOverButton => 'Neu anfangen';

  @override
  String get languageWordsAllOption => 'Alle Wörter';

  @override
  String get languageWordsNoneOption => 'Keine';

  @override
  String get languageWordsUntaggedLabel => 'In keiner Sammlung';

  @override
  String get languageWordsSaveButton => 'Speichern';

  @override
  String languageWordsNoWordsHint(String language) {
    return 'Du hast noch keine Wörter. Neue Wörter lernst du auch auf $language.';
  }

  @override
  String get homeManageLanguagesButton => 'Sprachen verwalten';

  @override
  String homeEmptyLanguageMessage(int count, String source, String language) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Du hast $count Wörter auf $source. Importiere die, die du auch auf $language lernen möchtest.',
      one:
          'Du hast 1 Wort auf $source. Importiere es, wenn du es auch auf $language lernen möchtest.',
    );
    return '$_temp0';
  }

  @override
  String get homeChooseWordsButton => 'Wörter wählen';

  @override
  String learnedLanguageAskMeInUnlearnedHelpMessage(String askMeIn, String main, String learned) {
    return 'Karten fragen auf $askMeIn statt auf $main, bei Wörtern, die du auf $learned schon gut kannst. Das Wort auf $main kannst du jederzeit anzeigen. So bleibt dein $askMeIn aktiv, während du $learned lernst.';
  }

  @override
  String detailsLearnSwitchLabel(String language) {
    return 'Auf $language lernen';
  }

  @override
  String get detailsLastLanguageHint => 'Du musst dieses Wort in mindestens einer Sprache lernen.';

  @override
  String get detailsExistingTitle => 'Schon gespeichert';

  @override
  String detailsExistingMessage(String word, String language, String translation, String target) {
    return '„$word“ ist schon gespeichert ($language: $translation). Zu $target hinzufügen?';
  }

  @override
  String detailsExistingAddButton(String language) {
    return 'Zu $language hinzufügen';
  }

  @override
  String get practiceCustomTooltip => 'Eigene Übung';

  @override
  String get customPracticeTitle => 'Eigene Übung';

  @override
  String get customPracticeAllOption => 'Alle';

  @override
  String get customPracticeCollectionsTitle => 'Sammlungen';

  @override
  String customPracticeStartButton(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wörter üben',
      one: '1 Wort üben',
      zero: 'Keine Wörter zum Üben',
    );
    return '$_temp0';
  }

  @override
  String get customPracticeReplaceTitle => 'Eigene Übung ersetzen?';

  @override
  String get customPracticeReplaceMessage =>
      'Deine angefangene eigene Übung endet, wenn du eine neue startest.';

  @override
  String get customPracticeReplaceButton => 'Neu starten';

  @override
  String homeCustomPracticeProgress(int remaining, int total) {
    return '$remaining von $total übrig';
  }

  @override
  String get homeCustomPracticeContinueButton => 'Weiter';

  @override
  String get homeCustomPracticeEndButton => 'Beenden';

  @override
  String practiceIntroSkipButton(String language) {
    return 'Auf $language überspringen';
  }

  @override
  String get practiceIntroGotItButton => 'Verstanden';

  @override
  String practiceShowMainButton(String language) {
    return '$language zeigen';
  }

  @override
  String collectionEmptyLanguageMessage(String language) {
    return 'Noch keins dieser Wörter ist auf $language.';
  }

  @override
  String get languageEnglish => 'Englisch';

  @override
  String get languageSpanish => 'Spanisch';

  @override
  String get languageFrench => 'Französisch';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String photoStackMoreLabel(String count) {
    return '+$count';
  }

  @override
  String get languageOnboardingSpeakTitle => 'Welche Sprache sprichst du?';

  @override
  String get languageOnboardingLearnTitle => 'Was möchtest du lernen?';

  @override
  String languageOnboardingContinueWithButton(int count) {
    return 'Weiter mit $count';
  }

  @override
  String get languagesPauseAction => 'Pausieren';

  @override
  String languagesAsksInLabel(String flag) {
    return 'Fragt auf $flag';
  }

  @override
  String languagesPausedWordCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wörter, Fortschritt bleibt',
      one: '1 Wort, Fortschritt bleibt',
    );
    return '$_temp0';
  }

  @override
  String get languagesContinueWhereLeftOffButton => 'Weitermachen, wo ich war';

  @override
  String languageDeleteButton(String language) {
    return '$language löschen';
  }

  @override
  String languageDeleteTitle(String language) {
    return '$language löschen?';
  }

  @override
  String get languageDeleteDeletedLabel => 'Gelöscht';

  @override
  String languageDeleteProgressLine(String language, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Fortschritt in $language für $count Wörter',
      one: 'Fortschritt in $language für 1 Wort',
    );
    return '$_temp0';
  }

  @override
  String get languageDeleteKeptLabel => 'Bleibt';

  @override
  String get languageDeleteWordsLine => 'Alle Wörter, Fotos und Sammlungen';

  @override
  String languageDeleteKeptProgressLine(String language) {
    return 'Dein Fortschritt in $language';
  }

  @override
  String get mainLanguageClashEmphasis => 'lernst';

  @override
  String mainLanguageClashTitle(String emphasis, String language) {
    return 'Du $emphasis $language';
  }

  @override
  String mainLanguageClashMessage(String language, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Damit du $language sprichst, wird $language als Lernsprache pausiert. Deine $count Wörter und ihr Fortschritt bleiben erhalten.',
      one:
          'Damit du $language sprichst, wird $language als Lernsprache pausiert. Dein Wort und sein Fortschritt bleiben erhalten.',
    );
    return '$_temp0';
  }

  @override
  String mainLanguageClashSwitchButton(String language) {
    return '$language pausieren und wechseln';
  }

  @override
  String mainLanguageClashKeepButton(String language) {
    return 'Bei $language bleiben';
  }

  @override
  String learnedLanguageAskMeInFromRole(String level) {
    return 'Frag mich auf, ab $level';
  }

  @override
  String get learnedLanguageFromLevelTitle => 'Ab Stufe';

  @override
  String learnedLanguageBelowLevelHint(String language) {
    return 'Wörter unter dieser Stufe fragen auf $language.';
  }

  @override
  String learnedLanguageAskMeInIntroMessage(String main, String learned) {
    return 'Karten können statt auf $main in einer anderen Sprache fragen. Das $main-Wort kannst du immer anzeigen. So bleibt eine weitere Sprache aktiv, während du $learned lernst.';
  }

  @override
  String learnedLanguagePausedMessage(String language) {
    return '$language pausiert';
  }

  @override
  String get undo => 'Rückgängig';

  @override
  String learnedLanguagePausedHint(String language, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$language ist auf der Startseite und beim Üben ausgeblendet. Der Fortschritt für seine $count Wörter bleibt erhalten.',
      one:
          '$language ist auf der Startseite und beim Üben ausgeblendet. Der Fortschritt für sein Wort bleibt erhalten.',
    );
    return '$_temp0';
  }

  @override
  String get learnedLanguageImportedWordsTitle => 'Importierte Wörter';

  @override
  String learnedLanguageTotalWordsHint(int count) {
    return 'Du hast insgesamt $count';
  }

  @override
  String get languageWordsManageTitle => 'Wörter verwalten';

  @override
  String languageWordsImportButton(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wörter importieren',
      one: '1 Wort importieren',
      zero: 'Ohne Wörter starten',
    );
    return '$_temp0';
  }

  @override
  String languageWordsImportTitle(String language) {
    return 'Welche Wörter möchtest du nach $language importieren?';
  }

  @override
  String get languageWordsImportHint => 'Das kannst du später ändern.';

  @override
  String get languageWordsSomeCollectionsOption => 'Einige Sammlungen';

  @override
  String get languageWordsNoneHint => 'Mit einer leeren Liste starten';

  @override
  String languageWordsAddedLabel(String count) {
    return '+$count';
  }

  @override
  String languageWordsRemovedLabel(String count) {
    return '−$count';
  }

  @override
  String languageWordsImportedCount(int count, int total) {
    return '$count von $total Wörtern importiert';
  }

  @override
  String languageWordsRemovedWarning(int count, String language) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wörter, Fortschritt in $language wird gelöscht',
      one: '1 Wort, Fortschritt in $language wird gelöscht',
    );
    return '$_temp0';
  }

  @override
  String homeEmptyLanguageTitle(String language) {
    return 'Noch keins deiner Wörter ist auf $language';
  }

  @override
  String homeEmptyLanguageNoSourceMessage(String language) {
    return 'Importiere die Wörter, die du auf $language lernen möchtest.';
  }

  @override
  String get homeImportWordsButton => 'Wörter importieren';

  @override
  String homeEmptyLanguageFeedHint(String language) {
    return 'Wörter, die du hinzufügst, während $language ausgewählt ist, erscheinen hier.';
  }

  @override
  String practiceQuestionTitle(String language) {
    return 'Wie heißt dieses Wort auf $language?';
  }

  @override
  String practiceIntroTitle(String language) {
    return 'Neues Wort auf $language';
  }

  @override
  String practiceAnswerTitle(String language) {
    return 'Deine Antwort auf $language';
  }

  @override
  String get practiceSolutionLabel => 'Lösung';

  @override
  String get practiceSuggestedLabel => 'Empfohlen';

  @override
  String get practiceEditTitle => 'Wort bearbeiten';

  @override
  String get practiceEditFullButton => 'Alles bearbeiten';

  @override
  String get practiceEditSaveButton => 'Speichern';

  @override
  String customPracticeWordsLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wörter',
      one: 'Wort',
    );
    return '$_temp0';
  }

  @override
  String customPracticeDueLegend(int count) {
    return 'fällig $count';
  }

  @override
  String customPracticeAllLegend(int count) {
    return 'alle $count';
  }

  @override
  String customPracticeNewLegend(int count) {
    return 'neu $count';
  }

  @override
  String get customPracticeDueLabel => 'Fällig';

  @override
  String get customPracticeAllWordsLabel => 'Alle Wörter';

  @override
  String get customPracticeNewLabel => 'Neu';

  @override
  String get customPracticeFewerTooltip => 'Weniger';

  @override
  String get customPracticeMoreTooltip => 'Mehr';

  @override
  String get customPracticeDoneButton => 'Fertig';

  @override
  String detailsMissingTextLabel(String language) {
    return '($language)';
  }

  @override
  String detailsUntranslatedHint(int count, String language) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'In $count Sprachen übst du das Wort, sobald die Übersetzungen da sind.',
      one: 'Auf $language übst du das Wort, sobald die Übersetzung da ist.',
    );
    return '$_temp0';
  }

  @override
  String get homeCustomPracticeEndTitle => 'Eigene Übung beenden?';

  @override
  String homeCustomPracticeEndMessage(int remaining) {
    String _temp0 = intl.Intl.pluralLogic(
      remaining,
      locale: localeName,
      other: 'Es sind noch $remaining Wörter übrig.',
      one: 'Es ist noch 1 Wort übrig.',
    );
    return '$_temp0 Deine bisherigen Antworten bleiben gespeichert.';
  }

  @override
  String get streakCurrentLabel => 'Aktuelle Serie';

  @override
  String get homeWriteTitle => 'Neues Wort';

  @override
  String get homeWriteLanguageTitle => 'Schreibe das Wort auf';

  @override
  String get homeWriteLearningLabel => 'Lerne ich';

  @override
  String get vocabularyPhotoOnPexelsLabel => 'Foto auf Pexels';

  @override
  String get detailsAddPictureTitle => 'Bild hinzufügen';

  @override
  String get detailsNoPictureTitle => 'Kein Bild für dieses Wort';

  @override
  String get detailsCameraButton => 'Kamera';

  @override
  String get detailsGalleryButton => 'Galerie';

  @override
  String get detailsUseOwnPhotoButton => 'Deins verwenden';

  @override
  String get detailsPexelsHint => 'Oder wähle unten eins von Pexels';

  @override
  String get detailsRemovePictureTooltip => 'Bild entfernen';

  @override
  String get detailsMorePicturesTooltip => 'Weitere Bilder';

  @override
  String get detailsNewCollectionTitle => 'Neue Sammlung';

  @override
  String get detailsEmojiSearchHint => 'Emoji suchen (Englisch)';

  @override
  String get detailsEmojiNoResultsMessage => 'Kein Emoji gefunden';

  @override
  String get detailsEditWordTitle => 'Wort bearbeiten';

  @override
  String get detailsDoneButton => 'Fertig';

  @override
  String get detailsAddLanguageButton => 'Weitere Sprache hinzufügen';

  @override
  String get scanFocusLockedLabel => 'Fokus gesperrt';

  @override
  String get scanFlashTooltip => 'Blitz';

  @override
  String get scanSwitchCameraTooltip => 'Kamera wechseln';

  @override
  String get scanGalleryTooltip => 'Aus der Galerie wählen';

  @override
  String get scanShutterTooltip => 'Foto aufnehmen';

  @override
  String scanZoomLabel(String zoom) {
    return '$zoom×';
  }

  @override
  String get settingsDisplaySectionTitle => 'Anzeige';

  @override
  String get settingsLearningSectionTitle => 'Lernen';

  @override
  String get settingsNotificationsSectionTitle => 'Benachrichtigungen';

  @override
  String get settingsBackupSectionTitle => 'Sicherung';

  @override
  String get settingsAboutSectionTitle => 'Über die App';

  @override
  String get collectionsEditTitle => 'Sammlung bearbeiten';

  @override
  String get collectionsEmojiTooltip => 'Emoji auswählen';

  @override
  String get homeTranslationLimitMessage =>
      'Tageslimit für Übersetzungen erreicht. Fehlende Übersetzungen folgen morgen.';
}
