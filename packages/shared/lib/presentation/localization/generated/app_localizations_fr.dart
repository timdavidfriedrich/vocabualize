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
  String get errorConnection => 'Pas de connexion internet.';

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
  String get homeNoNewWordsMessage =>
      'Oh, il semble que vous n\'ayez pas ajouté de mots depuis un moment. :(';

  @override
  String get homeStatusFirstWordMessage =>
      'Vous avez ajouté votre premier mot ! Ajoutez-en d\'autres et appuyez sur « s\'exercer » ! :)';

  @override
  String get homeStatusEmptyMessage => 'Pourquoi n\'ajoutez-vous pas quelques nouveaux mots ? :)';

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
  String homeStatusTotalMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Votre collection contient $count mots.',
      one: 'Votre collection ne contient qu\'un seul mot. Il se sent seul. Ajoutez-en d\'autres ! :)',
    );
    return '$_temp0';
  }

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
  String homeStatusManyInTotalMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Eh bien, vous avez ajouté $count mots au total. Pas mal !',
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
}
