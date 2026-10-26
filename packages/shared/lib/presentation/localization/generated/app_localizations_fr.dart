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
  String get reportBugTitle => 'Signaler un bug';

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
  String get settingsCollectionsTitle => 'Activer les collections';

  @override
  String get settingsCollectionsHint => 'Catégoriser les mots en collections';

  @override
  String get settingsImagesHiddenTitle => 'Masquer les images';

  @override
  String get settingsImagesHiddenHint => 'Cela pourrait diminuer la qualité de l\'apprentissage';

  @override
  String get settingsSourceLanguageTitle => 'Langue source';

  @override
  String get settingsSourceLanguageHint => 'Une langue que vous maîtrisez bien';

  @override
  String get settingsTargetLanguageTitle => 'Langue cible';

  @override
  String get settingsTargetLanguageHint => 'La langue que vous apprenez';

  @override
  String get settingsNotificationsTitle => 'Activer/désactiver les notifications';

  @override
  String get settingsNotificationsHint =>
      'Ouvrir les paramètres système de l\'application pour gérer';

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
  String detailsPhotoByLabel(String author) {
    return 'Photo de $author';
  }

  @override
  String get detailsReplaceButton => 'Remplacer';

  @override
  String get reportBugDescriptionHint => 'Décrivez le bug...';

  @override
  String get settingsAccountTitle => 'Compte';

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
  String get settingsBackupTitle => 'Sauvegarde';

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
  String languagePairLabel(String source, String target) {
    return '$source → $target';
  }

  @override
  String get languageSelectionTitle => 'Vos langues';

  @override
  String get languageSelectionContinueButton => 'Continuer';

  @override
  String get settingsLanguagesTitle => 'Langues';

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
  String homeDueMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mots à réviser',
      one: '$count mot à réviser',
    );
    return '$_temp0';
  }

  @override
  String get homeAllDoneMessage => 'Tout est fait pour le moment';

  @override
  String homeTotalWordsMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mots au total',
      one: '$count mot au total',
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
  String get errorAiUnavailable =>
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
  String get scanSignInMessage => 'Connectez-vous pour obtenir des suggestions pour votre photo.';

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
  String get settingsSignOutOfflineMessage =>
      'La déconnexion nécessite une connexion internet, afin que vos dernières modifications soient d\'abord envoyées.';
}
