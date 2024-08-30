import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_database_data_source.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

class VocabularyRepositoryImpl implements VocabularyRepository {
  final _remoteDatabaseDataSource = sl.get<RemoteDatabaseDataSource>();

  @override
  Future<void> addVocabulary(Vocabulary vocabulary) {
    // TODO: implement addVocabulary
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAllLocalVocabularies() {
    // TODO: implement deleteAllLocalVocabularies
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAllVocabularies() {
    // TODO: implement deleteAllVocabularies
    throw UnimplementedError();
  }

  @override
  Future<void> deleteVocabulary(Vocabulary vocabulary) {
    // TODO: implement deleteVocabulary
    throw UnimplementedError();
  }

  @override
  Stream<List<Vocabulary>> getNewVocabularies() {
    // TODO: implement getNewVocabularies
    throw UnimplementedError();
  }

  @override
  Stream<List<Vocabulary>> getVocabularies({String? searchTerm, Tag? tag}) {
    // TODO: implement getVocabularies
    throw UnimplementedError();
  }

  @override
  Future<List<Vocabulary>> getVocabulariesToPractise({Tag? tag}) {
    // TODO: implement getVocabulariesToPractise
    throw UnimplementedError();
  }

  @override
  Future<bool> isCollectionMultilingual({Tag? tag}) {
    // TODO: implement isCollectionMultilingual
    throw UnimplementedError();
  }

  @override
  Future<void> updateVocabulary(Vocabulary vocabulary) {
    // TODO: implement updateVocabulary
    throw UnimplementedError();
  }
}

/*

  dynamic searchListForSource(String source) {
    bool containsSource = vocabularyList.any((voc) => Formatter.normalize(voc.source) == Formatter.normalize(source));
    if (containsSource) {
      return vocabularyList.firstWhere((voc) => Formatter.normalize(voc.source) == Formatter.normalize(source));
    } else {
      return null;
    }
  }

  List<Vocabulary> get allToPractise {
    List<Vocabulary> result = [];
    try {
      result = vocabularyList.where((voc) => voc.nextDate.isBefore(DateTime.now())).toList();
    } catch (e) {
      Log.error("Failed to get vocabularies to practise.", exception: e);
    }
    return result;
  }

  Vocabulary get firstToPractise {
    return allToPractise.first;
  }

  List<Vocabulary> get lastest {
    const int daysIncluded = 7;
    const int maxItems = 10;
    return vocabularyList
        .where((voc) => voc.created.isAfter(DateTime.now().subtract(const Duration(days: daysIncluded))))
        .toList()
        .reversed
        .take(maxItems)
        .toList();
  }

  List<Vocabulary> get createdToday {
    return vocabularyList.where(
      (voc) {
        DateTime now = DateTime.now();
        DateTime creationDate = voc.created;
        return DateTime(creationDate.year, creationDate.month, creationDate.day) == DateTime(now.year, now.month, now.day);
      },
    ).toList();
  }

  List<Vocabulary> getVocabulariesByTag(Tag tag) {
    List<Vocabulary> result = [];
    try {
      result = vocabularyList.where((vocabulary) => vocabulary.tags.contains(tag)).toList();
    } catch (e) {
      Log.error("Failed to get vocabularies by tag $tag.", exception: e);
    }
    return result;
  }

  List<Vocabulary> getAllToPractiseForTag(Tag tag) {
    List<Vocabulary> result = [];
    try {
      result = getVocabulariesByTag(tag).where((voc) => voc.nextDate.isBefore(DateTime.now())).toList();
    } catch (e) {
      Log.error("Failed to get vocabularies to practise by tag $tag.", exception: e);
    }
    return result;
  }

    bool get isMultilingual {
    if (vocabularyList.isEmpty) return false;
    Language firstVocabularySourceLanguage = vocabularyList.first.sourceLanguage;
    Language firstVocabularyTargetLanguage = vocabularyList.first.targetLanguage;
    for (Vocabulary vocabulary in vocabularyList) {
      if (vocabulary.sourceLanguage != firstVocabularySourceLanguage) return true;
      if (vocabulary.targetLanguage != firstVocabularyTargetLanguage) return true;
    }
    return false;
  }
*/