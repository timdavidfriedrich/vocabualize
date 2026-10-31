/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_database/serverpod_database.dart' as _isd;
import 'package:vocabualize_client/src/protocol/protocol.dart' as _iow7dylj;
import '../sync/local_progress.dart' as _in2srp6w;
import '../sync/local_translation.dart' as _ilfqqi7t;

abstract class LocalVocabulary
    implements _isd.TableRow<_isc.UuidValue?>, _isc.ProtocolSerialization {
  LocalVocabulary._({
    this.id,
    this.spaceId,
    required this.imageKind,
    this.customImageId,
    this.customImageUploadedAt,
    this.stockImageId,
    this.stockImageUrl,
    this.stockImageThumbUrl,
    this.stockPhotographer,
    this.stockPhotographerUrl,
    required this.createdAt,
    this.extras,
    this.translations,
    this.progress,
  });

  factory LocalVocabulary({
    _isc.UuidValue? id,
    int? spaceId,
    required String imageKind,
    String? customImageId,
    DateTime? customImageUploadedAt,
    String? stockImageId,
    String? stockImageUrl,
    String? stockImageThumbUrl,
    String? stockPhotographer,
    String? stockPhotographerUrl,
    required DateTime createdAt,
    String? extras,
    List<_ilfqqi7t.LocalTranslation>? translations,
    List<_in2srp6w.LocalProgress>? progress,
  }) = _LocalVocabularyImpl;

  factory LocalVocabulary.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocalVocabulary(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      spaceId: jsonSerialization['spaceId'] as int?,
      imageKind: jsonSerialization['imageKind'] as String,
      customImageId: jsonSerialization['customImageId'] as String?,
      customImageUploadedAt: jsonSerialization['customImageUploadedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['customImageUploadedAt'],
            ),
      stockImageId: jsonSerialization['stockImageId'] as String?,
      stockImageUrl: jsonSerialization['stockImageUrl'] as String?,
      stockImageThumbUrl: jsonSerialization['stockImageThumbUrl'] as String?,
      stockPhotographer: jsonSerialization['stockPhotographer'] as String?,
      stockPhotographerUrl:
          jsonSerialization['stockPhotographerUrl'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      extras: jsonSerialization['extras'] as String?,
      translations: jsonSerialization['translations'] == null
          ? null
          : _iow7dylj.Protocol().deserialize<List<_ilfqqi7t.LocalTranslation>>(
              jsonSerialization['translations'],
            ),
      progress: jsonSerialization['progress'] == null
          ? null
          : _iow7dylj.Protocol().deserialize<List<_in2srp6w.LocalProgress>>(
              jsonSerialization['progress'],
            ),
    );
  }

  static final t = LocalVocabularyTable();

  static const db = LocalVocabularyRepository._();

  @override
  _isc.UuidValue? id;

  /// The space owning this row. Maintained by the sync engine.
  int? spaceId;

  String imageKind;

  String? customImageId;

  DateTime? customImageUploadedAt;

  String? stockImageId;

  String? stockImageUrl;

  String? stockImageThumbUrl;

  String? stockPhotographer;

  String? stockPhotographerUrl;

  DateTime createdAt;

  String? extras;

  List<_ilfqqi7t.LocalTranslation>? translations;

  List<_in2srp6w.LocalProgress>? progress;

  @override
  _isd.Table<_isc.UuidValue?> get table => t;

  /// Returns a shallow copy of this [LocalVocabulary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LocalVocabulary copyWith({
    _isc.UuidValue? id = const _isc.$UndefinedUuidValue(),
    int? spaceId,
    String? imageKind,
    String? customImageId,
    DateTime? customImageUploadedAt = const _isc.$UndefinedDateTime(),
    String? stockImageId,
    String? stockImageUrl,
    String? stockImageThumbUrl,
    String? stockPhotographer,
    String? stockPhotographerUrl,
    DateTime? createdAt,
    String? extras,
    List<_ilfqqi7t.LocalTranslation>? translations =
        const _isc.$UndefinedList<_ilfqqi7t.LocalTranslation>(),
    List<_in2srp6w.LocalProgress>? progress =
        const _isc.$UndefinedList<_in2srp6w.LocalProgress>(),
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LocalVocabulary',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'imageKind': imageKind,
      if (customImageId != null) 'customImageId': customImageId,
      if (customImageUploadedAt != null)
        'customImageUploadedAt': customImageUploadedAt?.toJson(),
      if (stockImageId != null) 'stockImageId': stockImageId,
      if (stockImageUrl != null) 'stockImageUrl': stockImageUrl,
      if (stockImageThumbUrl != null) 'stockImageThumbUrl': stockImageThumbUrl,
      if (stockPhotographer != null) 'stockPhotographer': stockPhotographer,
      if (stockPhotographerUrl != null)
        'stockPhotographerUrl': stockPhotographerUrl,
      'createdAt': createdAt.toJson(),
      if (extras != null) 'extras': extras,
      if (translations != null)
        'translations': translations?.toJson(valueToJson: (v) => v.toJson()),
      if (progress != null)
        'progress': progress?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LocalVocabulary',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'imageKind': imageKind,
      if (customImageId != null) 'customImageId': customImageId,
      if (customImageUploadedAt != null)
        'customImageUploadedAt': customImageUploadedAt?.toJson(),
      if (stockImageId != null) 'stockImageId': stockImageId,
      if (stockImageUrl != null) 'stockImageUrl': stockImageUrl,
      if (stockImageThumbUrl != null) 'stockImageThumbUrl': stockImageThumbUrl,
      if (stockPhotographer != null) 'stockPhotographer': stockPhotographer,
      if (stockPhotographerUrl != null)
        'stockPhotographerUrl': stockPhotographerUrl,
      'createdAt': createdAt.toJson(),
      if (extras != null) 'extras': extras,
      if (translations != null)
        'translations': translations?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (progress != null)
        'progress': progress?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static LocalVocabularyInclude include({
    _ilfqqi7t.LocalTranslationIncludeList? translations,
    _in2srp6w.LocalProgressIncludeList? progress,
  }) {
    return LocalVocabularyInclude._(
      translations: translations,
      progress: progress,
    );
  }

  static LocalVocabularyIncludeList includeList({
    _isd.WhereExpressionBuilder<LocalVocabularyTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalVocabularyTable>? orderBy,
    _isd.OrderByListBuilder<LocalVocabularyTable>? orderByList,
    LocalVocabularyInclude? include,
  }) {
    return LocalVocabularyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocalVocabulary.t),
      orderByList: orderByList?.call(LocalVocabulary.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocalVocabularyImpl extends LocalVocabulary {
  _LocalVocabularyImpl({
    _isc.UuidValue? id,
    int? spaceId,
    required String imageKind,
    String? customImageId,
    DateTime? customImageUploadedAt,
    String? stockImageId,
    String? stockImageUrl,
    String? stockImageThumbUrl,
    String? stockPhotographer,
    String? stockPhotographerUrl,
    required DateTime createdAt,
    String? extras,
    List<_ilfqqi7t.LocalTranslation>? translations,
    List<_in2srp6w.LocalProgress>? progress,
  }) : super._(
         id: id,
         spaceId: spaceId,
         imageKind: imageKind,
         customImageId: customImageId,
         customImageUploadedAt: customImageUploadedAt,
         stockImageId: stockImageId,
         stockImageUrl: stockImageUrl,
         stockImageThumbUrl: stockImageThumbUrl,
         stockPhotographer: stockPhotographer,
         stockPhotographerUrl: stockPhotographerUrl,
         createdAt: createdAt,
         extras: extras,
         translations: translations,
         progress: progress,
       );

  /// Returns a shallow copy of this [LocalVocabulary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LocalVocabulary copyWith({
    _isc.UuidValue? id = const _isc.$UndefinedUuidValue(),
    Object? spaceId = _Undefined,
    String? imageKind,
    Object? customImageId = _Undefined,
    DateTime? customImageUploadedAt = const _isc.$UndefinedDateTime(),
    Object? stockImageId = _Undefined,
    Object? stockImageUrl = _Undefined,
    Object? stockImageThumbUrl = _Undefined,
    Object? stockPhotographer = _Undefined,
    Object? stockPhotographerUrl = _Undefined,
    DateTime? createdAt,
    Object? extras = _Undefined,
    List<_ilfqqi7t.LocalTranslation>? translations =
        const _isc.$UndefinedList<_ilfqqi7t.LocalTranslation>(),
    List<_in2srp6w.LocalProgress>? progress =
        const _isc.$UndefinedList<_in2srp6w.LocalProgress>(),
  }) {
    return LocalVocabulary(
      id: id is _isc.UndefinedSentinel ? this.id : id,
      spaceId: spaceId is int? ? spaceId : this.spaceId,
      imageKind: imageKind ?? this.imageKind,
      customImageId: customImageId is String?
          ? customImageId
          : this.customImageId,
      customImageUploadedAt: customImageUploadedAt is _isc.UndefinedSentinel
          ? this.customImageUploadedAt
          : customImageUploadedAt,
      stockImageId: stockImageId is String? ? stockImageId : this.stockImageId,
      stockImageUrl: stockImageUrl is String?
          ? stockImageUrl
          : this.stockImageUrl,
      stockImageThumbUrl: stockImageThumbUrl is String?
          ? stockImageThumbUrl
          : this.stockImageThumbUrl,
      stockPhotographer: stockPhotographer is String?
          ? stockPhotographer
          : this.stockPhotographer,
      stockPhotographerUrl: stockPhotographerUrl is String?
          ? stockPhotographerUrl
          : this.stockPhotographerUrl,
      createdAt: createdAt ?? this.createdAt,
      extras: extras is String? ? extras : this.extras,
      translations: translations is _isc.UndefinedSentinel
          ? this.translations?.map((e0) => e0.copyWith()).toList()
          : translations,
      progress: progress is _isc.UndefinedSentinel
          ? this.progress?.map((e0) => e0.copyWith()).toList()
          : progress,
    );
  }
}

