import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_database_data_source.dart';
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
  Future<void> deleteAllVocabularies() async {
    for (final vocabulary in _cachedVocabularies) {
      _remoteDatabaseDataSource.deleteVocabulary(vocabulary.toRdbVocabulary());
    }
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
