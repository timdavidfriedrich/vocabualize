import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:vocabualize/src/common/data/sources/remote_database_data_source.dart';
import 'package:vocabualize/src/common/data/mappers/vocabulary_mappers.dart';
import 'package:vocabualize/src/common/data/models/rdb_event_type.dart';
import 'package:vocabualize/src/common/domain/entities/filter_options.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

final vocabularyProvider = StreamProviderFamily<List<Vocabulary>, FilterOptions?>((ref, FilterOptions? filterOptions) {
  final vocabularyRepository = ref.watch(vocabularyRepositoryProvider);
  return vocabularyRepository.getVocabularies(filterOptions: filterOptions);
});

final vocabularyRepositoryProvider = Provider((ref) {
  return VocabularyRepositoryImpl(
    remoteDatabaseDataSource: ref.watch(remoteDatabaseDataSourceProvider),
  );
});

class VocabularyRepositoryImpl implements VocabularyRepository {
  final RemoteDatabaseDataSource _remoteDatabaseDataSource;

  VocabularyRepositoryImpl({
    required RemoteDatabaseDataSource remoteDatabaseDataSource,
  }) : _remoteDatabaseDataSource = remoteDatabaseDataSource;

  // ? Should this stream controller be disposed somewhere? Or is it automatically disposed when repo is disposed?
  StreamController<List<Vocabulary>> _cachedStreamController = StreamController<List<Vocabulary>>.broadcast();
  List<Vocabulary> _cachedVocabularies = [];

  void _dispatchCache() {
    _cachedStreamController.sink.add(_cachedVocabularies);
  }

  @override
  Stream<List<Vocabulary>> getVocabularies({FilterOptions? filterOptions}) {
    final filteredStream = _getStreamAndLoadIfNecessary().map((vocabularies) {
      return vocabularies.filterBySearchTerm(filterOptions?.searchTerm).filterByTag(filterOptions?.tag);
    });
    return filteredStream;
  }

  Stream<List<Vocabulary>> _getStreamAndLoadIfNecessary() {
    if (_cachedStreamController.isClosed) {
      _cachedStreamController = StreamController<List<Vocabulary>>.broadcast();
      Log.warning("Attempted to add data to a closed StreamController. Controller reinitialized.");
    }
    if (!_cachedStreamController.hasListener) {
      Log.debug("No listener found.");
    }
    if (_cachedVocabularies.isEmpty) {
      Log.debug("No cached vocabularies. Will load.");
      _loadVocabularies();
    }
    return _cachedStreamController.stream;
  }

  Future<void> _loadVocabularies() async {
    _remoteDatabaseDataSource.getVocabularies().then((rdbVocabularies) {
      final vocabularies = rdbVocabularies.map((rdbVocabulary) {
        return rdbVocabulary.toVocabulary();
      }).toList();
      _cachedVocabularies = vocabularies;
      _dispatchCache();
    });
    _subscribeToChanges();
  }

  void _subscribeToChanges() {
    _remoteDatabaseDataSource.subscribeToVocabularyChanges((type, rdbVocabulary) async {
      final vocabulary = rdbVocabulary.toVocabulary();
      switch (type) {
        case RdbEventType.create:
          _cachedVocabularies.add(vocabulary);
          break;
        case RdbEventType.update:
          final index = _cachedVocabularies.indexWhere((v) => v.id == vocabulary.id);
          if (index != -1) {
            _cachedVocabularies[index] = vocabulary;
          }
          break;
        case RdbEventType.delete:
          _cachedVocabularies.removeWhere((v) => v.id == vocabulary.id);
          break;
        default:
          break;
      }
      _dispatchCache();
    });
  }

  @override
  Future<void> addVocabulary(Vocabulary vocabulary) async {
    final draftImage = vocabulary.image is DraftImage ? vocabulary.image as DraftImage : null;
    _remoteDatabaseDataSource.addVocabulary(
      vocabulary.toRdbVocabulary(),
      draftImageToUpload: draftImage?.content,
    );
  }

  @override
  Future<void> deleteAllVocabularies() {
    return _remoteDatabaseDataSource.deleteAllVocabularies();
  }

  @override
  Future<void> deleteAllLocalVocabularies() {
    // TODO: implement deleteAllLocalVocabularies
    throw UnimplementedError();
  }

  @override
  Future<void> deleteVocabulary(Vocabulary vocabulary) async {
    _remoteDatabaseDataSource.deleteVocabulary(vocabulary.toRdbVocabulary());
  }

  @override
  Future<void> updateVocabulary(Vocabulary vocabulary) async {
    final draftImage = vocabulary.image is DraftImage ? vocabulary.image as DraftImage : null;
    _remoteDatabaseDataSource.updateVocabulary(
      vocabulary.toRdbVocabulary(),
      draftImageToUpload: draftImage?.content,
    );
  }

  @override
  Future<bool> isCollectionMultilingual({Tag? tag}) async {
    if (_cachedVocabularies.isEmpty) return false;
    final firstVocabulary = tag != null
        ? _cachedVocabularies.firstWhere(
            (vocabulary) => vocabulary.tagIds.contains(tag.id),
            orElse: () => Vocabulary(),
          )
        : _cachedVocabularies.first;
    return _cachedVocabularies.any((vocabulary) {
      final containsTag = tag == null || vocabulary.tagIds.contains(tag.id);
      final hasDifferentSourceLanguage = vocabulary.sourceLanguageId != firstVocabulary.sourceLanguageId;
      final hasDifferentTargetLanguage = vocabulary.targetLanguageId != firstVocabulary.targetLanguageId;
      return containsTag && (hasDifferentSourceLanguage || hasDifferentTargetLanguage);
    });
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
      return vocabulary.tagIds.contains(tag.id);
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