class LocalVocabularyUpdateTable
    extends _isd.UpdateTable<LocalVocabularyTable> {
  LocalVocabularyUpdateTable(super.table);

  _isd.ColumnValue<int, int> spaceId(int? value) => _isd.ColumnValue(
    table.spaceId,
    value,
  );

  _isd.ColumnValue<String, String> imageKind(String value) => _isd.ColumnValue(
    table.imageKind,
    value,
  );

  _isd.ColumnValue<String, String> customImageId(String? value) =>
      _isd.ColumnValue(
        table.customImageId,
        value,
      );

  _isd.ColumnValue<DateTime, DateTime> customImageUploadedAt(DateTime? value) =>
      _isd.ColumnValue(
        table.customImageUploadedAt,
        value,
      );

  _isd.ColumnValue<String, String> stockImageId(String? value) =>
      _isd.ColumnValue(
        table.stockImageId,
        value,
      );

  _isd.ColumnValue<String, String> stockImageUrl(String? value) =>
      _isd.ColumnValue(
        table.stockImageUrl,
        value,
      );

  _isd.ColumnValue<String, String> stockImageThumbUrl(String? value) =>
      _isd.ColumnValue(
        table.stockImageThumbUrl,
        value,
      );

  _isd.ColumnValue<String, String> stockPhotographer(String? value) =>
      _isd.ColumnValue(
        table.stockPhotographer,
        value,
      );

  _isd.ColumnValue<String, String> stockPhotographerUrl(String? value) =>
      _isd.ColumnValue(
        table.stockPhotographerUrl,
        value,
      );

  _isd.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _isd.ColumnValue(
        table.createdAt,
        value,
      );

  _isd.ColumnValue<String, String> extras(String? value) => _isd.ColumnValue(
    table.extras,
    value,
  );
}

