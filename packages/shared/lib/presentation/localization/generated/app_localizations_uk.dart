// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Vocabualize';

  @override
  String get cancel => 'Скасувати';

  @override
  String get close => 'Закрити';

  @override
  String get back => 'Назад';

  @override
  String get tryAgain => 'Спробувати ще раз';

  @override
  String get error => 'Помилка';

  @override
  String get errorConnection =>
      'Не вдалося з\'єднатися із сервером. Перевірте підключення до інтернету й спробуйте ще раз.';

  @override
  String errorApi(String message) {
    return 'Помилка зв\'язку із сервером: $message.';
  }

  @override
  String get errorAuth => 'Ви не увійшли в систему.';

  @override
  String get errorValidation => 'Отримані дані недійсні.';

  @override
  String get errorNotFound => 'Не знайдено.';

  @override
  String get errorUnexpected => 'Сталася неочікувана помилка.';

  @override
  String get unknown => 'невідомо';

  @override
  String get no => 'Ні';

  @override
  String get yes => 'Так';

  @override
  String get okay => 'Добре';

  @override
  String get submit => 'Надіслати';

  @override
  String get delete => 'Видалити';

  @override
  String get languagePickerTitle => 'Вибрати мову';

  @override
  String get vocabularyDeleteTitle => 'Видалити?';

  @override
  String get vocabularyDeleteMessage => 'Ви впевнені, що хочете видалити це слово?';

  @override
  String get vocabularyCreatedLabel => 'Створено:';

  @override
  String get vocabularyReappearsLabel => 'Повернеться:';

  @override
  String get vocabularyReappearsNow => 'Зараз';

  @override
  String get vocabularyReappearsLessThanMinute => 'Менше ніж за хвилину';

  @override
  String get notificationPracticeChannelName => 'Тренувати словниковий запас';

  @override
  String get notificationPracticeChannelDescription => 'Давайте тренуватися 🎯';

  @override
  String get notificationPracticeTitle => 'Давайте тренуватися 🎯';

  @override
  String get notificationPracticeBody =>
      'Можливо, деякі слова потребують повторення. Ви впораєтеся! :D';

  @override
  String get welcomeSourceLanguageTitle => 'Я говорю';

  @override
  String get welcomeTargetLanguageTitle => 'Я хочу вивчати';

  @override
  String get welcomeStartButton => 'Почнемо!';

  @override
  String get welcomeGoogleSignInButton => 'Увійти через Google';

  @override
  String get welcomeContinueWithoutAccountButton => 'Продовжити без облікового запису';

  @override
  String get welcomeSignInFailedTitle => 'Не вдалося увійти';

  @override
  String get homeCollectionsTitle => 'Колекції';

  @override
  String get homeAddFirstWordMessage => 'Натисніть кнопку,\nщоб додати ваше перше слово';

  @override
  String get homeAllWordsTitle => 'Усі слова';

  @override
  String get homeNewWordsTitle => 'Нещодавно додані';

  @override
  String get homePracticeButton => 'Тренуватися';

  @override
  String get homeScanButton => 'Сканувати';

  @override
  String get homeWriteButton => 'Писати';

  @override
  String get homeWriteHint => 'Введіть слово...';

  @override
  String get detailsSourceLabel => 'Джерело';

  @override
  String get detailsTargetLabel => 'Переклад';

  @override
  String get detailsReportTranslationButton => 'Повідомити про неправильний переклад';

  @override
  String get detailsAddCollectionButton => 'Додати до колекції';

  @override
  String get detailsReplaceTitle => 'Замінити';

  @override
  String get detailsReplaceMessage => 'Перекласти заново та замінити слово?';

  @override
  String get detailsDuplicateTitle => 'Дублікат!';

  @override
  String get detailsDuplicateAddButton => 'Додати';

  @override
  String get detailsNoImageMessage => 'Виберіть зображення\nабо збережіть без нього';

  @override
  String get detailsOpenGalleryButton => 'Відкрити галерею';

  @override
  String get detailsRemoveImageButton => 'Видалити зображення';

  @override
  String get detailsPexelsAttribution => 'Зображення надані Pexels.';

  @override
  String get detailsSaveButton => 'Зберегти';

  @override
  String get detailsSaveWithoutImageButton => 'Зберегти без';

  @override
  String get detailsTakePictureButton => 'Зробити фото';

  @override
  String get detailsCollectionNameHint => 'Без назви';

  @override
  String get detailsCollectionNameLabel => 'Назва тегу';

  @override
  String get practiceDoneTitle => 'Вітаємо!';

  @override
  String get practiceDoneMessage => 'Ви відпрацювали всі\nзаплановані слова.';

  @override
  String get practiceDoneButton => 'Готово';

  @override
  String get practiceForgotButton => 'Я не знав';

  @override
  String get practiceEasyButton => 'Легко';

  @override
  String get practiceGoodButton => 'Добре';

  @override
  String get practiceHardButton => 'Важко';

  @override
  String get practiceSolutionButton => 'Рішення';

  @override
  String get practiceAnswerLabel => 'Ваша відповідь';

  @override
  String get scanAddButton => 'Додати';

  @override
  String get scanSuggestionsTitle => 'Пропозиції';

  @override
  String get scanNoSuggestionsMessage =>
      'Жодних об\'єктів не розпізнано. Будь ласка, спробуйте пізніше.';

  @override
  String get reportTranslationTitle => 'Невірний переклад';

  @override
  String get reportTranslationNoteHint => 'Примітка (необов\'язково)';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get settingsSignInHint => 'Увійдіть, щоб синхронізувати ваші дані на всіх пристроях.';

  @override
  String get settingsSignInButton => 'Увійти';

  @override
  String get settingsTypeAnswerDisabledTitle => 'Вимкнути режим введення відповіді';

  @override
  String get settingsTypeAnswerDisabledHint =>
      'Використовувати лише режим запам\'ятовування з самооцінкою';

  @override
  String get settingsCollectionsTitle => 'Увімкнути колекції';

  @override
  String get settingsCollectionsHint => 'Групувати слова у колекції';

  @override
  String get settingsImagesHiddenTitle => 'Приховати зображення';

  @override
  String get settingsImagesHiddenHint => 'Може знизити якість навчання';

  @override
  String get settingsSourceLanguageTitle => 'Мова оригіналу';

  @override
  String get settingsSourceLanguageHint => 'Мова, яку ви добре знаєте';

  @override
  String get settingsTargetLanguageTitle => 'Мова перекладу';

  @override
  String get settingsTargetLanguageHint => 'Мова, яку ви вивчаєте';

  @override
  String get settingsNotificationsTitle => 'Сповіщення';

  @override
  String vocabularyReappearsInMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'За $count хвилини',
      many: 'За $count хвилин',
      few: 'За $count хвилини',
      one: 'За $count хвилину',
    );
    return '$_temp0';
  }

  @override
  String vocabularyReappearsInHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'За $count години',
      many: 'За $count годин',
      few: 'За $count години',
      one: 'За $count годину',
    );
    return '$_temp0';
  }

  @override
  String vocabularyReappearsInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'За $count дня',
      many: 'За $count днів',
      few: 'За $count дні',
      one: 'За $count день',
    );
    return '$_temp0';
  }

  @override
  String detailsDuplicateMessage(String word) {
    return 'Здається, що «$word» вже є у вашій колекції.\n\nДодати все одно?';
  }

  @override
  String detailsPhotoByLabel(String author) {
    return 'Фото від $author';
  }

  @override
  String get detailsReplaceButton => 'Замінити';

  @override
  String get settingsAccountTitle => 'Обліковий запис';

  @override
  String get errorSyncPending => 'Ваші останні зміни ще не завантажено.';

  @override
  String get settingsSignOutButton => 'Вийти';

  @override
  String get settingsSignOutBlockedTitle => 'Зміни не завантажено';

  @override
  String get settingsSignOutBlockedMessage =>
      'Деякі зміни ще не надійшли на сервер. Підключіться до інтернету й спробуйте ще раз. Якщо все одно вийти, ці зміни буде втрачено.';

  @override
  String get settingsSignOutAnywayButton => 'Усе одно вийти';

  @override
  String get syncStatusConnecting => 'Підключення…';

  @override
  String get syncStatusSynced => 'Усі зміни синхронізовано';

  @override
  String get syncStatusOffline => 'Офлайн. Зміни синхронізуються, щойно ви знову будете в мережі.';

  @override
  String get syncStatusUpdateRequired => 'Оновіть застосунок, щоб продовжити синхронізацію.';

  @override
  String get syncStatusSignInRequired =>
      'Ваш сеанс завершився. Увійдіть знову, щоб продовжити синхронізацію.';

  @override
  String get gateUpdateTitle => 'Потрібне оновлення';

  @override
  String get gateUpdateMessage =>
      'Ця версія Vocabualize більше не підтримується. Оновіть застосунок, щоб продовжити навчання.';

  @override
  String get gateUpdateButton => 'Оновити';

  @override
  String get gateMaintenanceTitle => 'Технічне обслуговування';

  @override
  String get gateMaintenanceMessage => 'Vocabualize оновлюється. Спробуйте пізніше.';

  @override
  String get settingsBackupTitle => 'Резервна копія';

  @override
  String get settingsExportBackupButton => 'Експортувати резервну копію';

  @override
  String get settingsExportBackupHint => 'Зберегти всі слова та зображення у файл';

  @override
  String get settingsImportBackupButton => 'Імпортувати резервну копію';

  @override
  String get settingsImportBackupHint => 'Додати слова з файлу резервної копії';

  @override
  String get settingsImportBackupConfirmTitle => 'Імпортувати резервну копію?';

  @override
  String get settingsImportBackupConfirmMessage =>
      'Усі слова, колекції та зображення з резервної копії буде додано до вашої колекції. Ваші наявні слова не зміняться.';

  @override
  String get settingsImportBackupConfirmButton => 'Імпортувати';

  @override
  String settingsImportBackupDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Імпортовано $count слова.',
      many: 'Імпортовано $count слів.',
      few: 'Імпортовано $count слова.',
      one: 'Імпортовано $count слово.',
    );
    return '$_temp0';
  }

  @override
  String get errorInvalidBackup => 'Цей файл не є резервною копією Vocabualize.';

  @override
  String get languageEnglish => 'Англійська';

  @override
  String get languageGerman => 'Німецька';

  @override
  String get languageSpanish => 'Іспанська';

  @override
  String get languageFrench => 'Французька';

  @override
  String get languagePolish => 'Польська';

  @override
  String languagePairLabel(String source, String target) {
    return '$source → $target';
  }

  @override
  String get languageSelectionTitle => 'Ваші мови';

  @override
  String get languageSelectionContinueButton => 'Продовжити';

  @override
  String get settingsLanguagesTitle => 'Мови';

  @override
  String get languageSelectionSaveButton => 'Зберегти';

  @override
  String get dataOfflineTitle => 'Немає з\'єднання';

  @override
  String get dataOfflineMessage => 'Ваші слова завантажаться, щойно з\'явиться з\'єднання.';

  @override
  String get dataRetryButton => 'Спробувати ще раз';

  @override
  String get dataSignInRequiredTitle => 'Увійдіть знову';

  @override
  String get dataSignInRequiredMessage =>
      'Ваш сеанс завершився. Увійдіть, щоб завантажити свої слова.';

  @override
  String get dataSignInButton => 'Увійти';

  @override
  String get syncStatusServerUnreachable =>
      'Сервер недоступний. Зміни синхронізуються, щойно він знову працюватиме.';

  @override
  String get syncStatusClockWrong =>
      'Годинник вашого телефона показує неправильний час. Увімкніть автоматичний час, щоб продовжити синхронізацію.';

  @override
  String get syncStatusFailed =>
      'Не вдалося синхронізувати. Ваші слова збережено на цьому телефоні.';

  @override
  String get dataServerUnreachableTitle => 'Сервер недоступний';

  @override
  String get dataServerUnreachableMessage =>
      'Сервер Vocabualize зараз недоступний. Ваші слова збережено на цьому телефоні.';

  @override
  String get gateClockWrongTitle => 'Неправильний час на телефоні';

  @override
  String get gateClockWrongMessage =>
      'Для синхронізації потрібен правильний час. Увімкніть автоматичні дату й час і поверніться.';

  @override
  String get gateOpenTimeSettingsButton => 'Відкрити налаштування часу';

  @override
  String get dataSyncFailedTitle => 'Не вдалося синхронізувати';

  @override
  String get dataSyncFailedMessage =>
      'Під час синхронізації сталася помилка. Ваші слова збережено на цьому телефоні.';

  @override
  String get accountConflictTitle => 'Змінити обліковий запис?';

  @override
  String accountConflictMessage(String previous, String next) {
    return 'На цьому телефоні ви входили як $previous. Ще не завантажені зміни належать цьому обліковому запису. Вони будуть втрачені, якщо ви перейдете на $next.';
  }

  @override
  String accountConflictKeepButton(String previous) {
    return 'Використати $previous';
  }

  @override
  String accountConflictSwitchButton(String previous, String next) {
    return 'Видалити дані $previous і використати $next';
  }

  @override
  String get accountConflictUnknownAccount => 'невідомий обліковий запис';

  @override
  String get settingsSignInAgainButton => 'Увійти знову';

  @override
  String loadingProgressLabel(int current, int total) {
    return '$current / $total';
  }

  @override
  String get errorClockWrong =>
      'Годинник вашого телефона показує неправильний час. Увімкніть автоматичні дату й час і спробуйте ще раз.';

  @override
  String homeDueMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count слова для повторення',
      many: '$count слів для повторення',
      few: '$count слова для повторення',
      one: '$count слово для повторення',
    );
    return '$_temp0';
  }

  @override
  String get homeAllDoneMessage => 'Поки що все готово';

  @override
  String homeTotalWordsMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Усього $count слова',
      many: 'Усього $count слів',
      few: 'Усього $count слова',
      one: 'Усього $count слово',
    );
    return '$_temp0';
  }

  @override
  String homeNextDueTodayMessage(String time) {
    return 'Наступне слово о $time';
  }

  @override
  String homeNextDueLaterMessage(String date) {
    return 'Наступне слово $date';
  }

  @override
  String get vocabularySpeakTooltip => 'Прочитати вголос';

  @override
  String get errorTextToSpeechUnavailable =>
      'На цьому телефоні не встановлено голос для цієї мови.';

  @override
  String get detailsRetakeImageButton => 'Зробити інше фото';

  @override
  String errorTranslationQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Ви використали $limit перекладу за останні 24 години. Введіть переклад самостійно або спробуйте пізніше.',
      many:
          'Ви використали $limit перекладів за останні 24 години. Введіть переклад самостійно або спробуйте пізніше.',
      few:
          'Ви використали $limit переклади за останні 24 години. Введіть переклад самостійно або спробуйте пізніше.',
      one:
          'Ви використали $limit переклад за останні 24 години. Введіть переклад самостійно або спробуйте пізніше.',
    );
    return '$_temp0';
  }

  @override
  String errorStockImageQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Ви використали $limit пошуку фото за останні 24 години. Зробіть власне фото або спробуйте пізніше.',
      many:
          'Ви використали $limit пошуків фото за останні 24 години. Зробіть власне фото або спробуйте пізніше.',
      few:
          'Ви використали $limit пошуки фото за останні 24 години. Зробіть власне фото або спробуйте пізніше.',
      one:
          'Ви використали $limit пошук фото за останні 24 години. Зробіть власне фото або спробуйте пізніше.',
    );
    return '$_temp0';
  }

  @override
  String get errorServiceUnavailable => 'Автоматичні пропозиції зараз недоступні.';

  @override
  String get collectionsDeleteButton => 'Видалити колекцію';

  @override
  String get collectionsDeleteTitle => 'Видалити колекцію?';

  @override
  String get collectionsDeleteMessage => 'Слова залишаться. Буде видалено лише колекцію.';

  @override
  String get scanTypeHint => 'Введіть слово...';

  @override
  String get scanOpenSettingsButton => 'Відкрити налаштування';

  @override
  String get errorCameraPermission => 'Дозвольте доступ до камери, щоб фотографувати.';

  @override
  String get errorCameraUnavailable => 'Камерою зараз неможливо скористатися.';

  @override
  String errorImageLabelingQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Ви використали $limit сканування за останні 24 години. Введіть слово самостійно або спробуйте пізніше.',
      many:
          'Ви використали $limit сканувань за останні 24 години. Введіть слово самостійно або спробуйте пізніше.',
      few:
          'Ви використали $limit сканування за останні 24 години. Введіть слово самостійно або спробуйте пізніше.',
      one:
          'Ви використали $limit сканування за останні 24 години. Введіть слово самостійно або спробуйте пізніше.',
    );
    return '$_temp0';
  }

  @override
  String errorImageLabelingMonthlyQuotaExceeded(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other:
          'Ви використали $limit сканування цього місяця. Введіть слово самостійно або спробуйте наступного місяця.',
      many:
          'Ви використали $limit сканувань цього місяця. Введіть слово самостійно або спробуйте наступного місяця.',
      few:
          'Ви використали $limit сканування цього місяця. Введіть слово самостійно або спробуйте наступного місяця.',
      one:
          'Ви використали $limit сканування цього місяця. Введіть слово самостійно або спробуйте наступного місяця.',
    );
    return '$_temp0';
  }

  @override
  String errorQuotaSignInForMore(String message) {
    return '$message Увійдіть через Google, щоб отримати більше.';
  }

  @override
  String get connectToInternet => 'Під\'єднатися до інтернету';

  @override
  String get scanOfflineMessage =>
      'Для пропозицій потрібне підключення до інтернету. Ви також можете ввести слово самостійно.';

  @override
  String get detailsOfflineMessage =>
      'Для перекладу й пошуку фото потрібне підключення до інтернету.';

  @override
  String get welcomeOfflineMessage => 'Для входу через Google потрібне підключення до інтернету.';

  @override
  String get settingsSignInOfflineMessage => 'Для входу потрібне підключення до інтернету.';

  @override
  String get settingsSignOutOfflineMessage =>
      'Для виходу потрібне підключення до інтернету, щоб спершу завантажити ваші останні зміни.';

  @override
  String get settingsLearningTitle => 'Навчання';

  @override
  String get settingsPracticeReminderTitle => 'Нагадування про практику';

  @override
  String get settingsPracticeReminderHint => 'Лише в дні, коли є слова для практики';

  @override
  String get settingsReminderTimeTitle => 'Час';

  @override
  String get settingsNotificationsBlockedMessage => 'Сповіщення для Vocabualize вимкнено.';

  @override
  String get settingsOpenNotificationSettingsButton => 'Відкрити налаштування';

  @override
  String get reminderPracticeTitle => 'Час практикуватися';

  @override
  String get reminderPracticeBody => 'Ваші слова чекають. Кілька хвилин допоможуть їх не забути.';

  @override
  String get reminderPracticeChannel => 'Нагадування про практику';

  @override
  String get errorReportLimit => 'Ви нещодавно надіслали кілька звітів. Спробуйте пізніше.';

  @override
  String get errorReportUnavailable => 'Звіти зараз неможливо надіслати. Спробуйте пізніше.';

  @override
  String get reportFeedbackTitle => 'Відгуки та помилки';

  @override
  String get reportFeedbackMessage =>
      'Розкажіть, що вам подобається, чого бракує або що пішло не так.';

  @override
  String get reportFeedbackFieldHint => 'Ваше повідомлення...';

  @override
  String get reportFeedbackContextHint =>
      'Також надсилаються: версія застосунку, версія Android, мова застосунку та ваша мовна пара.';

  @override
  String get reportSendButton => 'Надіслати';

  @override
  String get reportFeedbackSentMessage => 'Дякуємо! Ваше повідомлення надіслано.';

  @override
  String get reportTranslationSentMessage => 'Дякуємо! Про переклад повідомлено.';

  @override
  String get reportOfflineMessage => 'Для надсилання потрібне підключення до інтернету.';

  @override
  String get settingsFeedbackButton => 'Відгуки та помилки';

  @override
  String get settingsFeedbackHint => 'Ідеї, проблеми або запитання';

  @override
  String get settingsDeleteAccountButton => 'Видалити обліковий запис';

  @override
  String get settingsDeleteDataButton => 'Видалити всі дані';

  @override
  String get settingsDeleteAccountTitle => 'Видалити обліковий запис?';

  @override
  String get settingsDeleteAccountMessage =>
      'Це назавжди видалить ваш обліковий запис і все в ньому на всіх ваших пристроях: слова, фото, колекції та прогрес. Цю дію не можна скасувати.';

  @override
  String get settingsDeleteDataTitle => 'Видалити всі дані?';

  @override
  String get settingsDeleteDataMessage =>
      'Це назавжди видалить усі слова, фото, колекції та прогрес на цьому телефоні. Цю дію не можна скасувати.';

  @override
  String get settingsDeleteConfirmWord => 'ВИДАЛИТИ';

  @override
  String settingsDeleteConfirmHint(String word) {
    return 'Введіть $word, щоб підтвердити';
  }

  @override
  String get settingsDeleteConfirmButton => 'Видалити';

  @override
  String get settingsDeleteAccountOfflineMessage =>
      'Для видалення облікового запису потрібне підключення до інтернету.';
}
