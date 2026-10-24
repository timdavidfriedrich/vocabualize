// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Vocabualize';

  @override
  String get cancel => 'Cancelar';

  @override
  String get close => 'Cerrar';

  @override
  String get back => 'Atrás';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get error => 'Error';

  @override
  String get errorConnection => 'Sin conexión a internet.';

  @override
  String errorApi(String message) {
    return 'Error al comunicarse con el servidor: $message.';
  }

  @override
  String get errorAuth => 'No has iniciado sesión.';

  @override
  String get errorValidation => 'Los datos recibidos no son válidos.';

  @override
  String get errorNotFound => 'No encontrado.';

  @override
  String get errorUnexpected => 'Se ha producido un error inesperado.';

  @override
  String get unknown => 'desconocido';

  @override
  String get no => 'No';

  @override
  String get yes => 'Sí';

  @override
  String get okay => 'Vale';

  @override
  String get submit => 'Enviar';

  @override
  String get delete => 'Borrar';

  @override
  String get languagePickerTitle => 'Seleccionar idioma';

  @override
  String get vocabularyDeleteTitle => '¿Borrar?';

  @override
  String get vocabularyDeleteMessage => '¿Estás seguro de que quieres borrar esta palabra?';

  @override
  String get vocabularyCreatedLabel => 'Creado:';

  @override
  String get vocabularyReappearsLabel => 'Reaparece:';

  @override
  String get vocabularyReappearsNow => 'Ahora';

  @override
  String get vocabularyReappearsLessThanMinute => 'En menos de un minuto';

  @override
  String get notificationPracticeChannelName => 'Recordatorio de práctica';

  @override
  String get notificationPracticeChannelDescription => '¡A practicar! 🎯';

  @override
  String get notificationPracticeTitle => '¡A practicar! 🎯';

  @override
  String get notificationPracticeBody => 'Algunas palabras están pendientes. ¡Vamos! :D';

  @override
  String get welcomeSourceLanguageTitle => 'Hablo';

  @override
  String get welcomeTargetLanguageTitle => 'Quiero aprender';

  @override
  String get welcomeStartButton => '¡Vamos!';

  @override
  String get welcomeGoogleSignInButton => 'Seguir con Google';

  @override
  String get welcomeContinueWithoutAccountButton => 'Continuar sin cuenta';

  @override
  String get welcomeSignInFailedTitle => 'Error de inicio de sesión';

  @override
  String get homeCollectionsTitle => 'Colecciones';

  @override
  String get homeAddFirstWordMessage => '¡Haz clic en el botón\npara añadir tu primera palabra!';

  @override
  String get homeAllWordsTitle => 'Todas las palabras';

  @override
  String get homeNewWordsTitle => 'Nuevas palabras';

  @override
  String get homeNoNewWordsMessage => 'Parece que llevas mucho tiempo sin añadir palabras. :(';

  @override
  String get homeStatusFirstWordMessage =>
      '¡Has añadido tu primera palabra! Recoge algunas más o haz clic en «Practicar» :)';

  @override
  String get homeStatusEmptyMessage => '¿Por qué no añades nuevas palabras? :)';

  @override
  String get homePracticeButton => 'Practicar';

  @override
  String get homeScanButton => 'Escanear';

  @override
  String get homeWriteButton => 'Escribir';

  @override
  String get homeWriteHint => 'Entrar palabra...';

  @override
  String get detailsSourceLabel => 'Fuente';

  @override
  String get detailsTargetLabel => 'Traducción';

  @override
  String get detailsReportTranslationButton => 'Informar de una traducción incorrecta';

  @override
  String get detailsAddCollectionButton => 'Añadir a colección';

  @override
  String get detailsReplaceTitle => '¿Reemplazar?';

  @override
  String get detailsReplaceMessage => '¿Volver a traducir la palabra y reemplazarla?';

  @override
  String get detailsDuplicateTitle => '¡Duplicado!';

  @override
  String get detailsDuplicateAddButton => 'Añadir';

  @override
  String get detailsNoImageMessage => 'Elija una imagen\no guárdela sin ella';

  @override
  String get detailsOpenGalleryButton => 'Abrir galería';

  @override
  String get detailsRemoveImageButton => 'Quitar imagen';

  @override
  String get detailsPexelsAttribution => 'Imágenes proporcionadas por Pexels.';

  @override
  String get detailsSaveButton => 'Guardar';

  @override
  String get detailsSaveWithoutImageButton => 'Guardar sin';

  @override
  String get detailsTakePictureButton => 'Haz una foto';

  @override
  String get detailsCollectionNameHint => 'Sin título';

  @override
  String get detailsCollectionNameLabel => 'Nombre de la etiqueta';

  @override
  String get practiceDoneTitle => '¡Muy bien!';

  @override
  String get practiceDoneMessage => 'Has practicado todas\nlas palabras pendientes.';

  @override
  String get practiceDoneButton => 'Inicio';

  @override
  String get practiceForgotButton => 'No lo sabía';

  @override
  String get practiceEasyButton => 'Fácil';

  @override
  String get practiceGoodButton => 'Bien';

  @override
  String get practiceHardButton => 'Duro';

  @override
  String get practiceSolutionButton => 'Solución';

  @override
  String get practiceAnswerLabel => 'Tus solución';

  @override
  String get scanAddButton => 'Añadir';

  @override
  String get scanSuggestionsTitle => 'Sugerencias';

  @override
  String get scanNoSuggestionsMessage =>
      'No se pudieron reconocer objetos. Por favor, inténtalo de nuevo más tarde.';

  @override
  String get reportBugTitle => 'Informar de error';

  @override
  String get reportTranslationTitle => 'Traducción incorrecta';

  @override
  String get reportTranslationNoteHint => 'Nota (opcional)';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsSignInHint => 'Inicia sesión para sincronizar tus datos.';

  @override
  String get settingsSignInButton => 'Iniciar sesión';

  @override
  String get settingsTypeAnswerDisabledTitle => 'Desactivar práctica de respuesta escrita';

  @override
  String get settingsTypeAnswerDisabledHint => 'Solo usar práctica de recuerdo con autoevaluación';

  @override
  String get settingsCollectionsTitle => 'Activar colecciones';

  @override
  String get settingsCollectionsHint => 'Categoriza palabras en colecciones';

  @override
  String get settingsImagesHiddenTitle => 'Ocultar imágenes';

  @override
  String get settingsImagesHiddenHint => 'Puede perjudicar el aprendizaje';

  @override
  String get settingsSourceLanguageTitle => 'Mi idioma';

  @override
  String get settingsSourceLanguageHint => 'Un idioma que conozcas bien.';

  @override
  String get settingsTargetLanguageTitle => 'lengua de llegada';

  @override
  String get settingsTargetLanguageHint => 'La lengua que aprendes';

  @override
  String get settingsNotificationsTitle => 'Activar/desactivar notificaciones';

  @override
  String get settingsNotificationsHint => 'Abrir la configuración del sistema para gestionar';

  @override
  String vocabularyReappearsInMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'En $count minutos',
      one: 'En $count minuto',
    );
    return '$_temp0';
  }

  @override
  String vocabularyReappearsInHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'En $count horas',
      one: 'En $count hora',
    );
    return '$_temp0';
  }

  @override
  String vocabularyReappearsInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'En $count días',
      one: 'En $count día',
    );
    return '$_temp0';
  }

  @override
  String homeStatusTotalMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tu colección contiene $count palabras.',
      one: 'Tu colección contiene solo $count palabra. Se siente sola. ¡Añade alguna más! :)',
    );
    return '$_temp0';
  }

  @override
  String homeStatusAddedTodayMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vaya, hoy ya has añadido $count palabras. Sigue así.',
      one: 'Vaya, hoy ya has añadido $count palabra. Sigue así.',
    );
    return '$_temp0';
  }

  @override
  String homeStatusManyInTotalMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vaya, has añadido $count palabras en total. ¡No está mal!',
    );
    return '$_temp0';
  }

  @override
  String detailsDuplicateMessage(String word) {
    return 'Parece que «$word» ya existe en tu colección.\n\n¿Añadir de todos modos?';
  }

  @override
  String detailsPhotoByLabel(String author) {
    return 'Foto de $author';
  }

  @override
  String get detailsReplaceButton => 'Reemplazar';

  @override
  String get reportBugDescriptionHint => 'Describe el error...';

  @override
  String get settingsAccountTitle => 'Cuenta';

  @override
  String get errorSyncPending => 'Tus últimos cambios aún no se han subido.';

  @override
  String get settingsSignOutButton => 'Cerrar sesión';

  @override
  String get settingsSignOutBlockedTitle => 'Cambios sin subir';

  @override
  String get settingsSignOutBlockedMessage =>
      'Algunos cambios aún no han llegado al servidor. Conéctate a internet e inténtalo de nuevo. Si cierras sesión de todos modos, estos cambios se perderán.';

  @override
  String get settingsSignOutAnywayButton => 'Cerrar sesión de todos modos';

  @override
  String get syncStatusConnecting => 'Conectando…';

  @override
  String get syncStatusSynced => 'Todos los cambios sincronizados';

  @override
  String get syncStatusOffline =>
      'Sin conexión. Los cambios se sincronizarán cuando vuelvas a estar en línea.';

  @override
  String get syncStatusUpdateRequired => 'Actualiza la app para seguir sincronizando.';

  @override
  String get syncStatusSignInRequired =>
      'Tu sesión ha caducado. Inicia sesión de nuevo para seguir sincronizando.';

  @override
  String get gateUpdateTitle => 'Actualización necesaria';

  @override
  String get gateUpdateMessage =>
      'Esta versión de Vocabualize ya no es compatible. Actualice la aplicación para seguir aprendiendo.';

  @override
  String get gateUpdateButton => 'Actualizar';

  @override
  String get gateMaintenanceTitle => 'En mantenimiento';

  @override
  String get gateMaintenanceMessage =>
      'Vocabualize se está actualizando. Inténtelo de nuevo más tarde.';

  @override
  String get settingsBackupTitle => 'Copia de seguridad';

  @override
  String get settingsExportBackupButton => 'Exportar copia de seguridad';

  @override
  String get settingsExportBackupHint => 'Guardar todas las palabras e imágenes en un archivo';

  @override
  String get settingsImportBackupButton => 'Importar copia de seguridad';

  @override
  String get settingsImportBackupHint => 'Añadir las palabras de un archivo de copia de seguridad';

  @override
  String get settingsImportBackupConfirmTitle => '¿Importar copia de seguridad?';

  @override
  String get settingsImportBackupConfirmMessage =>
      'Todas las palabras, colecciones e imágenes de la copia se añaden a su colección. Sus palabras actuales no cambian.';

  @override
  String get settingsImportBackupConfirmButton => 'Importar';

  @override
  String settingsImportBackupDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Se importaron $count palabras.',
      one: 'Se importó $count palabra.',
    );
    return '$_temp0';
  }

  @override
  String get errorInvalidBackup => 'Este archivo no es una copia de seguridad de Vocabualize.';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageGerman => 'Alemán';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageFrench => 'Francés';

  @override
  String get languagePolish => 'Polaco';

  @override
  String languagePairLabel(String source, String target) {
    return '$source → $target';
  }

  @override
  String get languageSelectionTitle => 'Sus idiomas';

  @override
  String get languageSelectionContinueButton => 'Continuar';

  @override
  String get settingsLanguagesTitle => 'Idiomas';

  @override
  String get languageSelectionSaveButton => 'Guardar';
}
