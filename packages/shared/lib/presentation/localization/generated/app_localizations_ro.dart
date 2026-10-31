// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appTitle => 'Vocabualize';

  @override
  String get cancel => 'Anulați';

  @override
  String get close => 'Închideți';

  @override
  String get back => 'Înapoi';

  @override
  String get tryAgain => 'Încercați din nou';

  @override
  String get error => 'Eroare';

  @override
  String get errorConnection =>
      'Serverul nu poate fi accesat. Verificați conexiunea la internet și încercați din nou.';

  @override
  String errorApi(String message) {
    return 'Eroare la comunicarea cu serverul: $message.';
  }

  @override
  String get errorAuth => 'Nu v-ați conectat.';

  @override
  String get errorValidation => 'Datele primite nu sunt valide.';

  @override
  String get errorNotFound => 'Nu a fost găsit.';

  @override
  String get errorUnexpected => 'A apărut o eroare neașteptată.';

  @override
  String get unknown => 'necunoscut';

  @override
  String get no => 'Nu';

  @override
  String get yes => 'Da';

  @override
  String get okay => 'OK';

  @override
  String get submit => 'Trimiteți';

  @override
  String get delete => 'Ștergeți';

  @override
  String get edit => 'Editați';

  @override
  String get vocabularyDeleteTitle => 'Ștergeți?';

  @override
  String get vocabularyDeleteMessage => 'Sigur doriți să ștergeți acest cuvânt?';

  @override
  String get vocabularyCreatedLabel => 'Creat:';

  @override
  String get vocabularyReappearsLabel => 'Următoarea repetare:';

  @override
  String get vocabularyReappearsNow => 'Acum';

  @override
  String get vocabularyReappearsLessThanMinute => 'În mai puțin de un minut';

  @override
  String get notificationPracticeChannelName => 'Exersarea vocabularului';

  @override
  String get notificationPracticeChannelDescription => 'Hai să exersăm 🎯';

  @override
  String get notificationPracticeTitle => 'Hai să exersăm 🎯';

  @override
  String get notificationPracticeBody => 'Unele cuvinte așteaptă să fie repetate. Veți reuși! :D';

  @override
  String get welcomeStartButton => 'Să începem!';

  @override
  String get welcomeGoogleSignInButton => 'Conectați-vă cu Google';

  @override
  String get welcomeContinueWithoutAccountButton => 'Continuați fără cont';

  @override
  String get welcomeSignInFailedTitle => 'Conectarea a eșuat';

  @override
  String get homeCollectionsTitle => 'Colecții';

  @override
  String get homeAddFirstWordMessage => 'Atingeți butonul\npentru a adăuga primul cuvânt';

  @override
  String get homeAllWordsTitle => 'Toate cuvintele';

  @override
  String get homeNewWordsTitle => 'Adăugate recent';

  @override
  String get homePracticeButton => 'Exersați';

  @override
  String get homeScanButton => 'Scanați';

  @override
  String get homeWriteButton => 'Scrieți';

  @override
  String get homeWriteHint => 'Introduceți un cuvânt...';

  @override
  String get detailsSourceLabel => 'Original';

  @override
  String get detailsTargetLabel => 'Traducere';

  @override
  String get detailsReportTranslationButton => 'Raportați o traducere greșită';

  @override
  String get detailsAddCollectionButton => 'Adăugați o colecție';

  @override
  String get detailsReplaceTitle => 'Înlocuiți?';

  @override
  String get detailsReplaceMessage => 'Doriți să traduceți din nou cuvântul și să-l înlocuiți?';

  @override
  String get detailsDuplicateTitle => 'Duplicat!';

  @override
  String get detailsDuplicateAddButton => 'Adăugați';

  @override
  String get detailsNoImageMessage => 'Alegeți o imagine\nsau salvați fără';

  @override
  String get detailsOpenGalleryButton => 'Deschideți galeria';

  @override
  String get detailsRemoveImageButton => 'Eliminați imaginea';

  @override
  String get detailsPexelsAttribution => 'Imagini oferite de Pexels.';

  @override
  String get detailsSaveButton => 'Salvați';

  @override
  String get detailsSaveWithoutImageButton => 'Salvați fără';

  @override
  String get detailsTakePictureButton => 'Faceți o fotografie';

  @override
  String get detailsCollectionNameHint => 'Fără titlu';

  @override
  String get detailsCollectionNameLabel => 'Numele colecției';

  @override
  String get practiceDoneTitle => 'Felicitări!';

  @override
  String get practiceDoneMessage => 'Ați exersat toate\ncuvintele programate.';

  @override
  String get practiceDoneButton => 'Gata';

  @override
  String get practiceForgotButton => 'Nu știam';

  @override
  String get practiceEasyButton => 'Ușor';

  @override
  String get practiceGoodButton => 'Bine';

  @override
  String get practiceHardButton => 'Greu';

  @override
  String get practiceSolutionButton => 'Soluție';

  @override
  String get practiceAnswerLabel => 'Răspunsul dvs.';

  @override
  String get scanAddButton => 'Adăugați';

  @override
  String get scanSuggestionsTitle => 'Sugestii';

  @override
  String get scanNoSuggestionsMessage =>
      'Nu a fost recunoscut niciun obiect. Încercați din nou mai târziu.';

  @override
  String get reportTranslationTitle => 'Traducere greșită';

  @override
  String get reportTranslationNoteHint => 'Notă (opțional)';

  @override
  String get settingsTitle => 'Setări';

  @override
  String get settingsSignInHint =>
      'Conectați-vă pentru a sincroniza datele pe toate dispozitivele.';

  @override
  String get settingsSignInButton => 'Conectați-vă';

  @override
  String get settingsTypeAnswerDisabledTitle => 'Dezactivați răspunsul scris';

  @override
  String get settingsTypeAnswerDisabledHint => 'Folosiți doar reamintirea cu autoevaluare';

  @override
  String get settingsStrictCorrectionTitle => 'Corectare strictă';

  @override
  String get settingsStrictCorrectionHint =>
      'Diacriticele și caracterele speciale trebuie scrise exact';

  @override
  String get settingsCollectionsTitle => 'Activați colecțiile';

  @override
  String get settingsCollectionsHint => 'Organizați cuvintele în colecții';

  @override
  String get settingsImagesHiddenTitle => 'Ascundeți imaginile';

  @override
  String get settingsImagesHiddenHint => 'Poate reduce calitatea învățării';

  @override
  String get settingsDefaultGatherTitle => 'Mod implicit de adăugare';

  @override
  String get settingsDefaultGatherHint =>
      'Butonul + pornește imediat, o apăsare lungă arată toate opțiunile';

  @override
  String get settingsDefaultGatherNone => 'Niciunul';

  @override
  String get settingsAppearanceTitle => 'Aspect';

  @override
  String get settingsAppearanceHint => 'Luminos, întunecat sau ca telefonul dumneavoastră';

  @override
  String get settingsAppearanceSystem => 'Sistem';

  @override
  String get settingsAppearanceLight => 'Luminos';

  @override
  String get settingsAppearanceDark => 'Întunecat';

  @override
  String vocabularyReappearsInMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Peste $count de minute',
      few: 'Peste $count minute',
      one: 'Peste $count minut',
    );
    return '$_temp0';
  }

  @override
  String vocabularyReappearsInHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Peste $count de ore',
      few: 'Peste $count ore',
      one: 'Peste $count oră',
    );
    return '$_temp0';
  }

  @override
  String vocabularyReappearsInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Peste $count de zile',
      few: 'Peste $count zile',
      one: 'Peste $count zi',
    );
    return '$_temp0';
  }

  @override
  String detailsDuplicateMessage(String word) {
    return 'Se pare că „$word” există deja în colecția dvs.\n\nÎl adăugați oricum?';
  }

  @override
  String vocabularyPhotoByLabel(String author) {
    return 'Fotografie de $author';
  }

  @override
  String get detailsReplaceButton => 'Înlocuiți';

  @override
  String get errorSyncPending => 'Ultimele modificări nu au fost încă încărcate.';

  @override
  String get settingsSignOutButton => 'Deconectați-vă';

  @override
  String get settingsSignOutBlockedTitle => 'Modificări neîncărcate';

  @override
  String get settingsSignOutBlockedMessage =>
      'Unele modificări nu au ajuns încă pe server. Conectați-vă la internet și încercați din nou. Dacă vă deconectați oricum, aceste modificări se pierd.';

  @override
  String get settingsSignOutAnywayButton => 'Deconectați-vă oricum';

  @override
  String get syncStatusConnecting => 'Se conectează…';

  @override
  String get syncStatusSyncing => 'Se sincronizează…';

  @override
  String get syncStatusSynced => 'Toate modificările sunt sincronizate';

  @override
  String get syncStatusOffline => 'Offline. Modificările se sincronizează când reveniți online.';

  @override
  String get syncStatusUpdateRequired => 'Actualizați aplicația pentru a continua sincronizarea.';

  @override
  String get syncStatusSignInRequired =>
      'Sesiunea a expirat. Conectați-vă din nou pentru a continua sincronizarea.';

  @override
  String get gateUpdateTitle => 'Actualizare necesară';

  @override
  String get gateUpdateMessage =>
      'Această versiune de Vocabualize nu mai este acceptată. Actualizați aplicația pentru a continua să învățați.';

  @override
  String get gateUpdateButton => 'Actualizați';

  @override
  String get gateMaintenanceTitle => 'Lucrări de întreținere';

  @override
  String get gateMaintenanceMessage => 'Vocabualize se actualizează. Încercați din nou mai târziu.';

  @override
  String get settingsExportBackupButton => 'Exportați backupul';

  @override
  String get settingsExportBackupHint => 'Salvați toate cuvintele și imaginile într-un fișier';

  @override
  String get settingsImportBackupButton => 'Importați un backup';

  @override
  String get settingsImportBackupHint => 'Adăugați cuvintele dintr-un fișier de backup';

  @override
  String get settingsImportBackupConfirmTitle => 'Importați backupul?';

  @override
  String get settingsImportBackupConfirmMessage =>
      'Toate cuvintele, colecțiile și imaginile din backup vor fi adăugate în colecția dvs. Cuvintele existente rămân neschimbate.';

  @override
  String get settingsImportBackupConfirmButton => 'Importați';

  @override
  String settingsImportBackupDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Au fost importate $count de cuvinte.',
      few: 'Au fost importate $count cuvinte.',
      one: 'A fost importat $count cuvânt.',
    );
    return '$_temp0';
  }

  @override
  String get errorInvalidBackup => 'Acest fișier nu este un backup Vocabualize.';

  @override
  String get languageEnglishUk => 'Engleză (Regatul Unit)';

  @override
  String get languageEnglishUs => 'Engleză (SUA)';

  @override
  String get languageSpanishSpain => 'Spaniolă (Spania)';

  @override
  String get languageSpanishLatinAmerica => 'Spaniolă (America Latină)';

  @override
  String get languageFrenchFrance => 'Franceză (Franța)';

  @override
  String get languageFrenchCanada => 'Franceză (Canada)';

  @override
  String get languageGermanGermany => 'Germană (Germania)';

  @override
  String get languageGermanSwitzerland => 'Germană (Elveția)';

  @override
  String get languagePolish => 'Poloneză';

  @override
  String get languageItalian => 'Italiană';

  @override
  String get languageGreek => 'Greacă';

  @override
  String get languageRomanian => 'Română';

  @override
  String languagePairLabel(String source, String target) {
    return '$source → $target';
  }

  @override
  String get dataOfflineTitle => 'Sunteți offline';

  @override
  String get dataOfflineMessage => 'Cuvintele se vor descărca imediat ce vă conectați.';

  @override
  String get dataRetryButton => 'Încercați din nou';

  @override
  String get dataSignInRequiredTitle => 'Conectați-vă din nou';

  @override
  String get dataSignInRequiredMessage =>
      'Sesiunea a expirat. Conectați-vă pentru a încărca cuvintele.';

  @override
  String get dataSignInButton => 'Conectați-vă';

  @override
  String get syncStatusServerUnreachable =>
      'Serverul nu poate fi accesat. Modificările se sincronizează imediat ce revine.';

  @override
  String get syncStatusClockWrong =>
      'Ceasul telefonului nu este corect. Activați ora automată pentru a continua sincronizarea.';

  @override
  String get syncStatusFailed =>
      'Sincronizarea a eșuat. Cuvintele dvs. sunt în siguranță pe acest telefon.';

  @override
  String get dataServerUnreachableTitle => 'Serverul nu poate fi accesat';

  @override
  String get dataServerUnreachableMessage =>
      'Serverul Vocabualize nu poate fi accesat acum. Cuvintele dvs. sunt în siguranță pe acest telefon.';

  @override
  String get gateClockWrongTitle => 'Ceasul telefonului nu este corect';

  @override
  String get gateClockWrongMessage =>
      'Sincronizarea are nevoie de ora corectă. Activați data și ora automate, apoi reveniți.';

  @override
  String get gateOpenTimeSettingsButton => 'Deschideți setările de oră';

  @override
  String get dataSyncFailedTitle => 'Sincronizarea a eșuat';

  @override
  String get dataSyncFailedMessage =>
      'Ceva nu a mers bine la sincronizare. Cuvintele dvs. sunt în siguranță pe acest telefon.';

  @override
  String get accountConflictTitle => 'Schimbați contul?';

  @override
  String accountConflictMessage(String previous, String next) {
    return 'Pe acest telefon v-ați conectat cu $previous. Modificările care nu au fost încă încărcate aparțin acelui cont. Ele se pierd dacă treceți la $next.';
  }

  @override
  String accountConflictKeepButton(String previous) {
    return 'Folosiți în schimb $previous';
  }

  @override
  String accountConflictSwitchButton(String previous, String next) {
    return 'Ștergeți datele pentru $previous și folosiți $next';
  }

  @override
  String get accountConflictUnknownAccount => 'un cont necunoscut';

  @override
  String get settingsSignInAgainButton => 'Conectați-vă din nou';

  @override
  String loadingProgressLabel(int current, int total) {
    return '$current / $total';
  }

  @override
  String get errorClockWrong =>
      'Ceasul telefonului nu este corect. Activați data și ora automate, apoi încercați din nou.';

  @override
  String get homeAllDoneMessage => 'Totul e gata deocamdată';

  @override
  String get homeStatusFirstWordMessage =>
      'Ați adăugat primul cuvânt! Mai adăugați câteva și apăsați „Exersați”! :)';

  @override
  String get homeStatusEmptyMessage => 'De ce nu adăugați câteva cuvinte noi? :)';

  @override
  String get homeStatusOnlyOneWordMessage =>
      'Colecția dvs. conține un singur cuvânt. Se simte singur. Mai adăugați câteva! :)';

  @override
  String homeStatusAddedTodayMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Uau, ați adăugat deja $count de cuvinte azi. Continuați tot așa!',
      few: 'Uau, ați adăugat deja $count cuvinte azi. Continuați tot așa!',
      one: 'Uau, ați adăugat deja $count cuvânt azi. Continuați tot așa!',
    );
    return '$_temp0';
  }

  @override
  String homeStatusManyWordsMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Impresionant, ați adăugat $count de cuvinte în total. Nu-i rău deloc!',
      few: 'Impresionant, ați adăugat $count cuvinte în total. Nu-i rău deloc!',
      one: 'Impresionant, ați adăugat $count cuvânt în total. Nu-i rău deloc!',
    );
    return '$_temp0';
  }

  @override
  String homeStatusDefaultMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Colecția dvs. conține $count de cuvinte.',
      few: 'Colecția dvs. conține $count cuvinte.',
      one: 'Colecția dvs. conține $count cuvânt.',
    );
    return '$_temp0';
  }

  @override
  String homeNextDueTodayMessage(String time) {
    return 'Următorul cuvânt la $time';
  }

  @override
  String homeNextDueLaterMessage(String date) {
    return 'Următorul cuvânt: $date';
  }

  @override
  String get vocabularySpeakTooltip => 'Citiți cu voce tare';

  @override
  String get vocabularyTranslationPendingLabel => 'Traducere în curs';

  @override
  String get vocabularySearchTooltip => 'Căutați';

  @override
  String get vocabularySearchHint => 'Căutați cuvinte...';

  @override
  String get vocabularySearchClearTooltip => 'Ștergeți';

  @override
  String get vocabularySearchEmptyMessage => 'Niciun cuvânt nu corespunde căutării dumneavoastră.';

  @override
  String get vocabularyFilterDueLabel => 'De repetat';

  @override
  String get vocabularyLevelNovice => 'Noi';

  @override
  String get vocabularyLevelBeginner => 'Începător';

  @override
  String get vocabularyLevelAdvanced => 'Avansat';

  @override
  String get vocabularyLevelExpert => 'Expert';

  @override
  String get errorTextToSpeechUnavailable =>
      'Pe acest telefon nu este instalată nicio voce pentru această limbă.';

  @override
  String get detailsRetakeImageButton => 'Refaceți fotografia';

  @override
  String errorTranslationQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Ați folosit cele $limit de traduceri din ultimele 24 de ore. Introduceți traducerea manual sau încercați din nou mai târziu.',
      few:
          'Ați folosit cele $limit traduceri din ultimele 24 de ore. Introduceți traducerea manual sau încercați din nou mai târziu.',
      one:
          'Ați folosit $limit traducere din ultimele 24 de ore. Introduceți traducerea manual sau încercați din nou mai târziu.',
    );
    return '$_temp0';
  }

  @override
  String errorStockImageQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Ați folosit cele $limit de căutări de fotografii din ultimele 24 de ore. Faceți propria fotografie sau încercați din nou mai târziu.',
      few:
          'Ați folosit cele $limit căutări de fotografii din ultimele 24 de ore. Faceți propria fotografie sau încercați din nou mai târziu.',
      one:
          'Ați folosit $limit căutare de fotografii din ultimele 24 de ore. Faceți propria fotografie sau încercați din nou mai târziu.',
    );
    return '$_temp0';
  }

  @override
  String get errorServiceUnavailable => 'Sugestiile automate nu sunt disponibile momentan.';

  @override
  String get collectionsDeleteButton => 'Ștergeți colecția';

  @override
  String get collectionsDeleteTitle => 'Ștergeți colecția?';

  @override
  String get collectionsDeleteMessage => 'Cuvintele rămân. Doar colecția este ștearsă.';

  @override
  String get scanTypeHint => 'Introduceți un cuvânt...';

  @override
  String get scanOpenSettingsButton => 'Deschideți setările';

  @override
  String get errorCameraPermission => 'Permiteți accesul la cameră pentru a face fotografii.';

  @override
  String get errorCameraUnavailable => 'Camera nu poate fi folosită momentan.';

  @override
  String errorImageLabelingQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Ați folosit cele $limit de scanări din ultimele 24 de ore. Introduceți cuvântul manual sau încercați din nou mai târziu.',
      few:
          'Ați folosit cele $limit scanări din ultimele 24 de ore. Introduceți cuvântul manual sau încercați din nou mai târziu.',
      one:
          'Ați folosit $limit scanare din ultimele 24 de ore. Introduceți cuvântul manual sau încercați din nou mai târziu.',
    );
    return '$_temp0';
  }

  @override
  String errorImageLabelingMonthlyQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Ați folosit cele $limit de scanări din această lună. Introduceți cuvântul manual sau încercați din nou luna viitoare.',
      few:
          'Ați folosit cele $limit scanări din această lună. Introduceți cuvântul manual sau încercați din nou luna viitoare.',
      one:
          'Ați folosit $limit scanare în această lună. Introduceți cuvântul manual sau încercați din nou luna viitoare.',
    );
    return '$_temp0';
  }

  @override
  String errorQuotaSignInForMore(String message) {
    return '$message Conectați-vă cu Google pentru mai multe.';
  }

  @override
  String get connectToInternet => 'Conectați-vă la internet';

  @override
  String get scanOfflineMessage =>
      'Sugestiile necesită o conexiune la internet. Puteți introduce și manual cuvântul.';

  @override
  String get detailsOfflineMessage =>
      'Traducerea și căutarea de fotografii necesită o conexiune la internet.';

  @override
  String get welcomeOfflineMessage => 'Conectarea cu Google necesită o conexiune la internet.';

  @override
  String get settingsSignInOfflineMessage => 'Conectarea necesită o conexiune la internet.';

  @override
  String get settingsPracticeReminderTitle => 'Memento pentru exersare';

  @override
  String get settingsPracticeReminderHint => 'Doar în zilele cu cuvinte de exersat';

  @override
  String get settingsReminderTimeTitle => 'Ora';

  @override
  String get settingsNotificationsBlockedMessage =>
      'Notificările sunt dezactivate pentru Vocabualize.';

  @override
  String get settingsOpenNotificationSettingsButton => 'Deschideți setările';

  @override
  String get reminderPracticeTitle => 'E timpul să exersați';

  @override
  String get reminderPracticeBody => 'Cuvintele vă așteaptă. Câteva minute le păstrează proaspete.';

  @override
  String get reminderPracticeChannel => 'Mementouri pentru exersare';

  @override
  String get errorReportLimit =>
      'Ați trimis mai multe raportări recent. Încercați din nou mai târziu.';

  @override
  String get errorReportUnavailable =>
      'Raportările nu pot fi trimise momentan. Încercați din nou mai târziu.';

  @override
  String get reportFeedbackTitle => 'Feedback și erori';

  @override
  String get reportFeedbackMessage => 'Spuneți-ne ce vă place, ce lipsește sau ce nu a mers bine.';

  @override
  String get reportFeedbackFieldHint => 'Scrieți mesajul...';

  @override
  String get reportFeedbackContextHint =>
      'Se trimit și: versiunea aplicației, versiunea Android, limba aplicației și perechea dvs. de limbi.';

  @override
  String get reportSendButton => 'Trimiteți';

  @override
  String get reportFeedbackSentMessage => 'Mulțumim! Mesajul dvs. a fost trimis.';

  @override
  String get reportTranslationSentMessage => 'Mulțumim! Traducerea a fost raportată.';

  @override
  String get reportOfflineMessage => 'Trimiterea necesită o conexiune la internet.';

  @override
  String get settingsDeleteAccountButton => 'Ștergeți contul';

  @override
  String get settingsDeleteDataButton => 'Ștergeți toate datele';

  @override
  String get settingsDeleteAccountTitle => 'Ștergeți contul?';

  @override
  String get settingsDeleteAccountMessage =>
      'Contul dvs. și tot ce conține vor fi șterse definitiv de pe toate dispozitivele: cuvinte, fotografii, colecții și progres. Acțiunea nu poate fi anulată.';

  @override
  String get settingsDeleteDataTitle => 'Ștergeți toate datele?';

  @override
  String get settingsDeleteDataMessage =>
      'Toate cuvintele, fotografiile, colecțiile și progresul de pe acest telefon vor fi șterse definitiv. Acțiunea nu poate fi anulată.';

  @override
  String get settingsDeleteConfirmWord => 'ȘTERGE';

  @override
  String settingsDeleteConfirmHint(String word) {
    return 'Introduceți $word pentru a confirma';
  }

  @override
  String get settingsDeleteConfirmButton => 'Ștergeți';

  @override
  String get settingsDeleteAccountOfflineMessage =>
      'Ștergerea contului necesită o conexiune la internet.';

  @override
  String streakTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de zile la rând',
      few: '$count zile la rând',
      one: '$count zi la rând',
      zero: 'Nicio serie încă',
    );
    return '$_temp0';
  }

  @override
  String get streakStartMessage => 'Exersați sau adăugați un cuvânt pentru a începe o serie.';

  @override
  String get streakDoneMessage => 'Ați terminat pe azi. Pe mâine!';

  @override
  String get streakPendingMessage =>
      'Exersați sau adăugați un cuvânt azi pentru a vă păstra seria.';

  @override
  String get streakLongestLabel => 'Cea mai lungă serie';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de zile',
      few: '$count zile',
      one: '$count zi',
    );
    return '$_temp0';
  }

  @override
  String get streakFreezesLabel => 'Protecții';

  @override
  String streakFreezesValue(int count, int max) {
    return '$count din $max';
  }

  @override
  String streakFreezeExplanation(int days, int max) {
    return 'La fiecare $days zile active la rând primiți o protecție (max. $max). O protecție vă salvează seria într-o zi ratată.';
  }

  @override
  String get streakDayActive => 'Activă';

  @override
  String get streakDayFrozen => 'Salvată de o protecție';

  @override
  String get streakDayPending => 'Încă deschisă';

  @override
  String get streakDayMissed => 'Ratată';

  @override
  String get settingsStreakReminderTitle => 'Memento pentru serie';

  @override
  String get settingsStreakReminderHint => 'Doar în zilele în care seria dvs. este în pericol';

  @override
  String get reminderStreakChannel => 'Mementouri pentru serie';

  @override
  String get reminderStreakKeepTitle => 'Păstrați-vă seria';

  @override
  String reminderStreakKeepBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Exersați câteva cuvinte azi pentru a vă păstra seria de $count de zile.',
      few: 'Exersați câteva cuvinte azi pentru a vă păstra seria de $count zile.',
      one: 'Exersați câteva cuvinte azi pentru a vă păstra seria de $count zi.',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakLookAroundTitle => 'Priviți în jur';

  @override
  String get reminderStreakLookAroundBody =>
      'Vedeți ceva ce nu știți încă să numiți? Adăugați-l ca un cuvânt nou.';

  @override
  String get reminderStreakQuickRoundTitle => 'O rundă rapidă?';

  @override
  String reminderStreakQuickRoundBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'O rundă scurtă de exersare vă menține cele $count de zile.',
      few: 'O rundă scurtă de exersare vă menține cele $count zile.',
      one: 'O rundă scurtă de exersare vă menține seria.',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakNearbyTitle => 'Un cuvânt nou prin apropiere?';

  @override
  String get reminderStreakNearbyBody =>
      'Alegeți un lucru din jurul dvs. și aflați cum se numește.';

  @override
  String reminderStreakInARowTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de zile la rând',
      few: '$count zile la rând',
      one: '$count zi la rând',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakInARowBody => 'Nu vă opriți acum. Exersați sau adăugați un cuvânt azi.';

  @override
  String get settingsPrivacyPolicyButton => 'Politica de confidențialitate';

  @override
  String get scanReportSuggestionButton => 'Raportați o sugestie';

  @override
  String get languagesTitle => 'Limbile dvs.';

  @override
  String get languagesSpeakTitle => 'Vorbesc';

  @override
  String get languagesSpeakHint => 'O limbă pe care o cunoașteți bine';

  @override
  String get languagesLearnTitle => 'Învăț';

  @override
  String get languagesLearnHint => 'Alegeți una sau mai multe';

  @override
  String get languagesContinueButton => 'Continuați';

  @override
  String get languagesPausedTitle => 'În pauză';

  @override
  String get languagesChangeButton => 'Schimbați';

  @override
  String get languagesAddButton => 'Adăugați o limbă';

  @override
  String languagesWordCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de cuvinte',
      few: '$count cuvinte',
      one: '1 cuvânt',
    );
    return '$_temp0';
  }

  @override
  String get languagesPickTitle => 'Alegeți o limbă';

  @override
  String languagesMainClashTitle(String language) {
    return 'Vorbiți $language?';
  }

  @override
  String languagesMainClashMessage(String language) {
    return 'Învățați $language. Dacă o vorbiți, este pusă pe pauză. Progresul rămâne.';
  }

  @override
  String get languagesMainClashButton => 'Continuați';

  @override
  String get learnedLanguageAskMeInLabel => 'Întrebați-mă în';

  @override
  String get learnedLanguageAddAskMeInButton => 'Întrebați-mă în altă limbă';

  @override
  String learnedLanguageAskMeInHelpMessage(String askMeIn, String main, String learned) {
    return 'Cartonașele întreabă în $askMeIn în loc de $main, pentru cuvintele pe care le cunoașteți deja bine în $askMeIn. Puteți afișa oricând cuvântul în $main. Astfel, $askMeIn rămâne activă cât învățați $learned.';
  }

  @override
  String get learnedLanguageAskMeInHelpTooltip => 'Ce înseamnă asta?';

  @override
  String get learnedLanguageRemoveAskMeInTooltip => 'Eliminați';

  @override
  String learnedLanguageFromLevelLabel(String level) {
    return 'De la nivelul: $level';
  }

  @override
  String get learnedLanguageNewWordsTitle => 'Cuvinte noi pe exercițiu';

  @override
  String get learnedLanguageAllNewWords => 'Toate';

  @override
  String get learnedLanguageWordsTitle => 'Cuvinte';

  @override
  String learnedLanguageWordsCount(int count, int total) {
    return '$count din $total';
  }

  @override
  String get learnedLanguageChooseWordsButton => 'Alegeți cuvinte';

  @override
  String get learnedLanguagePauseButton => 'Puneți pe pauză';

  @override
  String get learnedLanguageResumeButton => 'Reluați';

  @override
  String get learnedLanguageLastActiveHint => 'Aveți nevoie de cel puțin o limbă de învățat.';

  @override
  String learnedLanguageDeleteTitle(String language) {
    return 'Ștergeți $language?';
  }

  @override
  String learnedLanguageDeleteMessage(String language) {
    return 'Progresul dvs. în $language este șters. Cuvintele rămân în celelalte limbi.';
  }

  @override
  String learnedLanguageResumeTitle(String language) {
    return 'Bine ați revenit la $language';
  }

  @override
  String get learnedLanguageResumeMessage =>
      'Continuați de unde ați rămas sau o luați de la capăt?';

  @override
  String get learnedLanguageStartOverButton => 'De la capăt';

  @override
  String languageWordsTitle(String language) {
    return 'Cuvinte în $language';
  }

  @override
  String languageWordsAddTitle(String language) {
    return 'Învățați și $language?';
  }

  @override
  String languageWordsAddQuestion(String language) {
    return 'Pe care dintre cuvintele dvs. vreți să le învățați în $language?';
  }

  @override
  String languageWordsAllOption(int count) {
    return 'Toate cuvintele ($count)';
  }

  @override
  String get languageWordsChooseOption => 'Alegeți colecții';

  @override
  String get languageWordsNoneOption => 'Niciunul, de la zero';

  @override
  String languageWordsLeftOutHint(String language) {
    return 'Cuvintele pe care le lăsați deoparte rămân în celelalte limbi. Le puteți adăuga oricând la $language.';
  }

  @override
  String get languageWordsUntaggedLabel => 'În nicio colecție';

  @override
  String languageWordsCount(int count) {
    return '($count)';
  }

  @override
  String languageWordsPartialCount(int count, int total) {
    return '($count din $total)';
  }

  @override
  String languageWordsStartButton(String language) {
    return 'Începeți $language';
  }

  @override
  String get languageWordsSaveButton => 'Salvați';

  @override
  String get languageWordsSummaryTitle => 'Salvați modificările?';

  @override
  String languageWordsSummaryAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Se adaugă $count de cuvinte.',
      few: 'Se adaugă $count cuvinte.',
      one: 'Se adaugă 1 cuvânt.',
      zero: 'Nu se adaugă niciun cuvânt.',
    );
    return '$_temp0';
  }

  @override
  String languageWordsSummaryRemoved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Se elimină $count de cuvinte.',
      few: 'Se elimină $count cuvinte.',
      one: 'Se elimină 1 cuvânt.',
      zero: 'Nu se elimină niciun cuvânt.',
    );
    return '$_temp0';
  }

  @override
  String get languageWordsSummaryRestartHint =>
      'Cuvintele eliminate o iau de la capăt dacă le adăugați din nou.';

  @override
  String languageWordsSummaryAlsoElsewhere(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dintre ele sunt și în alte colecții.',
      few: '$count dintre ele sunt și în alte colecții.',
      one: '1 dintre ele este și în altă colecție.',
    );
    return '$_temp0';
  }

  @override
  String languageWordsNoWordsHint(String language) {
    return 'Încă nu aveți cuvinte. Cuvintele pe care le adăugați le învățați și în $language.';
  }

  @override
  String get homeManageLanguagesButton => 'Gestionați limbile';

  @override
  String homeEmptyLanguageMessage(String language) {
    return 'Niciunul dintre cuvintele dvs. nu este încă în $language.';
  }

  @override
  String get homeChooseWordsButton => 'Alegeți cuvinte';

  @override
  String get homeLanguageButtonTooltip => 'Schimbați limba';

  @override
  String get settingsLanguagesTitle => 'Limbi';

  @override
  String learnedLanguageAskMeInAlwaysHelpMessage(String askMeIn, String main, String learned) {
    return 'Cartonașele întreabă în $askMeIn în loc de $main. Puteți afișa oricând cuvântul în $main. Astfel, $askMeIn rămâne activă cât învățați $learned.';
  }
}