class LocalVocabularyTable extends _isd.Table<_isc.UuidValue?> {
  LocalVocabularyTable({super.tableRelation}) : super(tableName: 'vocabulary') {
    updateTable = LocalVocabularyUpdateTable(this);
    spaceId = _isd.ColumnInt(
      'spaceId',
      this,
    );
    imageKind = _isd.ColumnString(
      'imageKind',
      this,
    );
    customImageId = _isd.ColumnString(
      'customImageId',
      this,
    );
    customImageUploadedAt = _isd.ColumnDateTime(
      'customImageUploadedAt',
      this,
    );
    stockImageId = _isd.ColumnString(
      'stockImageId',
      this,
    );
    stockImageUrl = _isd.ColumnString(
      'stockImageUrl',
      this,
    );
    stockImageThumbUrl = _isd.ColumnString(
      'stockImageThumbUrl',
      this,
    );
    stockPhotographer = _isd.ColumnString(
      'stockPhotographer',
      this,
    );
    stockPhotographerUrl = _isd.ColumnString(
      'stockPhotographerUrl',
      this,
    );
    createdAt = _isd.ColumnDateTime(
      'createdAt',
      this,
    );
    extras = _isd.ColumnString(
      'extras',
      this,
    );
  }

  late final LocalVocabularyUpdateTable updateTable;

