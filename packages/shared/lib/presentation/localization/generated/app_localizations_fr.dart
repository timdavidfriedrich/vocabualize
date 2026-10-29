// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Vocabualize';

  @override
  String get cancel => 'Annuler';

  @override
  String get close => 'Fermer';

  @override
  String get back => 'Retour';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get error => 'Erreur';

  @override
  String get errorConnection =>
      'Impossible de joindre le serveur. Vérifiez votre connexion internet et réessayez.';

  @override
  String errorApi(String message) {
    return 'Erreur lors de la communication avec le serveur : $message.';
  }

  @override
  String get errorAuth => 'Vous n\'êtes pas connecté.';

  @override
  String get errorValidation => 'Les données reçues ne sont pas valides.';

  @override
  String get errorNotFound => 'Introuvable.';

  @override
  String get errorUnexpected => 'Une erreur inattendue s\'est produite.';

  @override
  String get unknown => 'inconnu';

  @override
  String get no => 'Non';

  @override
  String get yes => 'Oui';

  @override
  String get okay => 'OK';

  @override
  String get submit => 'Envoyer';

  @override
  String get delete => 'Supprimer';

  @override
  String get edit => 'Modifier';

  @override
  String get languagePickerTitle => 'Sélectionner la langue';

  @override
  String get vocabularyDeleteTitle => 'Supprimer ?';

  @override
  String get vocabularyDeleteMessage => 'Voulez-vous vraiment supprimer ce vocabulaire ?';

  @override
  String get vocabularyCreatedLabel => 'Créé :';

  @override
  String get vocabularyReappearsLabel => 'Réapparait :';

  @override
  String get vocabularyReappearsNow => 'Maintenant';

  @override
  String get vocabularyReappearsLessThanMinute => 'En moins d\'une minute';

  @override
  String get notificationPracticeChannelName => 'Entraîner le vocabulaire';

  @override
  String get notificationPracticeChannelDescription => 'Passons à l\'entraînement 🎯';

  @override
  String get notificationPracticeTitle => 'Passons à l\'entraînement 🎯';

  @override
  String get notificationPracticeBody =>
      'Certaines fiches de vocabulaire sont peut-être à réviser. Vous allez assurer ! :D';

  @override
  String get welcomeSourceLanguageTitle => 'Je parle';

  @override
  String get welcomeTargetLanguageTitle => 'Je veux apprendre';

  @override
  String get welcomeStartButton => 'C\'est parti !';

  @override
  String get welcomeGoogleSignInButton => 'Se connecter avec Google';

  @override
  String get welcomeContinueWithoutAccountButton => 'Continuer sans compte';

  @override
  String get welcomeSignInFailedTitle => 'Échec de la connexion';

  @override
  String get homeCollectionsTitle => 'Collections';

  @override
  String get homeAddFirstWordMessage => 'Cliquez sur le bouton\npour ajouter votre premier mot';

  @override
  String get homeAllWordsTitle => 'Tous les vocabulaires';

  @override
  String get homeNewWordsTitle => 'Récemment ajoutés';

  @override
  String get homePracticeButton => 'S\'exercer';

  @override
  String get homeScanButton => 'Scanner';

  @override
  String get homeWriteButton => 'Écrire';

  @override
  String get homeWriteHint => 'Saisissez un mot...';

  @override
  String get detailsSourceLabel => 'Mot source';

  @override
  String get detailsTargetLabel => 'Traduction';

  @override
  String get detailsReportTranslationButton => 'Signaler une traduction erronée';

  @override
  String get detailsAddCollectionButton => 'Ajouter à une collection';

  @override
  String get detailsReplaceTitle => 'Remplacer';

  @override
  String get detailsReplaceMessage => 'Retraduire et remplacer le vocabulaire ?';

  @override
  String get detailsDuplicateTitle => 'Doublon !';

  @override
  String get detailsDuplicateAddButton => 'Ajouter';

  @override
  String get detailsNoImageMessage => 'Choisissez une image\nou enregistrez sans image';

  @override
  String get detailsOpenGalleryButton => 'Ouvrir la galerie';

  @override
  String get detailsRemoveImageButton => 'Retirer l\'image';

  @override
  String get detailsPexelsAttribution => 'Images fournies par Pexels.';

  @override
  String get detailsSaveButton => 'Enregistrer';

  @override
  String get detailsSaveWithoutImageButton => 'Enregistrer sans';

  @override
  String get detailsTakePictureButton => 'Prendre une photo';

  @override
  String get detailsCollectionNameHint => 'Sans titre';

  @override
  String get detailsCollectionNameLabel => 'Nom du tag';

  @override
  String get practiceDoneTitle => 'Félicitations !';

  @override
  String get practiceDoneMessage => 'Vous avez pratiqué tous\nvos mots à réviser.';

  @override
  String get practiceDoneButton => 'Terminé';

  @override
  String get practiceForgotButton => 'Je ne savais pas';

  @override
  String get practiceEasyButton => 'Facile';

  @override
  String get practiceGoodButton => 'Bien';

  @override
  String get practiceHardButton => 'Difficile';

  @override
  String get practiceSolutionButton => 'Solution';

  @override
  String get practiceAnswerLabel => 'Votre réponse';

  @override
  String get scanAddButton => 'Ajouter';

  @override
  String get scanSuggestionsTitle => 'Suggestions';

  @override
  String get scanNoSuggestionsMessage =>
      'Aucun objet n\'a pu être reconnu. Veuillez réessayer plus tard.';

  @override
  String get reportTranslationTitle => 'Traduction erronée';

  @override
  String get reportTranslationNoteHint => 'Note (facultative)';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsSignInHint =>
      'Connectez-vous pour synchroniser vos données sur tous vos appareils.';

  @override
  String get settingsSignInButton => 'Se connecter';

  @override
  String get settingsTypeAnswerDisabledTitle => 'Désactiver le mode réponse écrite';

  @override
  String get settingsTypeAnswerDisabledHint =>
      'Utiliser uniquement le rappel de mémoire avec auto-évaluation';

  @override
  String get settingsStrictCorrectionTitle => 'Correction stricte';

  @override
  String get settingsStrictCorrectionHint =>
      'Les accents et caractères spéciaux doivent être saisis exactement';

  @override
  String get settingsCollectionsTitle => 'Activer les collections';

  @override
  String get settingsCollectionsHint => 'Catégoriser les mots en collections';

  @override
  String get settingsImagesHiddenTitle => 'Masquer les images';

  @override
  String get settingsImagesHiddenHint => 'Cela pourrait diminuer la qualité de l\'apprentissage';

  @override
  String get settingsDefaultGatherTitle => 'Ajout par défaut';

  @override
  String get settingsDefaultGatherHint =>
      'Le bouton + démarre directement, un appui long affiche toutes les options';

  @override
  String get settingsDefaultGatherNone => 'Aucun';

  @override
  String get settingsAppearanceTitle => 'Apparence';

  @override
  String get settingsAppearanceHint => 'Clair, sombre ou comme votre téléphone';

  @override
  String get settingsAppearanceSystem => 'Système';

  @override
  String get settingsAppearanceLight => 'Clair';

  @override
  String get settingsAppearanceDark => 'Sombre';

  @override
  String get settingsSourceLanguageTitle => 'Langue source';

  @override
  String get settingsSourceLanguageHint => 'Une langue que vous maîtrisez bien';

  @override
  String get settingsTargetLanguageTitle => 'Langue cible';

  @override
  String get settingsTargetLanguageHint => 'La langue que vous apprenez';

  @override
  String vocabularyReappearsInMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dans $count minutes',
      one: 'Dans $count minute',
    );
    return '$_temp0';
  }

  @override
  String vocabularyReappearsInHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dans $count heures',
      one: 'Dans $count heure',
    );
    return '$_temp0';
  }

  @override
  String vocabularyReappearsInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dans $count jours',
      one: 'Dans $count jour',
    );
    return '$_temp0';
  }

  @override
  String detailsDuplicateMessage(String word) {
    return 'Il semble que « $word » existe déjà dans votre collection.\n\nL\'ajouter quand même ?';
  }

  @override
  String vocabularyPhotoByLabel(String author) {
    return 'Photo de $author';
  }

  @override
  String get detailsReplaceButton => 'Remplacer';

  @override
  String get errorSyncPending => 'Vos dernières modifications n\'ont pas encore été envoyées.';

  @override
  String get settingsSignOutButton => 'Se déconnecter';

  @override
  String get settingsSignOutBlockedTitle => 'Modifications non envoyées';

  @override
  String get settingsSignOutBlockedMessage =>
      'Certaines modifications ne sont pas encore arrivées sur le serveur. Connectez-vous à internet et réessayez. Si vous vous déconnectez quand même, ces modifications seront perdues.';

  @override
  String get settingsSignOutAnywayButton => 'Se déconnecter quand même';

  @override
  String get syncStatusConnecting => 'Connexion…';

  @override
  String get syncStatusSyncing => 'Synchronisation…';

  @override
  String get syncStatusSynced => 'Toutes les modifications sont synchronisées';

  @override
  String get syncStatusOffline =>
      'Hors ligne. Les modifications seront synchronisées dès votre retour en ligne.';

  @override
  String get syncStatusUpdateRequired =>
      'Mettez l\'application à jour pour continuer la synchronisation.';

  @override
  String get syncStatusSignInRequired =>
      'Votre session a expiré. Reconnectez-vous pour continuer la synchronisation.';

  @override
  String get gateUpdateTitle => 'Mise à jour requise';

  @override
  String get gateUpdateMessage =>
      'Cette version de Vocabualize n\'est plus prise en charge. Veuillez mettre à jour l\'application pour continuer à apprendre.';

  @override
  String get gateUpdateButton => 'Mettre à jour';

  @override
  String get gateMaintenanceTitle => 'Maintenance en cours';

  @override
  String get gateMaintenanceMessage =>
      'Vocabualize est en cours de mise à jour. Veuillez réessayer plus tard.';

  @override
  String get settingsExportBackupButton => 'Exporter une sauvegarde';

  @override
  String get settingsExportBackupHint => 'Enregistrer tous les mots et images dans un fichier';

  @override
  String get settingsImportBackupButton => 'Importer une sauvegarde';

  @override
  String get settingsImportBackupHint => 'Ajouter les mots d\'un fichier de sauvegarde';

  @override
  String get settingsImportBackupConfirmTitle => 'Importer la sauvegarde ?';

  @override
  String get settingsImportBackupConfirmMessage =>
      'Tous les mots, collections et images de la sauvegarde sont ajoutés à votre collection. Vos mots actuels ne changent pas.';

  @override
  String get settingsImportBackupConfirmButton => 'Importer';

  @override
  String settingsImportBackupDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mots importés.',
      one: '$count mot importé.',
    );
    return '$_temp0';
  }

  @override
  String get errorInvalidBackup => 'Ce fichier n\'est pas une sauvegarde Vocabualize.';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageGerman => 'Allemand';

  @override
  String get languageSpanish => 'Espagnol';

  @override
  String get languageFrench => 'Français';

  @override
  String get languagePolish => 'Polonais';

  @override
  String get languageItalian => 'Italien';

  @override
  String get languageGreek => 'Grec';

  @override
  String get languageRomanian => 'Roumain';

  @override
  String languagePairLabel(String source, String target) {
    return '$source → $target';
  }

  @override
  String get languageSelectionTitle => 'Vos langues';

  @override
  String get languageSelectionContinueButton => 'Continuer';

  @override
  String get languageSelectionSaveButton => 'Enregistrer';

  @override
  String get dataOfflineTitle => 'Vous êtes hors ligne';

  @override
  String get dataOfflineMessage => 'Vos mots seront téléchargés dès que vous serez connecté.';

  @override
  String get dataRetryButton => 'Réessayer';

  @override
  String get dataSignInRequiredTitle => 'Reconnectez-vous';

  @override
  String get dataSignInRequiredMessage =>
      'Votre session a expiré. Connectez-vous pour charger vos mots.';

  @override
  String get dataSignInButton => 'Se connecter';

  @override
  String get syncStatusServerUnreachable =>
      'Le serveur est injoignable. Les modifications seront synchronisées dès son retour.';

  @override
  String get syncStatusClockWrong =>
      'L\'horloge de votre téléphone est décalée. Activez l\'heure automatique pour continuer la synchronisation.';

  @override
  String get syncStatusFailed =>
      'La synchronisation a échoué. Vos mots sont en sécurité sur ce téléphone.';

  @override
  String get dataServerUnreachableTitle => 'Serveur injoignable';

  @override
  String get dataServerUnreachableMessage =>
      'Le serveur de Vocabualize est injoignable pour le moment. Vos mots sont en sécurité sur ce téléphone.';

  @override
  String get gateClockWrongTitle => 'L\'horloge de votre téléphone est décalée';

  @override
  String get gateClockWrongMessage =>
      'La synchronisation a besoin de l\'heure exacte. Activez la date et l\'heure automatiques, puis revenez.';

  @override
  String get gateOpenTimeSettingsButton => 'Ouvrir les réglages de l\'heure';

  @override
  String get dataSyncFailedTitle => 'La synchronisation a échoué';

  @override
  String get dataSyncFailedMessage =>
      'Un problème est survenu pendant la synchronisation. Vos mots sont en sécurité sur ce téléphone.';

  @override
  String get accountConflictTitle => 'Changer de compte ?';

  @override
  String accountConflictMessage(String previous, String next) {
    return 'Sur ce téléphone, vous étiez connecté en tant que $previous. Les modifications pas encore envoyées appartiennent à ce compte. Elles seront perdues si vous passez à $next.';
  }

  @override
  String accountConflictKeepButton(String previous) {
    return 'Utiliser $previous à la place';
  }

  @override
  String accountConflictSwitchButton(String previous, String next) {
    return 'Supprimer les données de $previous et utiliser $next';
  }

  @override
  String get accountConflictUnknownAccount => 'compte inconnu';

  @override
  String get settingsSignInAgainButton => 'Se reconnecter';

  @override
  String loadingProgressLabel(int current, int total) {
    return '$current / $total';
  }

  @override
  String get errorClockWrong =>
      'L\'horloge de votre téléphone est décalée. Activez la date et l\'heure automatiques, puis réessayez.';

  @override
  String get homeAllDoneMessage => 'Tout est fait pour le moment';

  @override
  String get homeStatusFirstWordMessage =>
      'Vous avez ajouté votre premier mot ! Ajoutez-en d\'autres et appuyez sur « S\'exercer » ! :)';

  @override
  String get homeStatusEmptyMessage => 'Pourquoi n\'ajoutez-vous pas quelques nouveaux mots ? :)';

  @override
  String get homeStatusOnlyOneWordMessage =>
      'Votre collection ne contient qu\'un seul mot. Il se sent seul. Ajoutez-en d\'autres ! :)';

  @override
  String homeStatusAddedTodayMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wow, vous avez déjà ajouté $count mots aujourd\'hui. Continuez comme ça !',
      one: 'Wow, vous avez déjà ajouté $count mot aujourd\'hui. Continuez comme ça !',
    );
    return '$_temp0';
  }

  @override
  String homeStatusManyWordsMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Eh bien, vous avez ajouté $count mots au total. Pas mal !',
      one: 'Eh bien, vous avez ajouté $count mot au total. Pas mal !',
    );
    return '$_temp0';
  }

  @override
  String homeStatusDefaultMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Votre collection contient $count mots.',
      one: 'Votre collection contient $count mot.',
    );
    return '$_temp0';
  }

  @override
  String homeNextDueTodayMessage(String time) {
    return 'Prochain mot à $time';
  }

  @override
  String homeNextDueLaterMessage(String date) {
    return 'Prochain mot le $date';
  }

  @override
  String get vocabularySpeakTooltip => 'Lire à voix haute';

  @override
  String get vocabularySearchTooltip => 'Rechercher';

  @override
  String get vocabularySearchHint => 'Rechercher un mot...';

  @override
  String get vocabularySearchClearTooltip => 'Effacer';

  @override
  String get vocabularySearchEmptyMessage => 'Aucun mot ne correspond à votre recherche.';

  @override
  String get vocabularyFilterDueLabel => 'À réviser';

  @override
  String get vocabularyLevelNovice => 'Nouveaux';

  @override
  String get vocabularyLevelBeginner => 'Débutant';

  @override
  String get vocabularyLevelAdvanced => 'Avancé';

  @override
  String get vocabularyLevelExpert => 'Expert';

  @override
  String get errorTextToSpeechUnavailable =>
      'Aucune voix n\'est installée pour cette langue sur ce téléphone.';

  @override
  String get detailsRetakeImageButton => 'Reprendre l\'image';

  @override
  String errorTranslationQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Vous avez utilisé vos $limit traductions des dernières 24 heures. Saisissez la traduction vous-même ou réessayez plus tard.',
      one:
          'Vous avez utilisé votre $limit traduction des dernières 24 heures. Saisissez la traduction vous-même ou réessayez plus tard.',
    );
    return '$_temp0';
  }

  @override
  String errorStockImageQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Vous avez utilisé vos $limit recherches de photos des dernières 24 heures. Prenez votre propre photo ou réessayez plus tard.',
      one:
          'Vous avez utilisé votre $limit recherche de photos des dernières 24 heures. Prenez votre propre photo ou réessayez plus tard.',
    );
    return '$_temp0';
  }

  @override
  String get errorServiceUnavailable =>
      'Les suggestions automatiques ne sont pas disponibles pour le moment.';

  @override
  String get collectionsDeleteButton => 'Supprimer la collection';

  @override
  String get collectionsDeleteTitle => 'Supprimer la collection ?';

  @override
  String get collectionsDeleteMessage => 'Les mots restent. Seule la collection est supprimée.';

  @override
  String get scanTypeHint => 'Saisissez un mot...';

  @override
  String get scanOpenSettingsButton => 'Ouvrir les réglages';

  @override
  String get errorCameraPermission =>
      'Autorisez l\'accès à l\'appareil photo pour prendre des photos.';

  @override
  String get errorCameraUnavailable => 'L\'appareil photo ne peut pas être utilisé pour le moment.';

  @override
  String errorImageLabelingQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Vous avez utilisé vos $limit scans des dernières 24 heures. Saisissez le mot vous-même ou réessayez plus tard.',
      one:
          'Vous avez utilisé votre $limit scan des dernières 24 heures. Saisissez le mot vous-même ou réessayez plus tard.',
    );
    return '$_temp0';
  }

  @override
  String errorImageLabelingMonthlyQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Vous avez utilisé vos $limit scans de ce mois-ci. Saisissez le mot vous-même ou réessayez le mois prochain.',
      one:
          'Vous avez utilisé votre $limit scan de ce mois-ci. Saisissez le mot vous-même ou réessayez le mois prochain.',
    );
    return '$_temp0';
  }

  @override
  String errorQuotaSignInForMore(String message) {
    return '$message Connectez-vous avec Google pour en obtenir davantage.';
  }

  @override
  String get connectToInternet => 'Se connecter à internet';

  @override
  String get scanOfflineMessage =>
      'Les suggestions nécessitent une connexion internet. Vous pouvez aussi saisir le mot vous-même.';

  @override
  String get detailsOfflineMessage =>
      'La traduction et la recherche de photos nécessitent une connexion internet.';

  @override
  String get welcomeOfflineMessage => 'La connexion avec Google nécessite une connexion internet.';

  @override
  String get settingsSignInOfflineMessage =>
      'La connexion à votre compte nécessite une connexion internet.';

  @override
  String get settingsPracticeReminderTitle => 'Rappel d\'entraînement';

  @override
  String get settingsPracticeReminderHint => 'Seulement les jours où des mots sont à réviser';

  @override
  String get settingsReminderTimeTitle => 'Heure';

  @override
  String get settingsNotificationsBlockedMessage =>
      'Les notifications de Vocabualize sont désactivées.';

  @override
  String get settingsOpenNotificationSettingsButton => 'Ouvrir les réglages';

  @override
  String get reminderPracticeTitle => 'C\'est l\'heure de réviser';

  @override
  String get reminderPracticeBody =>
      'Vos mots vous attendent. Quelques minutes suffisent pour les garder en tête.';

  @override
  String get reminderPracticeChannel => 'Rappels d\'entraînement';

  @override
  String get errorReportLimit =>
      'Vous avez envoyé plusieurs signalements récemment. Réessayez plus tard.';

  @override
  String get errorReportUnavailable =>
      'Les signalements ne peuvent pas être envoyés pour le moment. Réessayez plus tard.';

  @override
  String get reportFeedbackTitle => 'Avis et bugs';

  @override
  String get reportFeedbackMessage =>
      'Dites-nous ce qui vous plaît, ce qui manque ou ce qui n\'a pas fonctionné.';

  @override
  String get reportFeedbackFieldHint => 'Votre message...';

  @override
  String get reportFeedbackContextHint =>
      'Envoyé avec : version de l\'app, version d\'Android, langue de l\'app et votre paire de langues.';

  @override
  String get reportSendButton => 'Envoyer';

  @override
  String get reportFeedbackSentMessage => 'Merci ! Votre message a été envoyé.';

  @override
  String get reportTranslationSentMessage => 'Merci ! La traduction a été signalée.';

  @override
  String get reportOfflineMessage => 'L\'envoi nécessite une connexion internet.';

  @override
  String get settingsDeleteAccountButton => 'Supprimer le compte';

  @override
  String get settingsDeleteDataButton => 'Supprimer toutes les données';

  @override
  String get settingsDeleteAccountTitle => 'Supprimer le compte ?';

  @override
  String get settingsDeleteAccountMessage =>
      'Cela supprime définitivement votre compte et tout son contenu sur tous vos appareils : mots, photos, collections et progression. Cette action est irréversible.';

  @override
  String get settingsDeleteDataTitle => 'Supprimer toutes les données ?';

  @override
  String get settingsDeleteDataMessage =>
      'Cela supprime définitivement tous les mots, photos, collections et la progression sur ce téléphone. Cette action est irréversible.';

  @override
  String get settingsDeleteConfirmWord => 'SUPPRIMER';

  @override
  String settingsDeleteConfirmHint(String word) {
    return 'Saisissez $word pour confirmer';
  }

  @override
  String get settingsDeleteConfirmButton => 'Supprimer';

  @override
  String get settingsDeleteAccountOfflineMessage =>
      'La suppression de votre compte nécessite une connexion internet.';

  @override
  String streakTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Série de $count jours',
      one: 'Série de $count jour',
      zero: 'Pas encore de série',
    );
    return '$_temp0';
  }

  @override
  String get streakStartMessage => 'Révisez ou ajoutez un mot pour commencer une série.';

  @override
  String get streakDoneMessage => 'C\'est fait pour aujourd\'hui. À demain !';

  @override
  String get streakPendingMessage =>
      'Révisez ou ajoutez un mot aujourd\'hui pour garder votre série.';

  @override
  String get streakLongestLabel => 'Plus longue série';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '$count jour',
    );
    return '$_temp0';
  }

  @override
  String get streakFreezesLabel => 'Gels de série';

  @override
  String streakFreezesValue(int count, int max) {
    return '$count sur $max';
  }

  @override
  String streakFreezeExplanation(int days, int max) {
    return 'Tous les $days jours actifs d\'affilée, vous gagnez un gel de série (max. $max). Il protège votre série un jour où vous ne pratiquez pas.';
  }

  @override
  String get streakDayActive => 'Actif';

  @override
  String get streakDayFrozen => 'Sauvé par un gel';

  @override
  String get streakDayPending => 'Encore ouvert';

  @override
  String get streakDayMissed => 'Manqué';

  @override
  String get settingsStreakReminderTitle => 'Rappel de série';

  @override
  String get settingsStreakReminderHint => 'Seulement les jours où votre série est en danger';

  @override
  String get reminderStreakChannel => 'Rappels de série';

  @override
  String get reminderStreakKeepTitle => 'Gardez votre série';

  @override
  String reminderStreakKeepBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Révisez quelques mots aujourd\'hui pour garder votre série de $count jours.',
      one: 'Révisez quelques mots aujourd\'hui pour garder votre série de $count jour.',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakLookAroundTitle => 'Regardez autour de vous';

  @override
  String get reminderStreakLookAroundBody =>
      'Vous voyez quelque chose que vous ne savez pas encore nommer ? Ajoutez-le comme nouveau mot.';

  @override
  String get reminderStreakQuickRoundTitle => 'Une petite session ?';

  @override
  String reminderStreakQuickRoundBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Une courte session de révision garde vos $count jours en vie.',
      one: 'Une courte session de révision garde votre série en vie.',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakNearbyTitle => 'Un nouveau mot tout près ?';

  @override
  String get reminderStreakNearbyBody =>
      'Choisissez un objet autour de vous et apprenez comment il s\'appelle.';

  @override
  String reminderStreakInARowTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours d\'affilée',
      one: '$count jour d\'affilée',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakInARowBody =>
      'Ne vous arrêtez pas maintenant. Révisez ou ajoutez un mot aujourd\'hui.';

  @override
  String get settingsPrivacyPolicyButton => 'Politique de confidentialité';

  @override
  String get scanReportSuggestionButton => 'Signaler une suggestion';
}
