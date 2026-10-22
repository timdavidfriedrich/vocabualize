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
  String get errorConnection => 'Keine Internetverbindung.';

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
  String get homeTitle => 'Start';

  @override
  String get homeEmptyMessage => 'Hier ist noch nichts.';

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
  String get homeNoNewWordsMessage =>
      'Oh, du hast anscheinend schon länger keine Wörter mehr hinzugefügt. :(';

  @override
  String get homeStatusFirstWordMessage =>
      'Du hast dein erstes Wort hinzugefügt! Sammel weitere oder klick auf „Üben“.';

  @override
  String get homeStatusEmptyMessage => 'Warum fügst du nicht ein paar Wörter hinzu?';

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
  String get reportBugTitle => 'Fehler melden';

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
  String get settingsNotificationsTitle => 'Mitteilungen (de-)aktivieren';

  @override
  String get settingsNotificationsHint => 'Öffne System-Einstellungen der App zum Verwalten';

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
  String homeStatusTotalMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Deine Sammlung enthält $count Wörter.',
      one:
          'Deine Sammlung enthält nur $count Wort. Lass es nicht im Stich und füg weitere hinzu! :)',
    );
    return '$_temp0';
  }

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
  String homeStatusManyInTotalMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Krass, du hast insgesamt $count Wörter hinzugefügt. Nicht schlecht!',
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
  String get reportBugDescriptionHint => 'Beschreibe den Fehler...';
}