  /// The space owning this row. Maintained by the sync engine.
  late final _isd.ColumnInt spaceId;

  late final _isd.ColumnString imageKind;

  late final _isd.ColumnString customImageId;

  late final _isd.ColumnDateTime customImageUploadedAt;

  late final _isd.ColumnString stockImageId;

  late final _isd.ColumnString stockImageUrl;

  late final _isd.ColumnString stockImageThumbUrl;

  late final _isd.ColumnString stockPhotographer;

  late final _isd.ColumnString stockPhotographerUrl;

  late final _isd.ColumnDateTime createdAt;

  late final _isd.ColumnString extras;

  _ilfqqi7t.LocalTranslationTable? ___translations;

  _isd.ManyRelation<_ilfqqi7t.LocalTranslationTable>? _translations;

  _in2srp6w.LocalProgressTable? ___progress;

  _isd.ManyRelation<_in2srp6w.LocalProgressTable>? _progress;

  _ilfqqi7t.LocalTranslationTable get __translations {
    if (___translations != null) return ___translations!;
    ___translations = _isd.createRelationTable(
      relationFieldName: '__translations',
      field: LocalVocabulary.t.id,
      foreignField: _ilfqqi7t.LocalTranslation.t.vocabularyId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ilfqqi7t.LocalTranslationTable(tableRelation: foreignTableRelation),
    );
    return ___translations!;
  }

  _in2srp6w.LocalProgressTable get __progress {
    if (___progress != null) return ___progress!;
    ___progress = _isd.createRelationTable(
      relationFieldName: '__progress',
      field: LocalVocabulary.t.id,
      foreignField: _in2srp6w.LocalProgress.t.vocabularyId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _in2srp6w.LocalProgressTable(tableRelation: foreignTableRelation),
    );
    return ___progress!;
  }

