import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/language_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/language_repository.dart';

typedef FindLanguageParameters = ({
  String? translatorId,
  String? speechToTextId,
  String? textToSpeechId,
});

final findLanguageUseCaseProvider = AutoDisposeProvider.family((ref, FindLanguageParameters parameters) {
  return FindLanguageUseCase(
    languageRepository: ref.watch(languageRepositoryProvider),
  ).call(
    translatorId: parameters.translatorId,
    speechToTextId: parameters.speechToTextId,
    textToSpeechId: parameters.textToSpeechId,
  );
});

class FindLanguageUseCase {
  final LanguageRepository _languageRepository;

  const FindLanguageUseCase({
    required LanguageRepository languageRepository,
  }) : _languageRepository = languageRepository;

  Future<Language?> call({String? translatorId, String? speechToTextId, String? textToSpeechId}) {
    return _languageRepository.findLanguage(
      translatorId: translatorId,
      speechToTextId: speechToTextId,
      textToSpeechId: textToSpeechId,
    );
  }
}
