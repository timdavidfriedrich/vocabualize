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
  String get errorConnection =>
      'No se pudo conectar con el servidor. Compruebe su conexión a internet e inténtelo de nuevo.';

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
  String get edit => 'Editar';

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
  String get languageSelectionSaveButton => 'Guardar';

  @override
  String get dataOfflineTitle => 'Sin conexión';

  @override
  String get dataOfflineMessage => 'Sus palabras se descargarán en cuanto tenga conexión.';

  @override
  String get dataRetryButton => 'Reintentar';

  @override
  String get dataSignInRequiredTitle => 'Inicie sesión de nuevo';

  @override
  String get dataSignInRequiredMessage =>
      'Su sesión ha caducado. Inicie sesión para cargar sus palabras.';

  @override
  String get dataSignInButton => 'Iniciar sesión';

  @override
  String get syncStatusServerUnreachable =>
      'No se puede acceder al servidor. Los cambios se sincronizarán cuando vuelva.';

  @override
  String get syncStatusClockWrong =>
      'El reloj de su teléfono no es correcto. Active la hora automática para seguir sincronizando.';

  @override
  String get syncStatusFailed =>
      'La sincronización falló. Sus palabras están seguras en este teléfono.';

  @override
  String get dataServerUnreachableTitle => 'Servidor no disponible';

  @override
  String get dataServerUnreachableMessage =>
      'No se puede acceder al servidor de Vocabualize en este momento. Sus palabras están seguras en este teléfono.';

  @override
  String get gateClockWrongTitle => 'El reloj de su teléfono no es correcto';

  @override
  String get gateClockWrongMessage =>
      'La sincronización necesita la hora correcta. Active la fecha y hora automáticas y luego vuelva.';

  @override
  String get gateOpenTimeSettingsButton => 'Abrir ajustes de hora';

  @override
  String get dataSyncFailedTitle => 'La sincronización falló';

  @override
  String get dataSyncFailedMessage =>
      'Algo salió mal al sincronizar. Sus palabras están seguras en este teléfono.';

  @override
  String get accountConflictTitle => '¿Cambiar de cuenta?';

  @override
  String accountConflictMessage(String previous, String next) {
    return 'En este teléfono había iniciado sesión como $previous. Los cambios que aún no se subieron pertenecen a esa cuenta. Se perderán si cambia a $next.';
  }

  @override
  String accountConflictKeepButton(String previous) {
    return 'Usar $previous en su lugar';
  }

  @override
  String accountConflictSwitchButton(String previous, String next) {
    return 'Borrar los datos de $previous y usar $next';
  }

  @override
  String get accountConflictUnknownAccount => 'cuenta desconocida';

  @override
  String get settingsSignInAgainButton => 'Iniciar sesión de nuevo';

  @override
  String loadingProgressLabel(int current, int total) {
    return '$current / $total';
  }

  @override
  String get errorClockWrong =>
      'El reloj de su teléfono no es correcto. Active la fecha y hora automáticas e inténtelo de nuevo.';

  @override
  String get homeAllDoneMessage => 'Todo listo por ahora';

  @override
  String get homeStatusFirstWordMessage =>
      '¡Has añadido tu primera palabra! Añade algunas más y pulsa «Practicar». :)';

  @override
  String get homeStatusEmptyMessage => '¿Por qué no añades algunas palabras nuevas? :)';

  @override
  String get homeStatusOnlyOneWordMessage =>
      'Tu colección contiene solo una palabra. Se siente sola. ¡Añade alguna más! :)';

  @override
  String homeStatusAddedTodayMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '¡Vaya, hoy ya has añadido $count palabras! ¡Sigue así!',
      one: '¡Vaya, hoy ya has añadido $count palabra! ¡Sigue así!',
    );
    return '$_temp0';
  }

  @override
  String homeStatusManyWordsMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '¡Vaya, has añadido $count palabras en total! ¡No está mal!',
      one: '¡Vaya, has añadido $count palabra en total! ¡No está mal!',
    );
    return '$_temp0';
  }

  @override
  String homeStatusDefaultMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tu colección contiene $count palabras.',
      one: 'Tu colección contiene $count palabra.',
    );
    return '$_temp0';
  }

  @override
  String homeNextDueTodayMessage(String time) {
    return 'Siguiente palabra a las $time';
  }

  @override
  String homeNextDueLaterMessage(String date) {
    return 'Siguiente palabra el $date';
  }

  @override
  String get vocabularySpeakTooltip => 'Leer en voz alta';

  @override
  String get errorTextToSpeechUnavailable =>
      'No hay ninguna voz instalada para este idioma en este teléfono.';

  @override
  String get detailsRetakeImageButton => 'Tomar otra imagen';

  @override
  String errorTranslationQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Ha usado sus $limit traducciones de las últimas 24 horas. Escriba la traducción usted mismo o vuelva a intentarlo más tarde.',
      one:
          'Ha usado su $limit traducción de las últimas 24 horas. Escriba la traducción usted mismo o vuelva a intentarlo más tarde.',
    );
    return '$_temp0';
  }

  @override
  String errorStockImageQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Ha usado sus $limit búsquedas de fotos de las últimas 24 horas. Tome su propia foto o vuelva a intentarlo más tarde.',
      one:
          'Ha usado su $limit búsqueda de fotos de las últimas 24 horas. Tome su propia foto o vuelva a intentarlo más tarde.',
    );
    return '$_temp0';
  }

  @override
  String get errorServiceUnavailable =>
      'Las sugerencias automáticas no están disponibles en este momento.';

  @override
  String get collectionsDeleteButton => 'Borrar colección';

  @override
  String get collectionsDeleteTitle => '¿Borrar la colección?';

  @override
  String get collectionsDeleteMessage => 'Las palabras se quedan. Solo se borra la colección.';

  @override
  String get scanTypeHint => 'Entrar palabra...';

  @override
  String get scanOpenSettingsButton => 'Abrir ajustes';

  @override
  String get errorCameraPermission => 'Permita el acceso a la cámara para hacer fotos.';

  @override
  String get errorCameraUnavailable => 'La cámara no se puede usar en este momento.';

  @override
  String errorImageLabelingQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Ha usado sus $limit escaneos de las últimas 24 horas. Escriba la palabra usted mismo o vuelva a intentarlo más tarde.',
      one:
          'Ha usado su $limit escaneo de las últimas 24 horas. Escriba la palabra usted mismo o vuelva a intentarlo más tarde.',
    );
    return '$_temp0';
  }

  @override
  String errorImageLabelingMonthlyQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Ha usado sus $limit escaneos de este mes. Escriba la palabra usted mismo o vuelva a intentarlo el próximo mes.',
      one:
          'Ha usado su $limit escaneo de este mes. Escriba la palabra usted mismo o vuelva a intentarlo el próximo mes.',
    );
    return '$_temp0';
  }

  @override
  String errorQuotaSignInForMore(String message) {
    return '$message Inicie sesión con Google para obtener más.';
  }

  @override
  String get connectToInternet => 'Conectarse a internet';

  @override
  String get scanOfflineMessage =>
      'Las sugerencias necesitan conexión a internet. También puedes escribir la palabra tú mismo.';

  @override
  String get detailsOfflineMessage =>
      'La traducción y la búsqueda de fotos necesitan conexión a internet.';

  @override
  String get welcomeOfflineMessage =>
      'Para iniciar sesión con Google necesita conexión a internet.';

  @override
  String get settingsSignInOfflineMessage => 'Para iniciar sesión necesita conexión a internet.';

  @override
  String get settingsSignOutOfflineMessage =>
      'Para cerrar sesión necesita conexión a internet, así sus últimos cambios se suben antes.';

  @override
  String get settingsPracticeReminderTitle => 'Recordatorio de práctica';

  @override
  String get settingsPracticeReminderHint => 'Solo los días con palabras para practicar';

  @override
  String get settingsReminderTimeTitle => 'Hora';

  @override
  String get settingsNotificationsBlockedMessage =>
      'Las notificaciones de Vocabualize están desactivadas.';

  @override
  String get settingsOpenNotificationSettingsButton => 'Abrir ajustes';

  @override
  String get reminderPracticeTitle => 'Hora de practicar';

  @override
  String get reminderPracticeBody => 'Tus palabras te esperan. Unos minutos las mantienen frescas.';

  @override
  String get reminderPracticeChannel => 'Recordatorios de práctica';

  @override
  String get errorReportLimit =>
      'Ha enviado varios informes recientemente. Vuelva a intentarlo más tarde.';

  @override
  String get errorReportUnavailable =>
      'No se pueden enviar informes en este momento. Vuelva a intentarlo más tarde.';

  @override
  String get reportFeedbackTitle => 'Comentarios y errores';

  @override
  String get reportFeedbackMessage => 'Cuéntanos qué te gusta, qué falta o qué ha fallado.';

  @override
  String get reportFeedbackFieldHint => 'Tu mensaje...';

  @override
  String get reportFeedbackContextHint =>
      'Se envía también: versión de la app, versión de Android, idioma de la app y tu par de idiomas.';

  @override
  String get reportSendButton => 'Enviar';

  @override
  String get reportFeedbackSentMessage => '¡Gracias! Tu mensaje se ha enviado.';

  @override
  String get reportTranslationSentMessage => '¡Gracias! La traducción se ha notificado.';

  @override
  String get reportOfflineMessage => 'Para enviar se necesita conexión a internet.';

  @override
  String get settingsFeedbackButton => 'Comentarios';

  @override
  String get settingsDeleteAccountButton => 'Eliminar cuenta';

  @override
  String get settingsDeleteDataButton => 'Eliminar todos los datos';

  @override
  String get settingsDeleteAccountTitle => '¿Eliminar cuenta?';

  @override
  String get settingsDeleteAccountMessage =>
      'Esto elimina para siempre su cuenta y todo su contenido en todos sus dispositivos: palabras, fotos, colecciones y progreso. No se puede deshacer.';

  @override
  String get settingsDeleteDataTitle => '¿Eliminar todos los datos?';

  @override
  String get settingsDeleteDataMessage =>
      'Esto elimina para siempre todas las palabras, fotos, colecciones y el progreso de este teléfono. No se puede deshacer.';

  @override
  String get settingsDeleteConfirmWord => 'ELIMINAR';

  @override
  String settingsDeleteConfirmHint(String word) {
    return 'Escriba $word para confirmar';
  }

  @override
  String get settingsDeleteConfirmButton => 'Eliminar';

  @override
  String get settingsDeleteAccountOfflineMessage =>
      'Para eliminar su cuenta necesita conexión a internet.';

  @override
  String streakTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Racha de $count días',
      one: 'Racha de $count día',
      zero: 'Aún sin racha',
    );
    return '$_temp0';
  }

  @override
  String get streakStartMessage => 'Practica o añade una palabra para empezar una racha.';

  @override
  String get streakDoneMessage => 'Ya has terminado por hoy. ¡Hasta mañana!';

  @override
  String get streakPendingMessage => 'Practica o añade una palabra hoy para mantener tu racha.';

  @override
  String get streakLongestLabel => 'Racha más larga';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '$count día',
    );
    return '$_temp0';
  }

  @override
  String get streakFreezesLabel => 'Protectores de racha';

  @override
  String streakFreezesValue(int count, int max) {
    return '$count de $max';
  }

  @override
  String streakFreezeExplanation(int days, int max) {
    return 'Cada $days días activos seguidos ganas un protector de racha (máx. $max). Salva tu racha si un día no practicas.';
  }

  @override
  String get streakDayActive => 'Activo';

  @override
  String get streakDayFrozen => 'Salvado por un protector';

  @override
  String get streakDayPending => 'Aún pendiente';

  @override
  String get streakDayMissed => 'Perdido';

  @override
  String get settingsStreakReminderTitle => 'Recordatorio de racha';

  @override
  String get settingsStreakReminderHint => 'Solo los días en que tu racha está en peligro';

  @override
  String get reminderStreakChannel => 'Recordatorios de racha';

  @override
  String get reminderStreakKeepTitle => 'Mantén tu racha';

  @override
  String reminderStreakKeepBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Practica unas palabras hoy para mantener tu racha de $count días.',
      one: 'Practica unas palabras hoy para mantener tu racha de $count día.',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakLookAroundTitle => 'Mira a tu alrededor';

  @override
  String get reminderStreakLookAroundBody =>
      '¿Ves algo que aún no sabes nombrar? Añádelo como palabra nueva.';

  @override
  String get reminderStreakQuickRoundTitle => '¿Una ronda rápida?';

  @override
  String reminderStreakQuickRoundBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Una ronda corta de práctica mantiene vivos tus $count días.',
      one: 'Una ronda corta de práctica mantiene viva tu racha.',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakNearbyTitle => '¿Una palabra nueva cerca?';

  @override
  String get reminderStreakNearbyBody => 'Elige algo a tu alrededor y aprende cómo se llama.';

  @override
  String reminderStreakInARowTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días seguidos',
      one: '$count día seguido',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakInARowBody => 'No pares ahora. Practica o añade una palabra hoy.';

  @override
  String get settingsPrivacyPolicyButton => 'Política de privacidad';

  @override
  String get scanReportSuggestionButton => 'Informar de una sugerencia';
}
