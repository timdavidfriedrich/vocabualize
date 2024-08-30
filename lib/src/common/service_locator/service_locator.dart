import 'package:get_it/get_it.dart';
import 'package:vocabualize/src/common/data/data_sources/authentication_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/cloud_notification_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/draft_image_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/free_translator_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/local_notification_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/premium_translator_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_database_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_image_storage_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/speech_to_text_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/stock_image_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/text_to_speech_data_source.dart';
import 'package:vocabualize/src/common/data/repositories/image_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/language_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/notification_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/speech_to_text_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/tag_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/text_to_speech_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/translator_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/image_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/language_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/notification_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/speech_to_text_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/tag_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/text_to_speech_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/translator_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';
import 'package:vocabualize/src/common/domain/usecases/image/get_draft_image_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/image/get_stock_images_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/image/upload_image_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/language/find_language_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/language/get_available_languages_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/language/record_speech_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/language/set_target_language_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/language/read_out_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/notification/init_cloud_notifications_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/notification/init_local_notifications_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/notification/schedule_gather_notification_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/notification/schedule_practise_notification_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/tag/get_all_tags_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/translator/translate_to_english_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/translator/translate_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/add_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/answer_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/delete_all_local_vocabularies_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/delete_all_vocabularies_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/delete_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/get_new_vocabularies_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/get_vocabularies_to_practise_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/get_vocabularies_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/is_collection_multilingual_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/update_vocabulary_use_case.dart';

Future<void> initializeCommonDependencies(GetIt sl) async {
  // * Data sources
  sl.registerSingleton<AuthenticationDataSource>(AuthenticationDataSource());
  sl.registerSingleton<CloudNotificationDataSource>(CloudNotificationDataSource());
  sl.registerSingleton<DraftImageDataSource>(DraftImageDataSource());
  sl.registerSingleton<FreeTranslatorDataSource>(FreeTranslatorDataSource());
  sl.registerSingleton<LocalNotificationDataSource>(LocalNotificationDataSource());
  sl.registerSingleton<PremiumTranslatorDataSource>(PremiumTranslatorDataSource());
  sl.registerSingleton<RemoteDatabaseDataSource>(RemoteDatabaseDataSource());
  sl.registerSingleton<RemoteImageStorageDataSource>(RemoteImageStorageDataSource());
  sl.registerSingleton<SpeechToTextDataSource>(SpeechToTextDataSource());
  sl.registerSingleton<StockImageDataSource>(StockImageDataSource());
  sl.registerSingleton<TextToSpeechDataSource>(TextToSpeechDataSource());

  // * Repositories
  sl.registerSingleton<ImageRepository>(ImageRepositoryImpl());
  sl.registerSingleton<LanguageRepository>(LanguageRepositoryImpl());
  sl.registerSingleton<NotificationRepository>(NotificationRepositoryImpl());
  sl.registerSingleton<SpeechToTextRepository>(SpeechToTextRepositoryImpl());
  sl.registerSingleton<TagRepository>(TagRepositoryImpl());
  sl.registerSingleton<TextToSpeechRepository>(TextToSpeechRepositoryImpl());
  sl.registerSingleton<TranslatorRepository>(TranslatorRepositoryImpl());
  sl.registerSingleton<VocabularyRepository>(VocabularyRepositoryImpl());

  // * Use cases
  // image
  sl.registerFactory<GetDraftImageUseCase>(() => GetDraftImageUseCase());
  sl.registerFactory<GetStockImagesUseCase>(() => GetStockImagesUseCase());
  sl.registerFactory<UploadImageUseCase>(() => UploadImageUseCase());
  // language
  sl.registerFactory<FindLanguageUseCase>(() => FindLanguageUseCase());
  sl.registerFactory<GetAvailableLanguagesUseCase>(() => GetAvailableLanguagesUseCase());
  sl.registerFactory<ReadOutUseCase>(() => ReadOutUseCase());
  sl.registerFactory<RecordSpeechUseCase>(() => RecordSpeechUseCase());
  sl.registerFactory<SetTargetLanguageUseCase>(() => SetTargetLanguageUseCase());
  // notification
  sl.registerFactory<InitCloudNotificationsUseCase>(() => InitCloudNotificationsUseCase());
  sl.registerFactory<InitLocalNotificationsUseCase>(() => InitLocalNotificationsUseCase());
  sl.registerFactory<ScheduleGatherNotificationUseCase>(() => ScheduleGatherNotificationUseCase());
  sl.registerFactory<SchedulePractiseNotificationUseCase>(() => SchedulePractiseNotificationUseCase());
  // translator
  sl.registerFactory<TranslateToEnglishUseCase>(() => TranslateToEnglishUseCase());
  sl.registerFactory<TranslateUseCase>(() => TranslateUseCase());
  // tag
  sl.registerFactory<GetAllTagsUseCase>(() => GetAllTagsUseCase());
  // vocabulary
  sl.registerFactory<AddVocabularyUseCase>(() => AddVocabularyUseCase());
  sl.registerFactory<AnswerVocabularyUseCase>(() => AnswerVocabularyUseCase());
  sl.registerFactory<DeleteAllLocalVocabulariesUseCase>(() => DeleteAllLocalVocabulariesUseCase());
  sl.registerFactory<DeleteAllVocabulariesUseCase>(() => DeleteAllVocabulariesUseCase());
  sl.registerFactory<DeleteVocabularyUseCase>(() => DeleteVocabularyUseCase());
  sl.registerFactory<GetNewVocabulariesUseCase>(() => GetNewVocabulariesUseCase());
  sl.registerFactory<GetVocabulariesToPractiseUseCase>(() => GetVocabulariesToPractiseUseCase());
  sl.registerFactory<GetVocabulariesUseCase>(() => GetVocabulariesUseCase());
  sl.registerFactory<IsCollectionMultilingualUseCase>(() => IsCollectionMultilingualUseCase());
  sl.registerFactory<UpdateVocabularyUseCase>(() => UpdateVocabularyUseCase());
}
