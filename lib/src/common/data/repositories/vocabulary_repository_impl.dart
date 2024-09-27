import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_database_data_source.dart';
import 'package:vocabualize/src/common/data/mappers/vocabulary_mappers.dart';
import 'package:vocabualize/src/common/domain/entities/filter_options.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

final vocabularyRepositoryProvider = Provider((ref) {
  return VocabularyRepositoryImpl(
    remoteDatabaseDataSource: ref.watch(remoteDatabaseDataSourceProvider),
  );
});

class VocabularyRepositoryImpl implements VocabularyRepository {
  final RemoteDatabaseDataSource _remoteDatabaseDataSource;

  VocabularyRepositoryImpl({
    required RemoteDatabaseDataSource remoteDatabaseDataSource,
  }) : _remoteDatabaseDataSource = remoteDatabaseDataSource {
    _loadVocabularies();
  }

  StreamController<List<Vocabulary>> _streamController = StreamController<List<Vocabulary>>.broadcast();
  Stream<List<Vocabulary>> get _stream => _streamController.stream;

  void dispose() {
    _streamController.close();
  }

  @override
  Future<void> addVocabulary(Vocabulary vocabulary) async {
    _remoteDatabaseDataSource.addVocabulary(vocabulary.toRdbVocabulary());
  }

  @override
  Future<void> deleteAllLocalVocabularies() {
    // TODO: implement deleteAllLocalVocabularies
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAllVocabularies() {
    return _remoteDatabaseDataSource.deleteAllVocabularies();
  }

  @override
  Future<void> deleteVocabulary(Vocabulary vocabulary) async {
    _remoteDatabaseDataSource.deleteVocabulary(vocabulary.toRdbVocabulary());
  }

  @override
  Stream<List<Vocabulary>> getNewVocabularies() {
    return _stream.map((vocabularies) {
      return vocabularies.where((vocabulary) {
        return vocabulary.created.isAfter(DateTime.now().subtract(const Duration(days: 7)));
      }).toList();
    });
  }

  @override
  Stream<List<Vocabulary>> getVocabularies(FilterOptions? filterOptions) {
    final filteredStream = _getStreamAndLoadIfNecessary().map((vocabularies) {
      return vocabularies.filterBySearchTerm(filterOptions?.searchTerm).filterByTag(filterOptions?.tag);
    });
    return filteredStream;
  }

  // !!! EINMAL REFACTORING BITTE, DANKE!
  Stream<List<Vocabulary>> _getStreamAndLoadIfNecessary() {
    if (_streamController.isClosed) {
      _streamController = StreamController<List<Vocabulary>>.broadcast();
      Log.warning("Attempted to add data to a closed StreamController. Controller reinitialized.");
    }
    if (!_streamController.hasListener) {
      Log.debug("No listener found. Loading vocabulary data.");
      _loadVocabularies();
    }
    return _stream;
  }

  Future<void> _loadVocabularies() async {
    _remoteDatabaseDataSource.getVocabularies().then((rdbVocabularies) {
      final vocabularies = rdbVocabularies.map((rdbVocabulary) {
        return rdbVocabulary.toVocabulary();
      }).toList();
      _streamController.sink.add(vocabularies);
    });
  }

  @override
  Future<List<Vocabulary>> getVocabulariesToPractise({Tag? tag}) async {
    Log.debug("getVocabulariesToPractise(tag: $tag)");
    final latestVocabularies = await _getStreamAndLoadIfNecessary().first;
    Log.debug("getVocabulariesToPractise() = ${latestVocabularies.length}");
    return latestVocabularies.where((vocabulary) {
      final isDue = vocabulary.nextDate.isBefore(DateTime.now());
      final containsTag = tag == null || vocabulary.tags.contains(tag);
      return isDue && containsTag;
    }).toList();
  }

  @override
  Future<bool> isCollectionMultilingual({Tag? tag}) async {
    final latestVocabularies = await _getStreamAndLoadIfNecessary().first;
    if (latestVocabularies.isEmpty) return false;
    final firstVocabulary = tag != null
        ? latestVocabularies.firstWhere(
            (vocabulary) => vocabulary.tags.contains(tag),
            orElse: () => Vocabulary(),
          )
        : latestVocabularies.first;
    return latestVocabularies.any((vocabulary) {
      final containsTag = tag == null || vocabulary.tags.contains(tag);
      final hasDifferentSourceLangauge = vocabulary.sourceLanguage != firstVocabulary.sourceLanguage;
      final hasDifferentTargetLangauge = vocabulary.targetLanguage != firstVocabulary.targetLanguage;
      return containsTag && (hasDifferentSourceLangauge || hasDifferentTargetLangauge);
    });
  }

  @override
  Future<void> updateVocabulary(Vocabulary vocabulary) async {
    _remoteDatabaseDataSource.updateVocabulary(vocabulary.toRdbVocabulary());
  }
}

extension on List<Vocabulary> {
  List<Vocabulary> filterBySearchTerm(String? searchTerm) {
    if (searchTerm == null || searchTerm.isEmpty) return this;
    return where((vocabulary) {
      return vocabulary.source.contains(searchTerm) || vocabulary.target.contains(searchTerm);
    }).toList();
  }

  List<Vocabulary> filterByTag(Tag? tag) {
    if (tag == null) return this;
    return where((vocabulary) {
      return vocabulary.tags.contains(tag);
    }).toList();
  }
}

/* // ! SUBSCRIBE
  RemoteDatabaseDataSource() {
    _init();
  }

  Future<bool> _init() async {
    try {
      await _subscribeToVocabularyChanges();
      Log.hint("CloudService initialized");
      return true;
    } catch (e) {
      Log.error("Failed to initialize CloudService.", exception: e);
      return false;
    }
  }

  Future<void> _subscribeToVocabularyChanges() async {
    final PocketBase pocketbase = await RemoteDatabaseDataSource.getConnection();
    pocketbase.collection(_vocabulariesCollectionName).subscribe("*", (event) async {
      if (event.record?.data["user"] != AppUser.instance.id) return;
      await loadData();
      // TODO: Only fetch the changed vocabulary
      Log.hint("Vocabulary cloud data changed (id: ${event.record?.id ?? "unknown"}).");
    });
  }
*/

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