  _isd.ManyRelation<_ilfqqi7t.LocalTranslationTable> get translations {
    if (_translations != null) return _translations!;
    var relationTable = _isd.createRelationTable(
      relationFieldName: 'translations',
      field: LocalVocabulary.t.id,
      foreignField: _ilfqqi7t.LocalTranslation.t.vocabularyId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ilfqqi7t.LocalTranslationTable(tableRelation: foreignTableRelation),
    );
    _translations = _isd.ManyRelation<_ilfqqi7t.LocalTranslationTable>(
      tableWithRelations: relationTable,
      table: _ilfqqi7t.LocalTranslationTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _translations!;
  }

  _isd.ManyRelation<_in2srp6w.LocalProgressTable> get progress {
    if (_progress != null) return _progress!;
    var relationTable = _isd.createRelationTable(
      relationFieldName: 'progress',
      field: LocalVocabulary.t.id,
      foreignField: _in2srp6w.LocalProgress.t.vocabularyId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _in2srp6w.LocalProgressTable(tableRelation: foreignTableRelation),
    );
    _progress = _isd.ManyRelation<_in2srp6w.LocalProgressTable>(
      tableWithRelations: relationTable,
      table: _in2srp6w.LocalProgressTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _progress!;
  }

  @override
  List<_isd.Column> get columns => [
    id,
    spaceId,
    imageKind,
    customImageId,
    customImageUploadedAt,
    stockImageId,
    stockImageUrl,
    stockImageThumbUrl,
    stockPhotographer,
    stockPhotographerUrl,
    createdAt,
    extras,
  ];

  @override
  _isd.Table? getRelationTable(String relationField) {
    if (relationField == 'translations') {
      return __translations;
    }
    if (relationField == 'progress') {
      return __progress;
    }
    return null;
  }
}

class LocalVocabularyInclude extends _isd.IncludeObject {
  LocalVocabularyInclude._({
    _ilfqqi7t.LocalTranslationIncludeList? translations,
    _in2srp6w.LocalProgressIncludeList? progress,
  }) {
    _translations = translations;
    _progress = progress;
  }

  _ilfqqi7t.LocalTranslationIncludeList? _translations;

  _in2srp6w.LocalProgressIncludeList? _progress;

  @override
  Map<String, _isd.Include?> get includes => {
    'translations': _translations,
    'progress': _progress,
  };

  @override
  _isd.Table<_isc.UuidValue?> get table => LocalVocabulary.t;
}

class LocalVocabularyIncludeList extends _isd.IncludeList {
  LocalVocabularyIncludeList._({
    _isd.WhereExpressionBuilder<LocalVocabularyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LocalVocabulary.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<_isc.UuidValue?> get table => LocalVocabulary.t;
}

class LocalVocabularyRepository {
  const LocalVocabularyRepository._();

  final attach = const LocalVocabularyAttachRepository._();

  final attachRow = const LocalVocabularyAttachRowRepository._();

  /// Returns a list of [LocalVocabulary]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<LocalVocabulary>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalVocabularyTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalVocabularyTable>? orderBy,
    _isd.OrderByListBuilder<LocalVocabularyTable>? orderByList,
    _isd.Transaction? transaction,
    LocalVocabularyInclude? include,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LocalVocabulary>(
      where: where?.call(LocalVocabulary.t),
      orderBy: orderBy?.call(LocalVocabulary.t),
      orderByList: orderByList?.call(LocalVocabulary.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [LocalVocabulary]s matching the given query parameters every time the
  /// source tables are modified.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// Use [throttle] to specify the minimum interval between queries. It can
  /// also be set to `null`, in which case the stream will only be throttled
  /// when its subscription is paused.
  ///
  /// Source tables are collected from the queried table, [where], [orderBy],
  /// [orderByList], and the [include] graph. [alsoTriggerOnTables] is added
  /// to that set. Pass [Table] instances such as `LocalVocabulary.t`.
  ///
  /// Raw [Expression] SQL is not inspected. Tables referenced only in raw
  /// SQL must be passed via [alsoTriggerOnTables].
  ///
  /// The stream always reads committed state and never joins an ambient
  /// [Transaction]. Emissions for a write fire after that write commits.
  ///
  /// Currently only supported on SQLite. Calling this method on PostgreSQL
  /// throws an [UnsupportedError].
  ///
  /// ```dart
  /// var subscription = Persons.db.watch(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// ).listen((persons) {
  ///   // Handle the latest matching rows.
  /// });
  /// ```
  _ida.Stream<List<LocalVocabulary>> watch(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalVocabularyTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalVocabularyTable>? orderBy,
    _isd.OrderByListBuilder<LocalVocabularyTable>? orderByList,
    LocalVocabularyInclude? include,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_isd.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<LocalVocabulary>(
      where: where?.call(LocalVocabulary.t),
      orderBy: orderBy?.call(LocalVocabulary.t),
      orderByList: orderByList?.call(LocalVocabulary.t),
      limit: limit,
      offset: offset,
      include: include,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [LocalVocabulary] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<LocalVocabulary?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalVocabularyTable>? where,
    int? offset,
    _isd.OrderByBuilder<LocalVocabularyTable>? orderBy,
    _isd.OrderByListBuilder<LocalVocabularyTable>? orderByList,
    _isd.Transaction? transaction,
    LocalVocabularyInclude? include,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LocalVocabulary>(
      where: where?.call(LocalVocabulary.t),
      orderBy: orderBy?.call(LocalVocabulary.t),
      orderByList: orderByList?.call(LocalVocabulary.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LocalVocabulary] by its [id] or null if no such row exists.
  Future<LocalVocabulary?> findById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    _isd.Transaction? transaction,
    LocalVocabularyInclude? include,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LocalVocabulary>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LocalVocabulary]s in the list and returns the inserted rows.
  ///
  /// The returned [LocalVocabulary]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalVocabulary>> insert(
    _isd.DatabaseSession session,
    List<LocalVocabulary> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<LocalVocabulary>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [LocalVocabulary] and returns the inserted row.
  ///
  /// The returned [LocalVocabulary] will have its `id` field set.
  Future<LocalVocabulary> insertRow(
    _isd.DatabaseSession session,
    LocalVocabulary row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<LocalVocabulary>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [LocalVocabulary]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [LocalVocabulary]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalVocabulary>> upsert(
    _isd.DatabaseSession session,
    List<LocalVocabulary> rows, {
    required _isd.ColumnSelections<LocalVocabularyTable> conflictColumns,
    _isd.ColumnSelections<LocalVocabularyTable>? updateColumns,
    _isd.WhereExpressionBuilder<LocalVocabularyTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<LocalVocabulary>(
      rows,
      conflictColumns: conflictColumns(LocalVocabulary.t),
      updateColumns: updateColumns?.call(LocalVocabulary.t),
      updateWhere: updateWhere?.call(LocalVocabulary.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [LocalVocabulary] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [LocalVocabulary] will have its `id` field set.
  Future<LocalVocabulary?> upsertRow(
    _isd.DatabaseSession session,
    LocalVocabulary row, {
    required _isd.ColumnSelections<LocalVocabularyTable> conflictColumns,
    _isd.ColumnSelections<LocalVocabularyTable>? updateColumns,
    _isd.WhereExpressionBuilder<LocalVocabularyTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<LocalVocabulary>(
      row,
      conflictColumns: conflictColumns(LocalVocabulary.t),
      updateColumns: updateColumns?.call(LocalVocabulary.t),
      updateWhere: updateWhere?.call(LocalVocabulary.t),
      transaction: transaction,
    );
  }

  /// Updates all [LocalVocabulary]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalVocabulary>> update(
    _isd.DatabaseSession session,
    List<LocalVocabulary> rows, {
    _isd.ColumnSelections<LocalVocabularyTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<LocalVocabulary>(
      rows,
      columns: columns?.call(LocalVocabulary.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [LocalVocabulary]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LocalVocabulary> updateRow(
    _isd.DatabaseSession session,
    LocalVocabulary row, {
    _isd.ColumnSelections<LocalVocabularyTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<LocalVocabulary>(
      row,
      columns: columns?.call(LocalVocabulary.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LocalVocabulary] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LocalVocabulary?> updateById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    required _isd.ColumnValueListBuilder<LocalVocabularyUpdateTable>
    columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<LocalVocabulary>(
      id,
      columnValues: columnValues(LocalVocabulary.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LocalVocabulary]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalVocabulary>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<LocalVocabularyUpdateTable>
    columnValues,
    required _isd.WhereExpressionBuilder<LocalVocabularyTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalVocabularyTable>? orderBy,
    _isd.OrderByListBuilder<LocalVocabularyTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<LocalVocabulary>(
      columnValues: columnValues(LocalVocabulary.t.updateTable),
      where: where(LocalVocabulary.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocalVocabulary.t),
      orderByList: orderByList?.call(LocalVocabulary.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [LocalVocabulary]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalVocabulary>> delete(
    _isd.DatabaseSession session,
    List<LocalVocabulary> rows, {
    _isd.OrderByBuilder<LocalVocabularyTable>? orderBy,
    _isd.OrderByListBuilder<LocalVocabularyTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<LocalVocabulary>(
      rows,
      orderBy: orderBy?.call(LocalVocabulary.t),
      orderByList: orderByList?.call(LocalVocabulary.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [LocalVocabulary].
  Future<LocalVocabulary> deleteRow(
    _isd.DatabaseSession session,
    LocalVocabulary row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LocalVocabulary>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalVocabulary>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<LocalVocabularyTable> where,
    _isd.OrderByBuilder<LocalVocabularyTable>? orderBy,
    _isd.OrderByListBuilder<LocalVocabularyTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<LocalVocabulary>(
      where: where(LocalVocabulary.t),
      orderBy: orderBy?.call(LocalVocabulary.t),
      orderByList: orderByList?.call(LocalVocabulary.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalVocabularyTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<LocalVocabulary>(
      where: where?.call(LocalVocabulary.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LocalVocabulary] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<LocalVocabularyTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LocalVocabulary>(
      where: where(LocalVocabulary.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class LocalVocabularyAttachRepository {
  const LocalVocabularyAttachRepository._();

  /// Creates a relation between this [LocalVocabulary] and the given [LocalTranslation]s
  /// by setting each [LocalTranslation]'s foreign key `vocabularyId` to refer to this [LocalVocabulary].
  Future<void> translations(
    _isd.DatabaseSession session,
    LocalVocabulary localVocabulary,
    List<_ilfqqi7t.LocalTranslation> localTranslation, {
    _isd.Transaction? transaction,
  }) async {
    if (localTranslation.any((e) => e.id == null)) {
      throw ArgumentError.notNull('localTranslation.id');
    }
    if (localVocabulary.id == null) {
      throw ArgumentError.notNull('localVocabulary.id');
    }

    var $localTranslation = localTranslation
        .map((e) => e.copyWith(vocabularyId: localVocabulary.id))
        .toList();
    await session.db.update<_ilfqqi7t.LocalTranslation>(
      $localTranslation,
      columns: [_ilfqqi7t.LocalTranslation.t.vocabularyId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [LocalVocabulary] and the given [LocalProgress]s
  /// by setting each [LocalProgress]'s foreign key `vocabularyId` to refer to this [LocalVocabulary].
  Future<void> progress(
    _isd.DatabaseSession session,
    LocalVocabulary localVocabulary,
    List<_in2srp6w.LocalProgress> localProgress, {
    _isd.Transaction? transaction,
  }) async {
    if (localProgress.any((e) => e.id == null)) {
      throw ArgumentError.notNull('localProgress.id');
    }
    if (localVocabulary.id == null) {
      throw ArgumentError.notNull('localVocabulary.id');
    }

    var $localProgress = localProgress
        .map((e) => e.copyWith(vocabularyId: localVocabulary.id))
        .toList();
    await session.db.update<_in2srp6w.LocalProgress>(
      $localProgress,
      columns: [_in2srp6w.LocalProgress.t.vocabularyId],
      transaction: transaction,
    );
  }
}

class LocalVocabularyAttachRowRepository {
  const LocalVocabularyAttachRowRepository._();

  /// Creates a relation between this [LocalVocabulary] and the given [LocalTranslation]
  /// by setting the [LocalTranslation]'s foreign key `vocabularyId` to refer to this [LocalVocabulary].
  Future<void> translations(
    _isd.DatabaseSession session,
    LocalVocabulary localVocabulary,
    _ilfqqi7t.LocalTranslation localTranslation, {
    _isd.Transaction? transaction,
  }) async {
    if (localTranslation.id == null) {
      throw ArgumentError.notNull('localTranslation.id');
    }
    if (localVocabulary.id == null) {
      throw ArgumentError.notNull('localVocabulary.id');
    }

    var $localTranslation = localTranslation.copyWith(
      vocabularyId: localVocabulary.id,
    );
    await session.db.updateRow<_ilfqqi7t.LocalTranslation>(
      $localTranslation,
      columns: [_ilfqqi7t.LocalTranslation.t.vocabularyId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [LocalVocabulary] and the given [LocalProgress]
  /// by setting the [LocalProgress]'s foreign key `vocabularyId` to refer to this [LocalVocabulary].
  Future<void> progress(
    _isd.DatabaseSession session,
    LocalVocabulary localVocabulary,
    _in2srp6w.LocalProgress localProgress, {
    _isd.Transaction? transaction,
  }) async {
    if (localProgress.id == null) {
      throw ArgumentError.notNull('localProgress.id');
    }
    if (localVocabulary.id == null) {
      throw ArgumentError.notNull('localVocabulary.id');
    }

    var $localProgress = localProgress.copyWith(
      vocabularyId: localVocabulary.id,
    );
    await session.db.updateRow<_in2srp6w.LocalProgress>(
      $localProgress,
      columns: [_in2srp6w.LocalProgress.t.vocabularyId],
      transaction: transaction,
    );
  }
}
