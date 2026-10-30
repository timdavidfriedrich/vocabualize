// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Vocabualize';

  @override
  String get cancel => 'Annulla';

  @override
  String get close => 'Chiudi';

  @override
  String get back => 'Indietro';

  @override
  String get tryAgain => 'Riprova';

  @override
  String get error => 'Errore';

  @override
  String get errorConnection =>
      'Impossibile raggiungere il server. Controlla la connessione a Internet e riprova.';

  @override
  String errorApi(String message) {
    return 'Errore durante la comunicazione con il server: $message.';
  }

  @override
  String get errorAuth => 'Non hai effettuato l\'accesso.';

  @override
  String get errorValidation => 'I dati ricevuti non sono validi.';

  @override
  String get errorNotFound => 'Non trovato.';

  @override
  String get errorUnexpected => 'Si è verificato un errore imprevisto.';

  @override
  String get unknown => 'sconosciuto';

  @override
  String get no => 'No';

  @override
  String get yes => 'Sì';

  @override
  String get okay => 'OK';

  @override
  String get submit => 'Invia';

  @override
  String get delete => 'Elimina';

  @override
  String get edit => 'Modifica';

  @override
  String get languagePickerTitle => 'Seleziona la lingua';

  @override
  String get vocabularyDeleteTitle => 'Eliminare?';

  @override
  String get vocabularyDeleteMessage => 'Vuoi davvero eliminare questa parola?';

  @override
  String get vocabularyCreatedLabel => 'Creata:';

  @override
  String get vocabularyReappearsLabel => 'Prossimo ripasso:';

  @override
  String get vocabularyReappearsNow => 'Ora';

  @override
  String get vocabularyReappearsLessThanMinute => 'Tra meno di un minuto';

  @override
  String get notificationPracticeChannelName => 'Ripasso del vocabolario';

  @override
  String get notificationPracticeChannelDescription => 'Esercitiamoci 🎯';

  @override
  String get notificationPracticeTitle => 'Esercitiamoci 🎯';

  @override
  String get notificationPracticeBody =>
      'Alcune parole sono da ripassare. Ce la farai alla grande! :D';

  @override
  String get welcomeSourceLanguageTitle => 'Parlo';

  @override
  String get welcomeTargetLanguageTitle => 'Voglio imparare';

  @override
  String get welcomeStartButton => 'Iniziamo!';

  @override
  String get welcomeGoogleSignInButton => 'Accedi con Google';

  @override
  String get welcomeContinueWithoutAccountButton => 'Continua senza account';

  @override
  String get welcomeSignInFailedTitle => 'Accesso non riuscito';

  @override
  String get homeCollectionsTitle => 'Raccolte';

  @override
  String get homeAddFirstWordMessage => 'Tocca il pulsante\nper aggiungere la tua prima parola';

  @override
  String get homeAllWordsTitle => 'Tutte le parole';

  @override
  String get homeNewWordsTitle => 'Aggiunte di recente';

  @override
  String get homePracticeButton => 'Esercitati';

  @override
  String get homeScanButton => 'Scansiona';

  @override
  String get homeWriteButton => 'Scrivi';

  @override
  String get homeWriteHint => 'Scrivi una parola...';

  @override
  String get detailsSourceLabel => 'Originale';

  @override
  String get detailsTargetLabel => 'Traduzione';

  @override
  String get detailsReportTranslationButton => 'Segnala una traduzione errata';

  @override
  String get detailsAddCollectionButton => 'Aggiungi raccolta';

  @override
  String get detailsReplaceTitle => 'Sostituire?';

  @override
  String get detailsReplaceMessage => 'Tradurre di nuovo la parola e sostituirla?';

  @override
  String get detailsDuplicateTitle => 'Duplicato!';

  @override
  String get detailsDuplicateAddButton => 'Aggiungi';

  @override
  String get detailsNoImageMessage => 'Scegli un\'immagine\no salva senza';

  @override
  String get detailsOpenGalleryButton => 'Apri la galleria';

  @override
  String get detailsRemoveImageButton => 'Rimuovi immagine';

  @override
  String get detailsPexelsAttribution => 'Immagini fornite da Pexels.';

  @override
  String get detailsSaveButton => 'Salva';

  @override
  String get detailsSaveWithoutImageButton => 'Salva senza';

  @override
  String get detailsTakePictureButton => 'Scatta una foto';

  @override
  String get detailsCollectionNameHint => 'Senza titolo';

  @override
  String get detailsCollectionNameLabel => 'Nome della raccolta';

  @override
  String get practiceDoneTitle => 'Complimenti!';

  @override
  String get practiceDoneMessage => 'Hai ripassato tutte\nle parole previste.';

  @override
  String get practiceDoneButton => 'Fatto';

  @override
  String get practiceForgotButton => 'Non lo sapevo';

  @override
  String get practiceEasyButton => 'Facile';

  @override
  String get practiceGoodButton => 'Bene';

  @override
  String get practiceHardButton => 'Difficile';

  @override
  String get practiceSolutionButton => 'Soluzione';

  @override
  String get practiceAnswerLabel => 'La tua risposta';

  @override
  String get scanAddButton => 'Aggiungi';

  @override
  String get scanSuggestionsTitle => 'Suggerimenti';

  @override
  String get scanNoSuggestionsMessage =>
      'Non è stato riconosciuto nessun oggetto. Riprova più tardi.';

  @override
  String get reportTranslationTitle => 'Traduzione errata';

  @override
  String get reportTranslationNoteHint => 'Nota (facoltativa)';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsSignInHint => 'Accedi per sincronizzare i tuoi dati tra i dispositivi.';

  @override
  String get settingsSignInButton => 'Accedi';

  @override
  String get settingsTypeAnswerDisabledTitle => 'Disattiva la risposta scritta';

  @override
  String get settingsTypeAnswerDisabledHint => 'Usa solo il richiamo a memoria con autovalutazione';

  @override
  String get settingsStrictCorrectionTitle => 'Correzione rigorosa';

  @override
  String get settingsStrictCorrectionHint =>
      'Accenti e caratteri speciali devono essere scritti esattamente';

  @override
  String get settingsCollectionsTitle => 'Attiva le raccolte';

  @override
  String get settingsCollectionsHint => 'Organizza le parole in raccolte';

  @override
  String get settingsImagesHiddenTitle => 'Nascondi le immagini';

  @override
  String get settingsImagesHiddenHint => 'Potrebbe ridurre la qualità dell\'apprendimento';

  @override
  String get settingsDefaultGatherTitle => 'Aggiunta predefinita';

  @override
  String get settingsDefaultGatherHint =>
      'Il pulsante + inizia subito, una pressione prolungata mostra tutte le opzioni';

  @override
  String get settingsDefaultGatherNone => 'Nessuna';

  @override
  String get settingsAppearanceTitle => 'Aspetto';

  @override
  String get settingsAppearanceHint => 'Chiaro, scuro o come il tuo telefono';

  @override
  String get settingsAppearanceSystem => 'Sistema';

  @override
  String get settingsAppearanceLight => 'Chiaro';

  @override
  String get settingsAppearanceDark => 'Scuro';

  @override
  String get settingsSourceLanguageTitle => 'La mia lingua';

  @override
  String get settingsSourceLanguageHint => 'Una lingua che conosci bene';

  @override
  String get settingsTargetLanguageTitle => 'Lingua da imparare';

  @override
  String get settingsTargetLanguageHint => 'La lingua che stai imparando';

  @override
  String vocabularyReappearsInMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tra $count minuti',
      one: 'Tra $count minuto',
    );
    return '$_temp0';
  }

  @override
  String vocabularyReappearsInHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tra $count ore',
      one: 'Tra $count ora',
    );
    return '$_temp0';
  }

  @override
  String vocabularyReappearsInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tra $count giorni',
      one: 'Tra $count giorno',
    );
    return '$_temp0';
  }

  @override
  String detailsDuplicateMessage(String word) {
    return 'Sembra che «$word» sia già nella tua raccolta.\n\nAggiungerla comunque?';
  }

  @override
  String vocabularyPhotoByLabel(String author) {
    return 'Foto di $author';
  }

  @override
  String get detailsReplaceButton => 'Sostituisci';

  @override
  String get errorSyncPending => 'Le tue ultime modifiche non sono ancora state caricate.';

  @override
  String get settingsSignOutButton => 'Esci';

  @override
  String get settingsSignOutBlockedTitle => 'Modifiche non caricate';

  @override
  String get settingsSignOutBlockedMessage =>
      'Alcune modifiche non hanno ancora raggiunto il server. Connettiti a Internet e riprova. Se esci comunque, queste modifiche andranno perse.';

  @override
  String get settingsSignOutAnywayButton => 'Esci comunque';

  @override
  String get syncStatusConnecting => 'Connessione…';

  @override
  String get syncStatusSyncing => 'Sincronizzazione…';

  @override
  String get syncStatusSynced => 'Tutte le modifiche sono sincronizzate';

  @override
  String get syncStatusOffline =>
      'Offline. Le modifiche verranno sincronizzate quando tornerai online.';

  @override
  String get syncStatusUpdateRequired => 'Aggiorna l\'app per continuare a sincronizzare.';

  @override
  String get syncStatusSignInRequired =>
      'La sessione è scaduta. Accedi di nuovo per continuare a sincronizzare.';

  @override
  String get gateUpdateTitle => 'Aggiornamento necessario';

  @override
  String get gateUpdateMessage =>
      'Questa versione di Vocabualize non è più supportata. Aggiorna l\'app per continuare a imparare.';

  @override
  String get gateUpdateButton => 'Aggiorna';

  @override
  String get gateMaintenanceTitle => 'Manutenzione in corso';

  @override
  String get gateMaintenanceMessage => 'Vocabualize è in fase di aggiornamento. Riprova più tardi.';

  @override
  String get settingsExportBackupButton => 'Esporta backup';

  @override
  String get settingsExportBackupHint => 'Salva tutte le parole e le immagini in un file';

  @override
  String get settingsImportBackupButton => 'Importa backup';

  @override
  String get settingsImportBackupHint => 'Aggiungi le parole da un file di backup';

  @override
  String get settingsImportBackupConfirmTitle => 'Importare il backup?';

  @override
  String get settingsImportBackupConfirmMessage =>
      'Tutte le parole, le raccolte e le immagini del backup verranno aggiunte alla tua raccolta. Le parole che hai già restano invariate.';

  @override
  String get settingsImportBackupConfirmButton => 'Importa';

  @override
  String settingsImportBackupDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count parole importate.',
      one: '$count parola importata.',
    );
    return '$_temp0';
  }

  @override
  String get errorInvalidBackup => 'Questo file non è un backup di Vocabualize.';

  @override
  String get languageEnglishUk => 'Inglese (Regno Unito)';

  @override
  String get languageEnglishUs => 'Inglese (Stati Uniti)';

  @override
  String get languageSpanishSpain => 'Spagnolo (Spagna)';

  @override
  String get languageSpanishLatinAmerica => 'Spagnolo (America Latina)';

  @override
  String get languageFrenchFrance => 'Francese (Francia)';

  @override
  String get languageFrenchCanada => 'Francese (Canada)';

  @override
  String get languageGermanGermany => 'Tedesco (Germania)';

  @override
  String get languageGermanSwitzerland => 'Tedesco (Svizzera)';

  @override
  String get languagePolish => 'Polacco';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageGreek => 'Greco';

  @override
  String get languageRomanian => 'Rumeno';

  @override
  String languagePairLabel(String source, String target) {
    return '$source → $target';
  }

  @override
  String get languageSelectionTitle => 'Le tue lingue';

  @override
  String get languageSelectionContinueButton => 'Continua';

  @override
  String get languageSelectionSaveButton => 'Salva';

  @override
  String get dataOfflineTitle => 'Sei offline';

  @override
  String get dataOfflineMessage => 'Le tue parole verranno scaricate non appena ti connetti.';

  @override
  String get dataRetryButton => 'Riprova';

  @override
  String get dataSignInRequiredTitle => 'Accedi di nuovo';

  @override
  String get dataSignInRequiredMessage =>
      'La sessione è scaduta. Accedi per caricare le tue parole.';

  @override
  String get dataSignInButton => 'Accedi';

  @override
  String get syncStatusServerUnreachable =>
      'Il server non è raggiungibile. Le modifiche verranno sincronizzate appena torna disponibile.';

  @override
  String get syncStatusClockWrong =>
      'L\'orologio del telefono non è corretto. Attiva l\'ora automatica per continuare a sincronizzare.';

  @override
  String get syncStatusFailed =>
      'Sincronizzazione non riuscita. Le tue parole sono al sicuro su questo telefono.';

  @override
  String get dataServerUnreachableTitle => 'Server non raggiungibile';

  @override
  String get dataServerUnreachableMessage =>
      'Il server di Vocabualize non è raggiungibile al momento. Le tue parole sono al sicuro su questo telefono.';

  @override
  String get gateClockWrongTitle => 'L\'orologio del telefono non è corretto';

  @override
  String get gateClockWrongMessage =>
      'Per sincronizzare serve l\'ora corretta. Attiva data e ora automatiche, poi torna qui.';

  @override
  String get gateOpenTimeSettingsButton => 'Apri le impostazioni dell\'ora';

  @override
  String get dataSyncFailedTitle => 'Sincronizzazione non riuscita';

  @override
  String get dataSyncFailedMessage =>
      'Qualcosa è andato storto durante la sincronizzazione. Le tue parole sono al sicuro su questo telefono.';

  @override
  String get accountConflictTitle => 'Cambiare account?';

  @override
  String accountConflictMessage(String previous, String next) {
    return 'Su questo telefono avevi effettuato l\'accesso come $previous. Le modifiche non ancora caricate appartengono a quell\'account. Andranno perse se passi a $next.';
  }

  @override
  String accountConflictKeepButton(String previous) {
    return 'Usa invece $previous';
  }

  @override
  String accountConflictSwitchButton(String previous, String next) {
    return 'Elimina i dati di $previous e usa $next';
  }

  @override
  String get accountConflictUnknownAccount => 'un account sconosciuto';

  @override
  String get settingsSignInAgainButton => 'Accedi di nuovo';

  @override
  String loadingProgressLabel(int current, int total) {
    return '$current / $total';
  }

  @override
  String get errorClockWrong =>
      'L\'orologio del telefono non è corretto. Attiva data e ora automatiche, poi riprova.';

  @override
  String get homeAllDoneMessage => 'Tutto fatto per ora';

  @override
  String get homeStatusFirstWordMessage =>
      'Hai aggiunto la tua prima parola! Aggiungine altre e tocca «Esercitati»! :)';

  @override
  String get homeStatusEmptyMessage => 'Perché non aggiungi qualche parola nuova? :)';

  @override
  String get homeStatusOnlyOneWordMessage =>
      'La tua raccolta contiene una sola parola. Si sente sola. Aggiungine altre! :)';

  @override
  String homeStatusAddedTodayMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wow, oggi hai già aggiunto $count parole. Continua così!',
      one: 'Wow, oggi hai già aggiunto $count parola. Continua così!',
    );
    return '$_temp0';
  }

  @override
  String homeStatusManyWordsMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Accidenti, hai aggiunto $count parole in totale. Niente male!',
      one: 'Accidenti, hai aggiunto $count parola in totale. Niente male!',
    );
    return '$_temp0';
  }

  @override
  String homeStatusDefaultMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'La tua raccolta contiene $count parole.',
      one: 'La tua raccolta contiene $count parola.',
    );
    return '$_temp0';
  }

  @override
  String homeNextDueTodayMessage(String time) {
    return 'Prossima parola alle $time';
  }

  @override
  String homeNextDueLaterMessage(String date) {
    return 'Prossima parola: $date';
  }

  @override
  String get vocabularySpeakTooltip => 'Leggi ad alta voce';

  @override
  String get vocabularySearchTooltip => 'Cerca';

  @override
  String get vocabularySearchHint => 'Cerca vocaboli...';

  @override
  String get vocabularySearchClearTooltip => 'Cancella';

  @override
  String get vocabularySearchEmptyMessage => 'Nessun vocabolo corrisponde alla tua ricerca.';

  @override
  String get vocabularyFilterDueLabel => 'Da ripassare';

  @override
  String get vocabularyLevelNovice => 'Nuovi';

  @override
  String get vocabularyLevelBeginner => 'Principiante';

  @override
  String get vocabularyLevelAdvanced => 'Avanzato';

  @override
  String get vocabularyLevelExpert => 'Esperto';

  @override
  String get errorTextToSpeechUnavailable =>
      'Su questo telefono non è installata nessuna voce per questa lingua.';

  @override
  String get detailsRetakeImageButton => 'Scatta di nuovo';

  @override
  String errorTranslationQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Hai usato le tue $limit traduzioni delle ultime 24 ore. Scrivi tu la traduzione o riprova più tardi.',
      one:
          'Hai usato la tua $limit traduzione delle ultime 24 ore. Scrivi tu la traduzione o riprova più tardi.',
    );
    return '$_temp0';
  }

  @override
  String errorStockImageQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Hai usato le tue $limit ricerche di foto delle ultime 24 ore. Scatta una foto tu o riprova più tardi.',
      one:
          'Hai usato la tua $limit ricerca di foto delle ultime 24 ore. Scatta una foto tu o riprova più tardi.',
    );
    return '$_temp0';
  }

  @override
  String get errorServiceUnavailable =>
      'I suggerimenti automatici non sono disponibili al momento.';

  @override
  String get collectionsDeleteButton => 'Elimina raccolta';

  @override
  String get collectionsDeleteTitle => 'Eliminare la raccolta?';

  @override
  String get collectionsDeleteMessage => 'Le parole restano. Viene eliminata solo la raccolta.';

  @override
  String get scanTypeHint => 'Scrivi una parola...';

  @override
  String get scanOpenSettingsButton => 'Apri le impostazioni';

  @override
  String get errorCameraPermission => 'Consenti l\'accesso alla fotocamera per scattare foto.';

  @override
  String get errorCameraUnavailable => 'Al momento non è possibile usare la fotocamera.';

  @override
  String errorImageLabelingQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Hai usato le tue $limit scansioni delle ultime 24 ore. Scrivi tu la parola o riprova più tardi.',
      one:
          'Hai usato la tua $limit scansione delle ultime 24 ore. Scrivi tu la parola o riprova più tardi.',
    );
    return '$_temp0';
  }

  @override
  String errorImageLabelingMonthlyQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Hai usato le tue $limit scansioni di questo mese. Scrivi tu la parola o riprova il mese prossimo.',
      one:
          'Hai usato la tua $limit scansione di questo mese. Scrivi tu la parola o riprova il mese prossimo.',
    );
    return '$_temp0';
  }

  @override
  String errorQuotaSignInForMore(String message) {
    return '$message Accedi con Google per averne di più.';
  }

  @override
  String get connectToInternet => 'Connettiti a Internet';

  @override
  String get scanOfflineMessage =>
      'Per i suggerimenti serve una connessione a Internet. Puoi anche scrivere tu la parola.';

  @override
  String get detailsOfflineMessage =>
      'Per la traduzione e la ricerca di foto serve una connessione a Internet.';

  @override
  String get welcomeOfflineMessage => 'Per accedere con Google serve una connessione a Internet.';

  @override
  String get settingsSignInOfflineMessage => 'Per accedere serve una connessione a Internet.';

  @override
  String get settingsPracticeReminderTitle => 'Promemoria per esercitarti';

  @override
  String get settingsPracticeReminderHint => 'Solo nei giorni con parole da ripassare';

  @override
  String get settingsReminderTimeTitle => 'Ora';

  @override
  String get settingsNotificationsBlockedMessage =>
      'Le notifiche sono disattivate per Vocabualize.';

  @override
  String get settingsOpenNotificationSettingsButton => 'Apri le impostazioni';

  @override
  String get reminderPracticeTitle => 'È ora di esercitarti';

  @override
  String get reminderPracticeBody =>
      'Le tue parole ti aspettano. Bastano pochi minuti per tenerle fresche.';

  @override
  String get reminderPracticeChannel => 'Promemoria per esercitarti';

  @override
  String get errorReportLimit => 'Di recente hai inviato diverse segnalazioni. Riprova più tardi.';

  @override
  String get errorReportUnavailable =>
      'Al momento non è possibile inviare segnalazioni. Riprova più tardi.';

  @override
  String get reportFeedbackTitle => 'Feedback e bug';

  @override
  String get reportFeedbackMessage =>
      'Raccontaci cosa ti piace, cosa manca o cosa non ha funzionato.';

  @override
  String get reportFeedbackFieldHint => 'Il tuo messaggio...';

  @override
  String get reportFeedbackContextHint =>
      'Inviati insieme: versione dell\'app, versione di Android, lingua dell\'app e la tua coppia di lingue.';

  @override
  String get reportSendButton => 'Invia';

  @override
  String get reportFeedbackSentMessage => 'Grazie! Il tuo messaggio è stato inviato.';

  @override
  String get reportTranslationSentMessage => 'Grazie! La traduzione è stata segnalata.';

  @override
  String get reportOfflineMessage => 'Per inviare serve una connessione a Internet.';

  @override
  String get settingsDeleteAccountButton => 'Elimina account';

  @override
  String get settingsDeleteDataButton => 'Elimina tutti i dati';

  @override
  String get settingsDeleteAccountTitle => 'Eliminare l\'account?';

  @override
  String get settingsDeleteAccountMessage =>
      'Il tuo account e tutto ciò che contiene verranno eliminati definitivamente su tutti i tuoi dispositivi: parole, foto, raccolte e progressi. L\'operazione non può essere annullata.';

  @override
  String get settingsDeleteDataTitle => 'Eliminare tutti i dati?';

  @override
  String get settingsDeleteDataMessage =>
      'Tutte le parole, le foto, le raccolte e i progressi su questo telefono verranno eliminati definitivamente. L\'operazione non può essere annullata.';

  @override
  String get settingsDeleteConfirmWord => 'ELIMINA';

  @override
  String settingsDeleteConfirmHint(String word) {
    return 'Scrivi $word per confermare';
  }

  @override
  String get settingsDeleteConfirmButton => 'Elimina';

  @override
  String get settingsDeleteAccountOfflineMessage =>
      'Per eliminare l\'account serve una connessione a Internet.';

  @override
  String streakTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni di fila',
      one: '$count giorno di fila',
      zero: 'Ancora nessuna serie',
    );
    return '$_temp0';
  }

  @override
  String get streakStartMessage => 'Esercitati o aggiungi una parola per iniziare una serie.';

  @override
  String get streakDoneMessage => 'Per oggi hai finito. A domani!';

  @override
  String get streakPendingMessage =>
      'Esercitati o aggiungi una parola oggi per mantenere la serie.';

  @override
  String get streakLongestLabel => 'Serie più lunga';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni',
      one: '$count giorno',
    );
    return '$_temp0';
  }

  @override
  String get streakFreezesLabel => 'Protezioni serie';

  @override
  String streakFreezesValue(int count, int max) {
    return '$count su $max';
  }

  @override
  String streakFreezeExplanation(int days, int max) {
    return 'Ogni $days giorni attivi di fila ottieni una protezione (max. $max). Una protezione salva la tua serie in un giorno che salti.';
  }

  @override
  String get streakDayActive => 'Attivo';

  @override
  String get streakDayFrozen => 'Salvato da una protezione';

  @override
  String get streakDayPending => 'Ancora aperto';

  @override
  String get streakDayMissed => 'Saltato';

  @override
  String get settingsStreakReminderTitle => 'Promemoria della serie';

  @override
  String get settingsStreakReminderHint => 'Solo nei giorni in cui la tua serie è a rischio';

  @override
  String get reminderStreakChannel => 'Promemoria della serie';

  @override
  String get reminderStreakKeepTitle => 'Mantieni la tua serie';

  @override
  String reminderStreakKeepBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ripassa qualche parola oggi per mantenere la tua serie di $count giorni.',
      one: 'Ripassa qualche parola oggi per mantenere la tua serie di $count giorno.',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakLookAroundTitle => 'Guardati intorno';

  @override
  String get reminderStreakLookAroundBody =>
      'Vedi qualcosa che non sai ancora come si chiama? Aggiungilo come nuova parola.';

  @override
  String get reminderStreakQuickRoundTitle => 'Un giro veloce?';

  @override
  String reminderStreakQuickRoundBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Un breve ripasso mantiene vivi i tuoi $count giorni.',
      one: 'Un breve ripasso mantiene viva la tua serie.',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakNearbyTitle => 'Una nuova parola qui vicino?';

  @override
  String get reminderStreakNearbyBody => 'Scegli una cosa intorno a te e impara come si chiama.';

  @override
  String reminderStreakInARowTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni di fila',
      one: '$count giorno di fila',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakInARowBody => 'Non fermarti ora. Esercitati o aggiungi una parola oggi.';

  @override
  String get settingsPrivacyPolicyButton => 'Informativa sulla privacy';

  @override
  String get scanReportSuggestionButton => 'Segnala un suggerimento';
}
