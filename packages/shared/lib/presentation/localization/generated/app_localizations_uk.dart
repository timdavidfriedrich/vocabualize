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
  String get edit => 'Редагувати';

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
  String get homeLookAroundTitle => 'Роззирніться навколо!\nЩо ви бачите?';

  @override
  String get homeAllWordsTitle => 'Усі слова';

  @override
  String get homeNewWordsTitle => 'Нові слова';

  @override
  String get homePracticeButton => 'Тренуватися';

  @override
  String get homeScanButton => 'Сканувати';

  @override
  String get homeWriteButton => 'Писати';

  @override
  String get homeWriteHint => 'Введіть слово...';

  @override
  String get detailsReportTranslationButton => 'Повідомити про неправильний переклад';

  @override
  String get detailsReplaceTitle => 'Замінити';

  @override
  String get detailsReplaceMessage => 'Перекласти заново та замінити слово?';

  @override
  String get detailsDuplicateTitle => 'Дублікат!';

  @override
  String get detailsDuplicateAddButton => 'Додати';

  @override
  String get detailsOpenGalleryButton => 'З галереї';

  @override
  String get detailsRemoveImageButton => 'Видалити зображення';

  @override
  String get detailsPexelsAttribution => 'Зображення надані Pexels';

  @override
  String get detailsSaveButton => 'Зберегти';

  @override
  String get detailsTakePictureButton => 'Зробити фото';

  @override
  String get detailsCollectionNameHint => 'Без назви';

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
  String get settingsStrictCorrectionTitle => 'Сувора перевірка';

  @override
  String get settingsStrictCorrectionHint =>
      'Наголоси та спеціальні символи потрібно вводити точно';

  @override
  String get settingsCollectionsTitle => 'Увімкнути колекції';

  @override
  String get settingsCollectionsHint => 'Групувати слова у колекції';

  @override
  String get settingsImagesHiddenTitle => 'Приховати зображення';

  @override
  String get settingsImagesHiddenHint => 'Може знизити якість навчання';

  @override
  String get settingsDefaultGatherTitle => 'Спосіб додавання за замовчуванням';

  @override
  String get settingsDefaultGatherHint =>
      'Кнопка + запускає одразу, довге натискання показує всі варіанти';

  @override
  String get settingsDefaultGatherNone => 'Немає';

  @override
  String get settingsAppearanceTitle => 'Оформлення';

  @override
  String get settingsAppearanceHint => 'Світле, темне або як на телефоні';

  @override
  String get settingsAppearanceSystem => 'Системне';

  @override
  String get settingsAppearanceLight => 'Світле';

  @override
  String get settingsAppearanceDark => 'Темне';

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
  String vocabularyPhotoByLabel(String author) {
    return 'Фото від $author';
  }

  @override
  String get detailsReplaceButton => 'Замінити';

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
  String get syncStatusSyncing => 'Синхронізація…';

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
  String get languageEnglishUk => 'Англійська (Велика Британія)';

  @override
  String get languageEnglishUs => 'Англійська (США)';

  @override
  String get languageSpanishSpain => 'Іспанська (Іспанія)';

  @override
  String get languageSpanishLatinAmerica => 'Іспанська (Латинська Америка)';

  @override
  String get languageFrenchFrance => 'Французька (Франція)';

  @override
  String get languageFrenchCanada => 'Французька (Канада)';

  @override
  String get languageGermanGermany => 'Німецька (Німеччина)';

  @override
  String get languageGermanSwitzerland => 'Німецька (Швейцарія)';

  @override
  String get languagePolish => 'Польська';

  @override
  String get languageItalian => 'Італійська';

  @override
  String get languageGreek => 'Грецька';

  @override
  String get languageRomanian => 'Румунська';

  @override
  String languagePairLabel(String source, String target) {
    return '$source → $target';
  }

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
  String get homeAllDoneMessage => 'Поки що все готово';

  @override
  String get homeStatusFirstWordMessage =>
      'Ви додали своє перше слово! Додайте ще й натисніть «Тренуватися»! :)';

  @override
  String get homeStatusEmptyMessage => 'Чому б не додати кілька нових слів? :)';

  @override
  String get homeStatusOnlyOneWordMessage =>
      'Ваша колекція містить лише одне слово. Воно почувається самотнім. Додайте ще! :)';

  @override
  String homeStatusAddedTodayMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Вау, сьогодні ви вже додали $count слова. Так тримати!',
      many: 'Вау, сьогодні ви вже додали $count слів. Так тримати!',
      few: 'Вау, сьогодні ви вже додали $count слова. Так тримати!',
      one: 'Вау, сьогодні ви вже додали $count слово. Так тримати!',
    );
    return '$_temp0';
  }

  @override
  String homeStatusManyWordsMessage(int count, String language) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ти вже додав $count слова мовою $language, чудово!',
      many: 'Ти вже додав $count слів мовою $language, чудово!',
      few: 'Ти вже додав $count слова мовою $language, чудово!',
      one: 'Ти вже додав $count слово мовою $language, чудово!',
    );
    return '$_temp0';
  }

  @override
  String homeStatusDefaultMessage(int count, String language) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'У тебе $count слова мовою $language.',
      many: 'У тебе $count слів мовою $language.',
      few: 'У тебе $count слова мовою $language.',
      one: 'У тебе $count слово мовою $language.',
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
  String get vocabularyTranslationPendingLabel => 'Переклад очікується';

  @override
  String get vocabularySearchTooltip => 'Пошук';

  @override
  String get vocabularySearchHint => 'Пошук слів...';

  @override
  String get vocabularySearchClearTooltip => 'Очистити';

  @override
  String get vocabularySearchEmptyMessage => 'Жодне слово не відповідає вашому пошуку.';

  @override
  String get vocabularyFilterDueLabel => 'До повторення';

  @override
  String get vocabularyLevelNovice => 'Нові';

  @override
  String get vocabularyLevelBeginner => 'Початковий';

  @override
  String get vocabularyLevelAdvanced => 'Просунутий';

  @override
  String get vocabularyLevelExpert => 'Експерт';

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

  @override
  String streakTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня поспіль',
      many: '$count днів поспіль',
      few: '$count дні поспіль',
      one: '$count день поспіль',
      zero: 'Ще немає серії',
    );
    return '$_temp0';
  }

  @override
  String get streakLongestLabel => 'Найдовша серія';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня',
      many: '$count днів',
      few: '$count дні',
      one: '$count день',
    );
    return '$_temp0';
  }

  @override
  String get streakFreezesLabel => 'Заморозки серії';

  @override
  String streakFreezesValue(int count, int max) {
    return '$count з $max';
  }

  @override
  String streakFreezeExplanation(int days, int max) {
    return 'Кожні $days активних днів поспіль ви отримуєте заморозку серії, до $max. Вона зберігає серію в день, який ви пропустили.';
  }

  @override
  String get streakDayActive => 'Активний';

  @override
  String get streakDayFrozen => 'Збережено заморозкою';

  @override
  String get streakDayPending => 'Ще відкритий';

  @override
  String get streakDayMissed => 'Пропущено';

  @override
  String get settingsStreakReminderTitle => 'Нагадування про серію';

  @override
  String get settingsStreakReminderHint => 'Лише в дні, коли ваша серія під загрозою';

  @override
  String get reminderStreakChannel => 'Нагадування про серію';

  @override
  String get reminderStreakKeepTitle => 'Збережіть свою серію';

  @override
  String reminderStreakKeepBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Попрактикуйте кілька слів сьогодні, щоб зберегти серію в $count дня.',
      many: 'Попрактикуйте кілька слів сьогодні, щоб зберегти серію в $count днів.',
      few: 'Попрактикуйте кілька слів сьогодні, щоб зберегти серію в $count дні.',
      one: 'Попрактикуйте кілька слів сьогодні, щоб зберегти серію в $count день.',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakLookAroundTitle => 'Роззирніться';

  @override
  String get reminderStreakLookAroundBody =>
      'Бачите щось, чого ще не вмієте назвати? Додайте це як нове слово.';

  @override
  String get reminderStreakQuickRoundTitle => 'Швидкий раунд?';

  @override
  String reminderStreakQuickRoundBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Один короткий раунд практики збереже ваші $count дня.',
      many: 'Один короткий раунд практики збереже ваші $count днів.',
      few: 'Один короткий раунд практики збереже ваші $count дні.',
      one: 'Один короткий раунд практики збереже вашу серію.',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakNearbyTitle => 'Нове слово поруч?';

  @override
  String get reminderStreakNearbyBody =>
      'Виберіть щось навколо себе і дізнайтеся, як воно називається.';

  @override
  String reminderStreakInARowTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня поспіль',
      many: '$count днів поспіль',
      few: '$count дні поспіль',
      one: '$count день поспіль',
    );
    return '$_temp0';
  }

  @override
  String get reminderStreakInARowBody =>
      'Не зупиняйтеся зараз. Попрактикуйтеся або додайте слово сьогодні.';

  @override
  String get settingsPrivacyPolicyButton => 'Політика конфіденційності';

  @override
  String get scanReportSuggestionButton => 'Поскаржитися на пропозицію';

  @override
  String get languagesTitle => 'Ваші мови';

  @override
  String get languagesSpeakTitle => 'Я розмовляю';

  @override
  String get languagesLearnTitle => 'Я вивчаю';

  @override
  String get languagesLearnHint => 'Обери одну або кілька';

  @override
  String get languagesContinueButton => 'Продовжити';

  @override
  String get languagesPausedTitle => 'Призупинені';

  @override
  String get languagesChangeButton => 'Змінити';

  @override
  String get languagesAddButton => 'Додати мову';

  @override
  String languagesWordCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count слова',
      many: '$count слів',
      few: '$count слова',
      one: '$count слово',
    );
    return '$_temp0';
  }

  @override
  String get languagesPickTitle => 'Оберіть мову';

  @override
  String get learnedLanguageAskMeInLabel => 'Питати мене мовою';

  @override
  String get learnedLanguageAddAskMeInButton => 'Питати мене іншою мовою';

  @override
  String learnedLanguageAskMeInHelpMessage(String askMeIn, String main, String learned) {
    return 'Картки питають мовою $askMeIn замість $main для слів, які ви вже добре знаєте мовою $askMeIn. Ви завжди можете показати слово мовою $main. Так ваша $askMeIn залишається активною, поки ви вивчаєте $learned.';
  }

  @override
  String get learnedLanguageAskMeInHelpTooltip => 'Що це означає?';

  @override
  String get learnedLanguageRemoveAskMeInTooltip => 'Прибрати';

  @override
  String get learnedLanguageNewWordsTitle => 'Нових слів за тренування';

  @override
  String get learnedLanguageAllNewWords => 'Усі';

  @override
  String learnedLanguagePauseButton(String language) {
    return 'Поставити $language на паузу';
  }

  @override
  String learnedLanguageResumeButton(String language) {
    return 'Відновити: $language';
  }

  @override
  String get learnedLanguageLastActiveHint => 'Потрібна принаймні одна мова для вивчення.';

  @override
  String get learnedLanguageStartOverButton => 'Почати спочатку';

  @override
  String get languageWordsAllOption => 'Усі слова';

  @override
  String get languageWordsNoneOption => 'Жодних';

  @override
  String get languageWordsUntaggedLabel => 'Поза колекціями';

  @override
  String get languageWordsSaveButton => 'Зберегти';

  @override
  String languageWordsNoWordsHint(String language) {
    return 'У вас ще немає слів. Слова, які ви додасте, ви вивчатимете також мовою $language.';
  }

  @override
  String get homeManageLanguagesButton => 'Керувати мовами';

  @override
  String homeEmptyLanguageMessage(int count, String source, String language) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'У тебе $count слова мовою $source. Імпортуй ті, які хочеш вивчати ще й мовою $language.',
      many:
          'У тебе $count слів мовою $source. Імпортуй ті, які хочеш вивчати ще й мовою $language.',
      few:
          'У тебе $count слова мовою $source. Імпортуй ті, які хочеш вивчати ще й мовою $language.',
      one:
          'У тебе $count слово мовою $source. Імпортуй ті, які хочеш вивчати ще й мовою $language.',
    );
    return '$_temp0';
  }

  @override
  String get homeChooseWordsButton => 'Обрати слова';

  @override
  String learnedLanguageAskMeInAlwaysHelpMessage(String askMeIn, String main, String learned) {
    return 'Картки питають мовою $askMeIn замість $main. Ви завжди можете показати слово мовою $main. Так ваша $askMeIn залишається активною, поки ви вивчаєте $learned.';
  }

  @override
  String detailsLearnSwitchLabel(String language) {
    return 'Вивчати мовою $language';
  }

  @override
  String get detailsExistingTitle => 'Уже збережено';

  @override
  String detailsExistingMessage(String word, String language, String translation, String target) {
    return '«$word» уже збережено ($language: $translation). Додати до мови $target?';
  }

  @override
  String detailsExistingAddButton(String language) {
    return 'Додати до $language';
  }

  @override
  String get practiceCustomTooltip => 'Власне тренування';

  @override
  String get customPracticeTitle => 'Власне тренування';

  @override
  String get customPracticeAllOption => 'Усі';

  @override
  String get customPracticeCollectionsTitle => 'Колекції';

  @override
  String customPracticeStartButton(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Практикувати $count слова',
      many: 'Практикувати $count слів',
      few: 'Практикувати $count слова',
      one: 'Практикувати $count слово',
      zero: 'Немає слів для практики',
    );
    return '$_temp0';
  }

  @override
  String get customPracticeReplaceTitle => 'Замінити ваше власне тренування?';

  @override
  String get customPracticeReplaceMessage =>
      'Ваше незавершене власне тренування закінчиться, коли ви почнете нове.';

  @override
  String get customPracticeReplaceButton => 'Почати нове';

  @override
  String homeCustomPracticeProgress(int remaining, int total) {
    return 'Залишилось $remaining з $total';
  }

  @override
  String get homeCustomPracticeContinueButton => 'Продовжити';

  @override
  String get homeCustomPracticeEndButton => 'Завершити';

  @override
  String practiceIntroSkipButton(String language) {
    return 'Пропустити в мові $language';
  }

  @override
  String get practiceIntroGotItButton => 'Зрозуміло';

  @override
  String practiceShowMainButton(String language) {
    return 'Показати мовою $language';
  }

  @override
  String collectionEmptyLanguageMessage(String language) {
    return 'Жодне з цих слів ще не додано до мови $language.';
  }

  @override
  String get languageEnglish => 'Англійська';

  @override
  String get languageSpanish => 'Іспанська';

  @override
  String get languageFrench => 'Французька';

  @override
  String get languageGerman => 'Німецька';

  @override
  String photoStackMoreLabel(String count) {
    return '+$count';
  }

  @override
  String get languageOnboardingSpeakTitle => 'Якою мовою ти розмовляєш?';

  @override
  String get languageOnboardingLearnTitle => 'Що ти хочеш вивчати?';

  @override
  String languageOnboardingContinueWithButton(int count) {
    return 'Продовжити з $count';
  }

  @override
  String get languagesPauseAction => 'Пауза';

  @override
  String languagesAsksInLabel(String flag) {
    return 'Питає мовою $flag';
  }

  @override
  String languagesPausedWordCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count слова, прогрес збережено',
      many: '$count слів, прогрес збережено',
      few: '$count слова, прогрес збережено',
      one: '$count слово, прогрес збережено',
    );
    return '$_temp0';
  }

  @override
  String get languagesContinueWhereLeftOffButton => 'Продовжити з того ж місця';

  @override
  String languageDeleteButton(String language) {
    return 'Видалити: $language';
  }

  @override
  String languageDeleteTitle(String language) {
    return 'Видалити: $language?';
  }

  @override
  String get languageDeleteDeletedLabel => 'Видаляється';

  @override
  String languageDeleteProgressLine(String language, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Прогрес мовою $language для $count слова',
      many: 'Прогрес мовою $language для $count слів',
      few: 'Прогрес мовою $language для $count слів',
      one: 'Прогрес мовою $language для $count слова',
    );
    return '$_temp0';
  }

  @override
  String get languageDeleteKeptLabel => 'Залишається';

  @override
  String get languageDeleteWordsLine => 'Усі слова, фото та колекції';

  @override
  String languageDeleteKeptProgressLine(String language) {
    return 'Твій прогрес мовою $language';
  }

  @override
  String get mainLanguageClashEmphasis => 'вивчаєш';

  @override
  String mainLanguageClashTitle(String emphasis, String language) {
    return 'Ти $emphasis $language';
  }

  @override
  String mainLanguageClashMessage(String language, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Щоб розмовляти мовою $language, $language ставиться на паузу як мова вивчення. Твої $count слова і їхній прогрес збережено.',
      many:
          'Щоб розмовляти мовою $language, $language ставиться на паузу як мова вивчення. Твої $count слів і їхній прогрес збережено.',
      few:
          'Щоб розмовляти мовою $language, $language ставиться на паузу як мова вивчення. Твої $count слова і їхній прогрес збережено.',
      one:
          'Щоб розмовляти мовою $language, $language ставиться на паузу як мова вивчення. Твоє $count слово і його прогрес збережено.',
    );
    return '$_temp0';
  }

  @override
  String mainLanguageClashSwitchButton(String language) {
    return 'Поставити $language на паузу і змінити';
  }

  @override
  String mainLanguageClashKeepButton(String language) {
    return 'Залишити $language';
  }

  @override
  String learnedLanguageAskMeInFromRole(String level) {
    return 'Питай мовою, від рівня $level';
  }

  @override
  String get learnedLanguageFromLevelTitle => 'Від рівня';

  @override
  String learnedLanguageBelowLevelHint(String language) {
    return 'Слова нижче цього рівня питають мовою $language.';
  }

  @override
  String learnedLanguageAskMeInIntroMessage(String main, String learned) {
    return 'Картки можуть питати іншою мовою замість $main. Слово мовою $main завжди можна показати. Так ще одна мова залишається активною, поки ти вивчаєш $learned.';
  }

  @override
  String learnedLanguagePausedMessage(String language) {
    return '$language на паузі';
  }

  @override
  String get undo => 'Скасувати';

  @override
  String learnedLanguagePausedHint(String language, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$language приховано з головної та з практики. Прогрес для $count слова збережено.',
      many: '$language приховано з головної та з практики. Прогрес для $count слів збережено.',
      few: '$language приховано з головної та з практики. Прогрес для $count слів збережено.',
      one: '$language приховано з головної та з практики. Прогрес для $count слова збережено.',
    );
    return '$_temp0';
  }

  @override
  String get learnedLanguageImportedWordsTitle => 'Імпортовані слова';

  @override
  String learnedLanguageTotalWordsHint(int count) {
    return 'Усього в тебе $count';
  }

  @override
  String get languageWordsManageTitle => 'Керувати словами';

  @override
  String languageWordsImportButton(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Імпортувати $count слова',
      many: 'Імпортувати $count слів',
      few: 'Імпортувати $count слова',
      one: 'Імпортувати $count слово',
      zero: 'Почати без слів',
    );
    return '$_temp0';
  }

  @override
  String languageWordsImportTitle(String language) {
    return 'Які слова ти хочеш імпортувати до мови $language?';
  }

  @override
  String get languageWordsImportHint => 'Це можна змінити пізніше.';

  @override
  String get languageWordsSomeCollectionsOption => 'Деякі колекції';

  @override
  String get languageWordsNoneHint => 'Почати з порожнього списку';

  @override
  String languageWordsAddedLabel(String count) {
    return '+$count';
  }

  @override
  String languageWordsRemovedLabel(String count) {
    return '−$count';
  }

  @override
  String languageWordsImportedCount(int count, int total) {
    return 'Імпортовано $count з $total слів';
  }

  @override
  String languageWordsRemovedWarning(int count, String language) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count слова, прогрес мовою $language видаляється',
      many: '$count слів, прогрес мовою $language видаляється',
      few: '$count слова, прогрес мовою $language видаляється',
      one: '$count слово, прогрес мовою $language видаляється',
    );
    return '$_temp0';
  }

  @override
  String homeEmptyLanguageTitle(String language) {
    return 'Жодного твого слова ще немає мовою $language';
  }

  @override
  String homeEmptyLanguageNoSourceMessage(String language) {
    return 'Імпортуй слова, які хочеш вивчати мовою $language.';
  }

  @override
  String get homeImportWordsButton => 'Імпортувати слова';

  @override
  String homeEmptyLanguageFeedHint(String language) {
    return 'Слова, які ти додаєш, поки вибрано $language, з\'являться тут.';
  }

  @override
  String practiceQuestionTitle(String language) {
    return 'Як це слово мовою $language?';
  }

  @override
  String practiceIntroBadge(String language) {
    return 'Нове: $language';
  }

  @override
  String customPracticeWordsLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'слова',
      many: 'слів',
      few: 'слова',
      one: 'слово',
    );
    return '$_temp0';
  }

  @override
  String customPracticeDueLegend(int count) {
    return 'до повторення $count';
  }

  @override
  String customPracticeAllLegend(int count) {
    return 'усі $count';
  }

  @override
  String customPracticeNewLegend(int count) {
    return 'нові $count';
  }

  @override
  String get customPracticeDueLabel => 'До повторення';

  @override
  String get customPracticeAllWordsLabel => 'Усі слова';

  @override
  String get customPracticeNewLabel => 'Нові';

  @override
  String get customPracticeFewerTooltip => 'Менше';

  @override
  String get customPracticeMoreTooltip => 'Більше';

  @override
  String get customPracticeDoneButton => 'Готово';

  @override
  String detailsNotLearningLabel(String language) {
    return '$language, не вивчаю це слово';
  }

  @override
  String detailsLanguageRoleLabel(String language, String role) {
    return '$language, $role';
  }

  @override
  String get homeCustomPracticeEndTitle => 'Завершити ваше власне тренування?';

  @override
  String homeCustomPracticeEndMessage(int remaining) {
    String _temp0 = intl.Intl.pluralLogic(
      remaining,
      locale: localeName,
      other: 'Залишилось ще $remaining слова.',
      many: 'Залишилось ще $remaining слів.',
      few: 'Залишилось ще $remaining слова.',
      one: 'Залишилось ще $remaining слово.',
    );
    return '$_temp0 Відповіді, які ви вже дали, збережено.';
  }

  @override
  String get streakCurrentLabel => 'Поточна серія';

  @override
  String get homeWriteTitle => 'Нове слово';

  @override
  String get homeWriteLanguageTitle => 'Напишіть слово мовою';

  @override
  String get homeWriteLearningLabel => 'Вивчаю';

  @override
  String get vocabularyPhotoOnPexelsLabel => 'Фото на Pexels';

  @override
  String get detailsAddPictureTitle => 'Додайте зображення';

  @override
  String get detailsNoPictureTitle => 'Немає зображення для цього слова';

  @override
  String get detailsCameraButton => 'Камера';

  @override
  String get detailsGalleryButton => 'Галерея';

  @override
  String get detailsUseOwnPhotoButton => 'Повернути ваше';

  @override
  String get detailsPexelsHint => 'Або виберіть одне з Pexels нижче';

  @override
  String get detailsRemovePictureTooltip => 'Прибрати зображення';

  @override
  String get detailsMorePicturesTooltip => 'Більше зображень';

  @override
  String get detailsNewCollectionTitle => 'Нова колекція';

  @override
  String get detailsEmojiSearchHint => 'Пошук емодзі (англійською)';

  @override
  String get detailsEmojiNoResultsMessage => 'Емодзі не знайдено';

  @override
  String get detailsEditWordTitle => 'Редагувати слово';

  @override
  String get detailsEditWordsTitle => 'Редагувати слова';

  @override
  String get detailsDoneButton => 'Готово';

  @override
  String get detailsAddLanguageButton => 'Додати іншу мову';

  @override
  String detailsPausedRoleLabel(String language) {
    return '$language, на паузі';
  }

  @override
  String detailsAsksInLabel(String language, String askMeIn) {
    return '$language, питає мовою $askMeIn';
  }

  @override
  String get scanFocusLockedLabel => 'Фокус зафіксовано';

  @override
  String get scanFlashTooltip => 'Спалах';

  @override
  String get scanSwitchCameraTooltip => 'Змінити камеру';

  @override
  String get scanGalleryTooltip => 'Вибрати з галереї';

  @override
  String get scanShutterTooltip => 'Зробити фото';

  @override
  String scanZoomLabel(String zoom) {
    return '$zoom×';
  }

  @override
  String get settingsDisplaySectionTitle => 'Відображення';

  @override
  String get settingsLearningSectionTitle => 'Навчання';

  @override
  String get settingsNotificationsSectionTitle => 'Сповіщення';

  @override
  String get settingsBackupSectionTitle => 'Резервна копія';

  @override
  String get settingsAboutSectionTitle => 'Про застосунок';

  @override
  String get collectionsEditTitle => 'Редагувати колекцію';

  @override
  String get collectionsEmojiTooltip => 'Вибрати емодзі';
}
