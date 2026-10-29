// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get appTitle => 'Vocabualize';

  @override
  String get cancel => 'Ακύρωση';

  @override
  String get close => 'Κλείσιμο';

  @override
  String get back => 'Πίσω';

  @override
  String get tryAgain => 'Δοκιμάστε ξανά';

  @override
  String get error => 'Σφάλμα';

  @override
  String get errorConnection =>
      'Δεν ήταν δυνατή η σύνδεση με τον διακομιστή. Ελέγξτε τη σύνδεσή σας στο διαδίκτυο και δοκιμάστε ξανά.';

  @override
  String errorApi(String message) {
    return 'Σφάλμα κατά την επικοινωνία με τον διακομιστή: $message.';
  }

  @override
  String get errorAuth => 'Δεν έχετε συνδεθεί.';

  @override
  String get errorValidation => 'Τα δεδομένα που λήφθηκαν δεν είναι έγκυρα.';

  @override
  String get errorNotFound => 'Δεν βρέθηκε.';

  @override
  String get errorUnexpected => 'Παρουσιάστηκε απρόσμενο σφάλμα.';

  @override
  String get unknown => 'άγνωστο';

  @override
  String get no => 'Όχι';

  @override
  String get yes => 'Ναι';

  @override
  String get okay => 'OK';

  @override
  String get submit => 'Υποβολή';

  @override
  String get delete => 'Διαγραφή';

  @override
  String get edit => 'Επεξεργασία';

  @override
  String get languagePickerTitle => 'Επιλογή γλώσσας';

  @override
  String get vocabularyDeleteTitle => 'Διαγραφή;';

  @override
  String get vocabularyDeleteMessage => 'Θέλετε σίγουρα να διαγράψετε αυτή τη λέξη;';

  @override
  String get vocabularyCreatedLabel => 'Δημιουργήθηκε:';

  @override
  String get vocabularyReappearsLabel => 'Επόμενη επανάληψη:';

  @override
  String get vocabularyReappearsNow => 'Τώρα';

  @override
  String get vocabularyReappearsLessThanMinute => 'Σε λιγότερο από ένα λεπτό';

  @override
  String get notificationPracticeChannelName => 'Εξάσκηση λεξιλογίου';

  @override
  String get notificationPracticeChannelDescription => 'Ώρα για εξάσκηση 🎯';

  @override
  String get notificationPracticeTitle => 'Ώρα για εξάσκηση 🎯';

  @override
  String get notificationPracticeBody =>
      'Κάποιες λέξεις περιμένουν επανάληψη. Θα τα πάτε τέλεια! :D';

  @override
  String get welcomeSourceLanguageTitle => 'Μιλάω';

  @override
  String get welcomeTargetLanguageTitle => 'Θέλω να μάθω';

  @override
  String get welcomeStartButton => 'Ας ξεκινήσουμε!';

  @override
  String get welcomeGoogleSignInButton => 'Σύνδεση με Google';

  @override
  String get welcomeContinueWithoutAccountButton => 'Συνέχεια χωρίς λογαριασμό';

  @override
  String get welcomeSignInFailedTitle => 'Η σύνδεση απέτυχε';

  @override
  String get homeCollectionsTitle => 'Συλλογές';

  @override
  String get homeAddFirstWordMessage => 'Πατήστε το κουμπί\nγια να προσθέσετε την πρώτη σας λέξη';

  @override
  String get homeAllWordsTitle => 'Όλες οι λέξεις';

  @override
  String get homeNewWordsTitle => 'Πρόσφατες προσθήκες';

  @override
  String get homePracticeButton => 'Εξάσκηση';

  @override
  String get homeScanButton => 'Σάρωση';

  @override
  String get homeWriteButton => 'Γράψιμο';

  @override
  String get homeWriteHint => 'Πληκτρολογήστε μια λέξη...';

  @override
  String get detailsSourceLabel => 'Πρωτότυπο';

  @override
  String get detailsTargetLabel => 'Μετάφραση';

  @override
  String get detailsReportTranslationButton => 'Αναφορά λανθασμένης μετάφρασης';

  @override
  String get detailsAddCollectionButton => 'Προσθήκη συλλογής';

  @override
  String get detailsReplaceTitle => 'Αντικατάσταση;';

  @override
  String get detailsReplaceMessage => 'Να μεταφραστεί ξανά η λέξη και να αντικατασταθεί;';

  @override
  String get detailsDuplicateTitle => 'Διπλότυπο!';

  @override
  String get detailsDuplicateAddButton => 'Προσθήκη';

  @override
  String get detailsNoImageMessage => 'Επιλέξτε μια εικόνα\nή αποθηκεύστε χωρίς';

  @override
  String get detailsOpenGalleryButton => 'Άνοιγμα γκαλερί';

  @override
  String get detailsRemoveImageButton => 'Αφαίρεση εικόνας';

  @override
  String get detailsPexelsAttribution => 'Εικόνες από το Pexels.';

  @override
  String get detailsSaveButton => 'Αποθήκευση';

  @override
  String get detailsSaveWithoutImageButton => 'Αποθήκευση χωρίς';

  @override
  String get detailsTakePictureButton => 'Λήψη φωτογραφίας';

  @override
  String get detailsCollectionNameHint => 'Χωρίς τίτλο';

  @override
  String get detailsCollectionNameLabel => 'Όνομα συλλογής';

  @override
  String get practiceDoneTitle => 'Συγχαρητήρια!';

  @override
  String get practiceDoneMessage => 'Κάνατε εξάσκηση σε όλες\nτις λέξεις που περίμεναν.';

  @override
  String get practiceDoneButton => 'Τέλος';

  @override
  String get practiceForgotButton => 'Δεν το ήξερα';

  @override
  String get practiceEasyButton => 'Εύκολο';

  @override
  String get practiceGoodButton => 'Καλό';

  @override
  String get practiceHardButton => 'Δύσκολο';

  @override
  String get practiceSolutionButton => 'Λύση';

  @override
  String get practiceAnswerLabel => 'Η απάντησή σας';

  @override
  String get scanAddButton => 'Προσθήκη';

  @override
  String get scanSuggestionsTitle => 'Προτάσεις';

  @override
  String get scanNoSuggestionsMessage => 'Δεν αναγνωρίστηκαν αντικείμενα. Δοκιμάστε ξανά αργότερα.';

  @override
  String get reportTranslationTitle => 'Λανθασμένη μετάφραση';

  @override
  String get reportTranslationNoteHint => 'Σημείωση (προαιρετικά)';

  @override
  String get settingsTitle => 'Ρυθμίσεις';

  @override
  String get settingsSignInHint =>
      'Συνδεθείτε για να συγχρονίζετε τα δεδομένα σας σε όλες τις συσκευές.';

  @override
  String get settingsSignInButton => 'Σύνδεση';

  @override
  String get settingsTypeAnswerDisabledTitle => 'Απενεργοποίηση γραπτής απάντησης';

  @override
  String get settingsTypeAnswerDisabledHint => 'Μόνο ανάκληση από μνήμης με αυτοαξιολόγηση';

  @override
  String get settingsStrictCorrectionTitle => 'Αυστηρή διόρθωση';

  @override
  String get settingsStrictCorrectionHint =>
      'Οι τόνοι και οι ειδικοί χαρακτήρες πρέπει να γράφονται ακριβώς';

  @override
  String get settingsCollectionsTitle => 'Ενεργοποίηση συλλογών';

  @override
  String get settingsCollectionsHint => 'Οργανώστε τις λέξεις σε συλλογές';

  @override
  String get settingsImagesHiddenTitle => 'Απόκρυψη εικόνων';

  @override
  String get settingsImagesHiddenHint => 'Μπορεί να μειώσει την ποιότητα της μάθησης';

  @override
  String get settingsAppearanceTitle => 'Εμφάνιση';

  @override
  String get settingsAppearanceHint => 'Φωτεινό, σκοτεινό ή όπως το τηλέφωνό σας';

  @override
  String get settingsAppearanceSystem => 'Σύστημα';

  @override
  String get settingsAppearanceLight => 'Φωτεινό';

  @override
  String get settingsAppearanceDark => 'Σκοτεινό';

  @override
  String get settingsSourceLanguageTitle => 'Η γλώσσα μου';

  @override
  String get settingsSourceLanguageHint => 'Μια γλώσσα που γνωρίζετε καλά';

  @override
  String get settingsTargetLanguageTitle => 'Γλώσσα που μαθαίνω';

  @override
  String get settingsTargetLanguageHint => 'Η γλώσσα που μαθαίνετε';

  @override
  String vocabularyReappearsInMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Σε $count λεπτά',
      one: 'Σε $count λεπτό',
    );
    return '$_temp0';
  }

  @override
  String vocabularyReappearsInHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Σε $count ώρες',
      one: 'Σε $count ώρα',
    );
    return '$_temp0';
  }

  @override
  String vocabularyReappearsInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Σε $count ημέρες',
      one: 'Σε $count ημέρα',
    );
    return '$_temp0';
  }

  @override
  String detailsDuplicateMessage(String word) {
    return 'Φαίνεται ότι η λέξη «$word» υπάρχει ήδη στη συλλογή σας.\n\nΝα προστεθεί παρ\' όλα αυτά;';
  }

  @override
  String detailsPhotoByLabel(String author) {
    return 'Φωτογραφία: $author';
  }

  @override
  String get detailsReplaceButton => 'Αντικατάσταση';

  @override
  String get errorSyncPending => 'Οι τελευταίες αλλαγές σας δεν έχουν μεταφορτωθεί ακόμη.';

  @override
  String get settingsSignOutButton => 'Αποσύνδεση';

  @override
  String get settingsSignOutBlockedTitle => 'Οι αλλαγές δεν μεταφορτώθηκαν';

  @override
  String get settingsSignOutBlockedMessage =>
      'Κάποιες αλλαγές δεν έχουν φτάσει ακόμη στον διακομιστή. Συνδεθείτε στο διαδίκτυο και δοκιμάστε ξανά. Αν αποσυνδεθείτε παρ\' όλα αυτά, οι αλλαγές αυτές θα χαθούν.';

  @override
  String get settingsSignOutAnywayButton => 'Αποσύνδεση παρ\' όλα αυτά';

  @override
  String get syncStatusConnecting => 'Σύνδεση…';

  @override
  String get syncStatusSyncing => 'Συγχρονισμός…';

  @override
  String get syncStatusSynced => 'Όλες οι αλλαγές συγχρονίστηκαν';

  @override
  String get syncStatusOffline =>
      'Εκτός σύνδεσης. Οι αλλαγές θα συγχρονιστούν μόλις συνδεθείτε ξανά.';

  @override
  String get syncStatusUpdateRequired =>
      'Ενημερώστε την εφαρμογή για να συνεχιστεί ο συγχρονισμός.';

  @override
  String get syncStatusSignInRequired =>
      'Η συνεδρία σας έληξε. Συνδεθείτε ξανά για να συνεχιστεί ο συγχρονισμός.';

  @override
  String get gateUpdateTitle => 'Απαιτείται ενημέρωση';

  @override
  String get gateUpdateMessage =>
      'Αυτή η έκδοση του Vocabualize δεν υποστηρίζεται πλέον. Ενημερώστε την εφαρμογή για να συνεχίσετε να μαθαίνετε.';

  @override
  String get gateUpdateButton => 'Ενημέρωση';

  @override
  String get gateMaintenanceTitle => 'Υπό συντήρηση';

  @override
  String get gateMaintenanceMessage => 'Το Vocabualize ενημερώνεται. Δοκιμάστε ξανά αργότερα.';

  @override
  String get settingsExportBackupButton => 'Εξαγωγή αντιγράφου ασφαλείας';

  @override
  String get settingsExportBackupHint => 'Αποθήκευση όλων των λέξεων και εικόνων σε αρχείο';

  @override
  String get settingsImportBackupButton => 'Εισαγωγή αντιγράφου ασφαλείας';

  @override
  String get settingsImportBackupHint => 'Προσθήκη των λέξεων από αρχείο αντιγράφου ασφαλείας';

  @override
  String get settingsImportBackupConfirmTitle => 'Εισαγωγή αντιγράφου ασφαλείας;';

  @override
  String get settingsImportBackupConfirmMessage =>
      'Όλες οι λέξεις, οι συλλογές και οι εικόνες του αντιγράφου θα προστεθούν στη συλλογή σας. Οι υπάρχουσες λέξεις σας μένουν ως έχουν.';

  @override
  String get settingsImportBackupConfirmButton => 'Εισαγωγή';

  @override
  String settingsImportBackupDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Εισήχθησαν $count λέξεις.',
      one: 'Εισήχθη $count λέξη.',
    );
    return '$_temp0';
  }

  @override
  String get errorInvalidBackup => 'Αυτό το αρχείο δεν είναι αντίγραφο ασφαλείας του Vocabualize.';

  @override
  String get languageEnglish => 'Αγγλικά';

  @override
  String get languageGerman => 'Γερμανικά';

  @override
  String get languageSpanish => 'Ισπανικά';

  @override
  String get languageFrench => 'Γαλλικά';

  @override
  String get languagePolish => 'Πολωνικά';

  @override
  String get languageItalian => 'Ιταλικά';

  @override
  String get languageGreek => 'Ελληνικά';

  @override
  String get languageRomanian => 'Ρουμανικά';

  @override
  String languagePairLabel(String source, String target) {
    return '$source → $target';
  }

  @override
  String get languageSelectionTitle => 'Οι γλώσσες σας';

  @override
  String get languageSelectionContinueButton => 'Συνέχεια';

  @override
  String get languageSelectionSaveButton => 'Αποθήκευση';

  @override
  String get dataOfflineTitle => 'Είστε εκτός σύνδεσης';

  @override
  String get dataOfflineMessage => 'Οι λέξεις σας θα ληφθούν μόλις συνδεθείτε.';

  @override
  String get dataRetryButton => 'Δοκιμάστε ξανά';

  @override
  String get dataSignInRequiredTitle => 'Συνδεθείτε ξανά';

  @override
  String get dataSignInRequiredMessage =>
      'Η συνεδρία σας έληξε. Συνδεθείτε για να φορτωθούν οι λέξεις σας.';

  @override
  String get dataSignInButton => 'Σύνδεση';

  @override
  String get syncStatusServerUnreachable =>
      'Ο διακομιστής δεν είναι προσβάσιμος. Οι αλλαγές θα συγχρονιστούν μόλις επανέλθει.';

  @override
  String get syncStatusClockWrong =>
      'Το ρολόι του τηλεφώνου σας δεν είναι σωστό. Ενεργοποιήστε την αυτόματη ώρα για να συνεχιστεί ο συγχρονισμός.';

  @override
  String get syncStatusFailed =>
      'Ο συγχρονισμός απέτυχε. Οι λέξεις σας είναι ασφαλείς σε αυτό το τηλέφωνο.';

  @override
  String get dataServerUnreachableTitle => 'Ο διακομιστής δεν είναι προσβάσιμος';

  @override
  String get dataServerUnreachableMessage =>
      'Ο διακομιστής του Vocabualize δεν είναι προσβάσιμος αυτή τη στιγμή. Οι λέξεις σας είναι ασφαλείς σε αυτό το τηλέφωνο.';

  @override
  String get gateClockWrongTitle => 'Το ρολόι του τηλεφώνου σας δεν είναι σωστό';

  @override
  String get gateClockWrongMessage =>
      'Ο συγχρονισμός χρειάζεται τη σωστή ώρα. Ενεργοποιήστε την αυτόματη ημερομηνία και ώρα και επιστρέψτε.';

  @override
  String get gateOpenTimeSettingsButton => 'Ρυθμίσεις ώρας';

  @override
  String get dataSyncFailedTitle => 'Ο συγχρονισμός απέτυχε';

  @override
  String get dataSyncFailedMessage =>
      'Κάτι πήγε στραβά κατά τον συγχρονισμό. Οι λέξεις σας είναι ασφαλείς σε αυτό το τηλέφωνο.';

  @override
  String get accountConflictTitle => 'Αλλαγή λογαριασμού;';

  @override
  String accountConflictMessage(String previous, String next) {
    return 'Σε αυτό το τηλέφωνο είχατε συνδεθεί ως $previous. Οι αλλαγές που δεν έχουν μεταφορτωθεί ακόμη ανήκουν σε αυτόν τον λογαριασμό. Θα χαθούν αν αλλάξετε σε $next.';
  }

  @override
  String accountConflictKeepButton(String previous) {
    return 'Συνέχεια με $previous';
  }

  @override
  String accountConflictSwitchButton(String previous, String next) {
    return 'Διαγραφή δεδομένων για $previous και συνέχεια με $next';
  }

  @override
  String get accountConflictUnknownAccount => 'άγνωστο λογαριασμό';

  @override
  String get settingsSignInAgainButton => 'Συνδεθείτε ξανά';

  @override
  String loadingProgressLabel(int current, int total) {
    return '$current / $total';
  }

  @override
  String get errorClockWrong =>
      'Το ρολόι του τηλεφώνου σας δεν είναι σωστό. Ενεργοποιήστε την αυτόματη ημερομηνία και ώρα και δοκιμάστε ξανά.';

  @override
  String get homeAllDoneMessage => 'Όλα έτοιμα για τώρα';

  @override
  String get homeStatusFirstWordMessage =>
      'Προσθέσατε την πρώτη σας λέξη! Προσθέστε κι άλλες και πατήστε «Εξάσκηση»! :)';

  @override
  String get homeStatusEmptyMessage => 'Γιατί δεν προσθέτετε μερικές νέες λέξεις; :)';

  @override
  String get homeStatusOnlyOneWordMessage =>
      'Η συλλογή σας έχει μόνο μία λέξη. Νιώθει μοναξιά. Προσθέστε κι άλλες! :)';

  @override
  String homeStatusAddedTodayMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ουάου, προσθέσατε ήδη $count λέξεις σήμερα. Συνεχίστε έτσι!',
      one: 'Ουάου, προσθέσατε ήδη $count λέξη σήμερα. Συνεχίστε έτσι!',
    );
    return '$_temp0';
  }

  @override
  String homeStatusManyWordsMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Απίστευτο, προσθέσατε συνολικά $count λέξεις. Καθόλου άσχημα!',
      one: 'Απίστευτο, προσθέσατε συνολικά $count λέξη. Καθόλου άσχημα!',
    );
    return '$_temp0';
  }

  @override
  String homeStatusDefaultMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Η συλλογή σας έχει $count λέξεις.',
      one: 'Η συλλογή σας έχει $count λέξη.',
    );
    return '$_temp0';
  }

  @override
  String homeNextDueTodayMessage(String time) {
    return 'Επόμενη λέξη στις $time';
  }

  @override
  String homeNextDueLaterMessage(String date) {
    return 'Επόμενη λέξη: $date';
  }

  @override
  String get vocabularySpeakTooltip => 'Ανάγνωση';

  @override
  String get vocabularySearchTooltip => 'Αναζήτηση';

  @override
  String get vocabularySearchHint => 'Αναζήτηση λέξεων...';

  @override
  String get vocabularySearchClearTooltip => 'Εκκαθάριση';

  @override
  String get vocabularySearchEmptyMessage => 'Καμία λέξη δεν ταιριάζει με την αναζήτησή σας.';

  @override
  String get vocabularyFilterDueLabel => 'Για επανάληψη';

  @override
  String get vocabularyLevelNovice => 'Νέες';

  @override
  String get vocabularyLevelBeginner => 'Αρχάριο';

  @override
  String get vocabularyLevelAdvanced => 'Προχωρημένο';

  @override
  String get vocabularyLevelExpert => 'Έμπειρο';

  @override
  String get errorTextToSpeechUnavailable =>
      'Δεν υπάρχει εγκατεστημένη φωνή για αυτή τη γλώσσα σε αυτό το τηλέφωνο.';

  @override
  String get detailsRetakeImageButton => 'Νέα λήψη';

  @override
  String errorTranslationQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Χρησιμοποιήσατε τις $limit μεταφράσεις των τελευταίων 24 ωρών. Γράψτε τη μετάφραση μόνοι σας ή δοκιμάστε ξανά αργότερα.',
      one:
          'Χρησιμοποιήσατε τη $limit μετάφραση των τελευταίων 24 ωρών. Γράψτε τη μετάφραση μόνοι σας ή δοκιμάστε ξανά αργότερα.',
    );
    return '$_temp0';
  }

  @override
  String errorStockImageQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Χρησιμοποιήσατε τις $limit αναζητήσεις φωτογραφιών των τελευταίων 24 ωρών. Τραβήξτε τη δική σας φωτογραφία ή δοκιμάστε ξανά αργότερα.',
      one:
          'Χρησιμοποιήσατε τη $limit αναζήτηση φωτογραφιών των τελευταίων 24 ωρών. Τραβήξτε τη δική σας φωτογραφία ή δοκιμάστε ξανά αργότερα.',
    );
    return '$_temp0';
  }

  @override
  String get errorServiceUnavailable =>
      'Οι αυτόματες προτάσεις δεν είναι διαθέσιμες αυτή τη στιγμή.';

  @override
  String get collectionsDeleteButton => 'Διαγραφή συλλογής';

  @override
  String get collectionsDeleteTitle => 'Διαγραφή συλλογής;';

  @override
  String get collectionsDeleteMessage => 'Οι λέξεις παραμένουν. Διαγράφεται μόνο η συλλογή.';

  @override
  String get scanTypeHint => 'Πληκτρολογήστε μια λέξη...';

  @override
  String get scanOpenSettingsButton => 'Άνοιγμα ρυθμίσεων';

  @override
  String get errorCameraPermission =>
      'Επιτρέψτε την πρόσβαση στην κάμερα για να τραβάτε φωτογραφίες.';

  @override
  String get errorCameraUnavailable => 'Η κάμερα δεν μπορεί να χρησιμοποιηθεί αυτή τη στιγμή.';

  @override
  String errorImageLabelingQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Χρησιμοποιήσατε τις $limit σαρώσεις των τελευταίων 24 ωρών. Γράψτε τη λέξη μόνοι σας ή δοκιμάστε ξανά αργότερα.',
      one:
          'Χρησιμοποιήσατε τη $limit σάρωση των τελευταίων 24 ωρών. Γράψτε τη λέξη μόνοι σας ή δοκιμάστε ξανά αργότερα.',
    );
    return '$_temp0';
  }

  @override
  String errorImageLabelingMonthlyQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Χρησιμοποιήσατε τις $limit σαρώσεις αυτού του μήνα. Γράψτε τη λέξη μόνοι σας ή δοκιμάστε ξανά τον επόμενο μήνα.',
      one:
          'Χρησιμοποιήσατε τη $limit σάρωση αυτού του μήνα. Γράψτε τη λέξη μόνοι σας ή δοκιμάστε ξανά τον επόμενο μήνα.',
    );
    return '$_temp0';
  }

  @override
  String errorQuotaSignInForMore(String message) {
    return '$message Συνδεθείτε με Google για περισσότερες.';
  }

  @override
  String get connectToInternet => 'Σύνδεση στο διαδίκτυο';

  @override
  String get scanOfflineMessage =>
      'Οι προτάσεις χρειάζονται σύνδεση στο διαδίκτυο. Μπορείτε επίσης να γράψετε τη λέξη μόνοι σας.';

  @override
  String get detailsOfflineMessage =>
      'Η μετάφραση και η αναζήτηση φωτογραφιών χρειάζονται σύνδεση στο διαδίκτυο.';

  @override
  String get welcomeOfflineMessage => 'Η σύνδεση με Google χρειάζεται σύνδεση στο διαδίκτυο.';

  @override
  String get settingsSignInOfflineMessage =>
      'Η σύνδεση στον λογαριασμό χρειάζεται σύνδεση στο διαδίκτυο.';

  @override
  String get settingsPracticeReminderTitle => 'Υπενθύμιση εξάσκησης';

  @override
  String get settingsPracticeReminderHint => 'Μόνο τις ημέρες με λέξεις για εξάσκηση';

  @override
  String get settingsReminderTimeTitle => 'Ώρα';

  @override
  String get settingsNotificationsBlockedMessage =>
      'Οι ειδοποιήσεις είναι απενεργοποιημένες για το Vocabualize.';

  @override
  String get settingsOpenNotificationSettingsButton => 'Άνοιγμα ρυθμίσεων';

  @override
  String get reminderPracticeTitle => 'Ώρα για εξάσκηση';

  @override
  String get reminderPracticeBody =>
      'Οι λέξεις σας σας περιμένουν. Λίγα λεπτά αρκούν για να μείνουν φρέσκες.';

  @override
  String get reminderPracticeChannel => 'Υπενθυμίσεις εξάσκησης';

  @override
  String get errorReportLimit => 'Στείλατε αρκετές αναφορές πρόσφατα. Δοκιμάστε ξανά αργότερα.';

  @override
  String get errorReportUnavailable =>
      'Οι αναφορές δεν μπορούν να σταλούν αυτή τη στιγμή. Δοκιμάστε ξανά αργότερα.';

  @override
  String get reportFeedbackTitle => 'Σχόλια και σφάλματα';

  @override
  String get reportFeedbackMessage => 'Πείτε μας τι σας αρέσει, τι λείπει ή τι πήγε στραβά.';

  @override
  String get reportFeedbackFieldHint => 'Το μήνυμά σας...';

  @override
  String get reportFeedbackContextHint =>
      'Αποστέλλονται επίσης: έκδοση εφαρμογής, έκδοση Android, γλώσσα εφαρμογής και το ζεύγος γλωσσών σας.';

  @override
  String get reportSendButton => 'Αποστολή';

  @override
  String get reportFeedbackSentMessage => 'Ευχαριστούμε! Το μήνυμά σας στάλθηκε.';

  @override
  String get reportTranslationSentMessage => 'Ευχαριστούμε! Η μετάφραση αναφέρθηκε.';

  @override
  String get reportOfflineMessage => 'Η αποστολή χρειάζεται σύνδεση στο διαδίκτυο.';

  @override
  String get settingsDeleteAccountButton => 'Διαγραφή λογαριασμού';

  @override
  String get settingsDeleteDataButton => 'Διαγραφή όλων των δεδομένων';

  @override
  String get settingsDeleteAccountTitle => 'Διαγραφή λογαριασμού;';

  @override
  String get settingsDeleteAccountMessage =>
      'Ο λογαριασμός σας και όλο το περιεχόμενό του θα διαγραφούν οριστικά από όλες τις συσκευές σας: λέξεις, φωτογραφίες, συλλογές και πρόοδος. Αυτό δεν μπορεί να αναιρεθεί.';

  @override
  String get settingsDeleteDataTitle => 'Διαγραφή όλων των δεδομένων;';

  @override
  String get settingsDeleteDataMessage =>
      'Όλες οι λέξεις, οι φωτογραφίες, οι συλλογές και η πρόοδος σε αυτό το τηλέφωνο θα διαγραφούν οριστικά. Αυτό δεν μπορεί να αναιρεθεί.';

  @override
  String get settingsDeleteConfirmWord => 'ΔΙΑΓΡΑΦΗ';

  @override
  String settingsDeleteConfirmHint(String word) {
    return 'Πληκτρολογήστε $word για επιβεβαίωση';
  }

  @override
  String get settingsDeleteConfirmButton => 'Διαγραφή';

  @override
  String get settingsDeleteAccountOfflineMessage =>
      'Η διαγραφή του λογαριασμού σας χρειάζεται σύνδεση στο διαδίκτυο.';

  @override
  String streakTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ημέρες στη σειρά',
      one: '$count ημέρα στη σειρά',
      zero: 'Κανένα σερί ακόμη',
    );
    return '$_temp0';
  }

  @override
  String get streakStartMessage =>
      'Κάντε εξάσκηση ή προσθέστε μια λέξη για να ξεκινήσετε ένα σερί.';

  @override
  String get streakDoneMessage => 'Τελειώσατε για σήμερα. Τα λέμε αύριο!';

  @override
  String get streakPendingMessage =>
      'Κάντε εξάσκηση ή προσθέστε μια λέξη σήμερα για να κρατήσετε το σερί σας.';

  @override
  String get streakLongestLabel => 'Μεγαλύτερο σερί';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ημέρες',
      one: '$count ημέρα',
    );
    return '$_temp0';
  }

  @override
  String get streakFreezesLabel => 'Προστασίες σερί';

  @override
  String streakFreezesValue(int count, int max) {
    return '$count από $max';
  }

  @override
  String streakFreezeExplanation(int days, int max) {
    return 'Κάθε $days συνεχόμενες ενεργές ημέρες κερδίζετε μια προστασία (έως $max). Μια προστασία σώζει το σερί σας μια μέρα που το χάνετε.';
  }

  @override
  String get streakDayActive => 'Ενεργή';

  @override
  String get streakDayFrozen => 'Σώθηκε με προστασία';

  @override
  String get streakDayPending => 'Ακόμη ανοιχτή';

  @override
  String get streakDayMissed => 'Χάθηκε';

  @override
  String get settingsStreakReminderTitle => 'Υπενθύμιση σερί';

  @override
  String get settingsStreakReminderHint => 'Μόνο τις ημέρες που το σερί σας κινδυνεύει';

  @override
  String get reminderStreakChannel => 'Υπενθυμίσεις σερί';

  @override
  String get reminderStreakKeepTitle => 'Κρατήστε το σερί σας';

  @override
  String reminderStreakKeepBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Κάντε εξάσκηση σε μερικές λέξεις σήμερα για να κρατήσετε το σερί σας $count ημερών.',
      one: 'Κάντε εξάσκηση σε μερικές λέξεις σήμερα για να κρατήσετε το σερί σας $count ημέρας.',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakLookAroundTitle => 'Κοιτάξτε γύρω σας';

  @override
  String get reminderStreakLookAroundBody =>
      'Βλέπετε κάτι που δεν ξέρετε ακόμη πώς λέγεται; Προσθέστε το ως νέα λέξη.';

  @override
  String get reminderStreakQuickRoundTitle => 'Ένας γρήγορος γύρος;';

  @override
  String reminderStreakQuickRoundBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ένας σύντομος γύρος εξάσκησης κρατά ζωντανές τις $count ημέρες σας.',
      one: 'Ένας σύντομος γύρος εξάσκησης κρατά το σερί σας ζωντανό.',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakNearbyTitle => 'Μια νέα λέξη κοντά σας;';

  @override
  String get reminderStreakNearbyBody => 'Διαλέξτε κάτι γύρω σας και μάθετε πώς λέγεται.';

  @override
  String reminderStreakInARowTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ημέρες στη σειρά',
      one: '$count ημέρα στη σειρά',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakInARowBody =>
      'Μη σταματάτε τώρα. Κάντε εξάσκηση ή προσθέστε μια λέξη σήμερα.';

  @override
  String get settingsPrivacyPolicyButton => 'Πολιτική απορρήτου';

  @override
  String get scanReportSuggestionButton => 'Αναφορά πρότασης';
}
