/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:serverpod/serverpod.dart' as _is;

abstract class LocalVocabulary implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  LocalVocabulary._({
    this.id,
    this.spaceId,
    required this.source,
    required this.target,
    required this.sourceLanguageCode,
    required this.targetLanguageCode,
    required this.level,
    required this.isNovice,
    required this.intervalMinutes,
    required this.ease,
    required this.nextReviewAt,
    required this.imageKind,
    this.customImageId,
    this.stockImageId,
    this.stockImageUrl,
    this.stockImageThumbUrl,
    this.stockPhotographer,
    this.stockPhotographerUrl,
    required this.createdAt,
    this.extras,
  });

  factory LocalVocabulary({
    _is.UuidValue? id,
    int? spaceId,
    required String source,
    required String target,
    required String sourceLanguageCode,
    required String targetLanguageCode,
    required double level,
    required bool isNovice,
    required int intervalMinutes,
    required double ease,
    required DateTime nextReviewAt,
    required String imageKind,
    String? customImageId,
    String? stockImageId,
    String? stockImageUrl,
    String? stockImageThumbUrl,
    String? stockPhotographer,
    String? stockPhotographerUrl,
    required DateTime createdAt,
    String? extras,
  }) = _LocalVocabularyImpl;

  factory LocalVocabulary.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocalVocabulary(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      spaceId: jsonSerialization['spaceId'] as int?,
      source: jsonSerialization['source'] as String,
      target: jsonSerialization['target'] as String,
      sourceLanguageCode: jsonSerialization['sourceLanguageCode'] as String,
      targetLanguageCode: jsonSerialization['targetLanguageCode'] as String,
      level: (jsonSerialization['level'] as num).toDouble(),
      isNovice: _is.BoolJsonExtension.fromJson(jsonSerialization['isNovice']),
      intervalMinutes: jsonSerialization['intervalMinutes'] as int,
      ease: (jsonSerialization['ease'] as num).toDouble(),
      nextReviewAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['nextReviewAt']),
      imageKind: jsonSerialization['imageKind'] as String,
      customImageId: jsonSerialization['customImageId'] as String?,
      stockImageId: jsonSerialization['stockImageId'] as String?,
      stockImageUrl: jsonSerialization['stockImageUrl'] as String?,
      stockImageThumbUrl: jsonSerialization['stockImageThumbUrl'] as String?,
      stockPhotographer: jsonSerialization['stockPhotographer'] as String?,
      stockPhotographerUrl: jsonSerialization['stockPhotographerUrl'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      extras: jsonSerialization['extras'] as String?,
    );
  }

  static final t = LocalVocabularyTable();

  static const db = LocalVocabularyRepository._();

  @override
  _is.UuidValue? id;

  /// The space owning this row. Maintained by the sync engine.
  int? spaceId;

  String source;

  String target;

  String sourceLanguageCode;

  String targetLanguageCode;

  double level;

  bool isNovice;

  int intervalMinutes;

  double ease;

  DateTime nextReviewAt;

  String imageKind;

  String? customImageId;

  String? stockImageId;

  String? stockImageUrl;

  String? stockImageThumbUrl;

  String? stockPhotographer;

  String? stockPhotographerUrl;

  DateTime createdAt;

  String? extras;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [LocalVocabulary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LocalVocabulary copyWith({
    _is.UuidValue? id = const _is.$UndefinedUuidValue(),
    int? spaceId,
    String? source,
    String? target,
    String? sourceLanguageCode,
    String? targetLanguageCode,
    double? level,
    bool? isNovice,
    int? intervalMinutes,
    double? ease,
    DateTime? nextReviewAt,
    String? imageKind,
    String? customImageId,
    String? stockImageId,
    String? stockImageUrl,
    String? stockImageThumbUrl,
    String? stockPhotographer,
    String? stockPhotographerUrl,
    DateTime? createdAt,
    String? extras,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LocalVocabulary',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'source': source,
      'target': target,
      'sourceLanguageCode': sourceLanguageCode,
      'targetLanguageCode': targetLanguageCode,
      'level': level,
      'isNovice': isNovice,
      'intervalMinutes': intervalMinutes,
      'ease': ease,
      'nextReviewAt': nextReviewAt.toJson(),
      'imageKind': imageKind,
      if (customImageId != null) 'customImageId': customImageId,
      if (stockImageId != null) 'stockImageId': stockImageId,
      if (stockImageUrl != null) 'stockImageUrl': stockImageUrl,
      if (stockImageThumbUrl != null) 'stockImageThumbUrl': stockImageThumbUrl,
      if (stockPhotographer != null) 'stockPhotographer': stockPhotographer,
      if (stockPhotographerUrl != null) 'stockPhotographerUrl': stockPhotographerUrl,
      'createdAt': createdAt.toJson(),
      if (extras != null) 'extras': extras,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LocalVocabulary',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'source': source,
      'target': target,
      'sourceLanguageCode': sourceLanguageCode,
      'targetLanguageCode': targetLanguageCode,
      'level': level,
      'isNovice': isNovice,
      'intervalMinutes': intervalMinutes,
      'ease': ease,
      'nextReviewAt': nextReviewAt.toJson(),
      'imageKind': imageKind,
      if (customImageId != null) 'customImageId': customImageId,
      if (stockImageId != null) 'stockImageId': stockImageId,
      if (stockImageUrl != null) 'stockImageUrl': stockImageUrl,
      if (stockImageThumbUrl != null) 'stockImageThumbUrl': stockImageThumbUrl,
      if (stockPhotographer != null) 'stockPhotographer': stockPhotographer,
      if (stockPhotographerUrl != null) 'stockPhotographerUrl': stockPhotographerUrl,
      'createdAt': createdAt.toJson(),
      if (extras != null) 'extras': extras,
    };
  }

  static LocalVocabularyInclude include() {
    return LocalVocabularyInclude._();
  }

  static LocalVocabularyIncludeList includeList({
    _is.WhereExpressionBuilder<LocalVocabularyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LocalVocabularyTable>? orderBy,
    _is.OrderByListBuilder<LocalVocabularyTable>? orderByList,
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
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocalVocabularyImpl extends LocalVocabulary {
  _LocalVocabularyImpl({
    _is.UuidValue? id,
    int? spaceId,
    required String source,
    required String target,
    required String sourceLanguageCode,
    required String targetLanguageCode,
    required double level,
    required bool isNovice,
    required int intervalMinutes,
    required double ease,
    required DateTime nextReviewAt,
    required String imageKind,
    String? customImageId,
    String? stockImageId,
    String? stockImageUrl,
    String? stockImageThumbUrl,
    String? stockPhotographer,
    String? stockPhotographerUrl,
    required DateTime createdAt,
    String? extras,
  }) : super._(
         id: id,
         spaceId: spaceId,
         source: source,
         target: target,
         sourceLanguageCode: sourceLanguageCode,
         targetLanguageCode: targetLanguageCode,
         level: level,
         isNovice: isNovice,
         intervalMinutes: intervalMinutes,
         ease: ease,
         nextReviewAt: nextReviewAt,
         imageKind: imageKind,
         customImageId: customImageId,
         stockImageId: stockImageId,
         stockImageUrl: stockImageUrl,
         stockImageThumbUrl: stockImageThumbUrl,
         stockPhotographer: stockPhotographer,
         stockPhotographerUrl: stockPhotographerUrl,
         createdAt: createdAt,
         extras: extras,
       );

  /// Returns a shallow copy of this [LocalVocabulary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LocalVocabulary copyWith({
    _is.UuidValue? id = const _is.$UndefinedUuidValue(),
    Object? spaceId = _Undefined,
    String? source,
    String? target,
    String? sourceLanguageCode,
    String? targetLanguageCode,
    double? level,
    bool? isNovice,
    int? intervalMinutes,
    double? ease,
    DateTime? nextReviewAt,
    String? imageKind,
    Object? customImageId = _Undefined,
    Object? stockImageId = _Undefined,
    Object? stockImageUrl = _Undefined,
    Object? stockImageThumbUrl = _Undefined,
    Object? stockPhotographer = _Undefined,
    Object? stockPhotographerUrl = _Undefined,
    DateTime? createdAt,
    Object? extras = _Undefined,
  }) {
    return LocalVocabulary(
      id: id is _is.UndefinedSentinel ? this.id : id,
      spaceId: spaceId is int? ? spaceId : this.spaceId,
      source: source ?? this.source,
      target: target ?? this.target,
      sourceLanguageCode: sourceLanguageCode ?? this.sourceLanguageCode,
      targetLanguageCode: targetLanguageCode ?? this.targetLanguageCode,
      level: level ?? this.level,
      isNovice: isNovice ?? this.isNovice,
      intervalMinutes: intervalMinutes ?? this.intervalMinutes,
      ease: ease ?? this.ease,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      imageKind: imageKind ?? this.imageKind,
      customImageId: customImageId is String? ? customImageId : this.customImageId,
      stockImageId: stockImageId is String? ? stockImageId : this.stockImageId,
      stockImageUrl: stockImageUrl is String? ? stockImageUrl : this.stockImageUrl,
      stockImageThumbUrl: stockImageThumbUrl is String?
          ? stockImageThumbUrl
          : this.stockImageThumbUrl,
      stockPhotographer: stockPhotographer is String? ? stockPhotographer : this.stockPhotographer,
      stockPhotographerUrl: stockPhotographerUrl is String?
          ? stockPhotographerUrl
          : this.stockPhotographerUrl,
      createdAt: createdAt ?? this.createdAt,
      extras: extras is String? ? extras : this.extras,
    );
  }
}

class LocalVocabularyUpdateTable extends _is.UpdateTable<LocalVocabularyTable> {
  LocalVocabularyUpdateTable(super.table);

  _is.ColumnValue<int, int> spaceId(int? value) => _is.ColumnValue(
    table.spaceId,
    value,
  );

  _is.ColumnValue<String, String> source(String value) => _is.ColumnValue(
    table.source,
    value,
  );

  _is.ColumnValue<String, String> target(String value) => _is.ColumnValue(
    table.target,
    value,
  );

  _is.ColumnValue<String, String> sourceLanguageCode(String value) => _is.ColumnValue(
    table.sourceLanguageCode,
    value,
  );

  _is.ColumnValue<String, String> targetLanguageCode(String value) => _is.ColumnValue(
    table.targetLanguageCode,
    value,
  );

  _is.ColumnValue<double, double> level(double value) => _is.ColumnValue(
    table.level,
    value,
  );

  _is.ColumnValue<bool, bool> isNovice(bool value) => _is.ColumnValue(
    table.isNovice,
    value,
  );

  _is.ColumnValue<int, int> intervalMinutes(int value) => _is.ColumnValue(
    table.intervalMinutes,
    value,
  );

  _is.ColumnValue<double, double> ease(double value) => _is.ColumnValue(
    table.ease,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> nextReviewAt(DateTime value) => _is.ColumnValue(
    table.nextReviewAt,
    value,
  );

  _is.ColumnValue<String, String> imageKind(String value) => _is.ColumnValue(
    table.imageKind,
    value,
  );

  _is.ColumnValue<String, String> customImageId(String? value) => _is.ColumnValue(
    table.customImageId,
    value,
  );

  _is.ColumnValue<String, String> stockImageId(String? value) => _is.ColumnValue(
    table.stockImageId,
    value,
  );

  _is.ColumnValue<String, String> stockImageUrl(String? value) => _is.ColumnValue(
    table.stockImageUrl,
    value,
  );

  _is.ColumnValue<String, String> stockImageThumbUrl(String? value) => _is.ColumnValue(
    table.stockImageThumbUrl,
    value,
  );

  _is.ColumnValue<String, String> stockPhotographer(String? value) => _is.ColumnValue(
    table.stockPhotographer,
    value,
  );

  _is.ColumnValue<String, String> stockPhotographerUrl(String? value) => _is.ColumnValue(
    table.stockPhotographerUrl,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) => _is.ColumnValue(
    table.createdAt,
    value,
  );

  _is.ColumnValue<String, String> extras(String? value) => _is.ColumnValue(
    table.extras,
    value,
  );
}

class LocalVocabularyTable extends _is.Table<_is.UuidValue?> {
  LocalVocabularyTable({super.tableRelation}) : super(tableName: 'vocabulary') {
    updateTable = LocalVocabularyUpdateTable(this);
    spaceId = _is.ColumnInt(
      'spaceId',
      this,
    );
    source = _is.ColumnString(
      'source',
      this,
    );
    target = _is.ColumnString(
      'target',
      this,
    );
    sourceLanguageCode = _is.ColumnString(
      'sourceLanguageCode',
      this,
    );
    targetLanguageCode = _is.ColumnString(
      'targetLanguageCode',
      this,
    );
    level = _is.ColumnDouble(
      'level',
      this,
    );
    isNovice = _is.ColumnBool(
      'isNovice',
      this,
    );
    intervalMinutes = _is.ColumnInt(
      'intervalMinutes',
      this,
    );
    ease = _is.ColumnDouble(
      'ease',
      this,
    );
    nextReviewAt = _is.ColumnDateTime(
      'nextReviewAt',
      this,
    );
    imageKind = _is.ColumnString(
      'imageKind',
      this,
    );
    customImageId = _is.ColumnString(
      'customImageId',
      this,
    );
    stockImageId = _is.ColumnString(
      'stockImageId',
      this,
    );
    stockImageUrl = _is.ColumnString(
      'stockImageUrl',
      this,
    );
    stockImageThumbUrl = _is.ColumnString(
      'stockImageThumbUrl',
      this,
    );
    stockPhotographer = _is.ColumnString(
      'stockPhotographer',
      this,
    );
    stockPhotographerUrl = _is.ColumnString(
      'stockPhotographerUrl',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    extras = _is.ColumnString(
      'extras',
      this,
    );
  }

  late final LocalVocabularyUpdateTable updateTable;

  /// The space owning this row. Maintained by the sync engine.
  late final _is.ColumnInt spaceId;

  late final _is.ColumnString source;

  late final _is.ColumnString target;

  late final _is.ColumnString sourceLanguageCode;

  late final _is.ColumnString targetLanguageCode;

  late final _is.ColumnDouble level;

  late final _is.ColumnBool isNovice;

  late final _is.ColumnInt intervalMinutes;

  late final _is.ColumnDouble ease;

  late final _is.ColumnDateTime nextReviewAt;

  late final _is.ColumnString imageKind;

  late final _is.ColumnString customImageId;

  late final _is.ColumnString stockImageId;

  late final _is.ColumnString stockImageUrl;

  late final _is.ColumnString stockImageThumbUrl;

  late final _is.ColumnString stockPhotographer;

  late final _is.ColumnString stockPhotographerUrl;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnString extras;

  @override
  List<_is.Column> get columns => [
    id,
    spaceId,
    source,
    target,
    sourceLanguageCode,
    targetLanguageCode,
    level,
    isNovice,
    intervalMinutes,
    ease,
    nextReviewAt,
    imageKind,
    customImageId,
    stockImageId,
    stockImageUrl,
    stockImageThumbUrl,
    stockPhotographer,
    stockPhotographerUrl,
    createdAt,
    extras,
  ];
}

class LocalVocabularyInclude extends _is.IncludeObject {
  LocalVocabularyInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => LocalVocabulary.t;
}

class LocalVocabularyIncludeList extends _is.IncludeList {
  LocalVocabularyIncludeList._({
    _is.WhereExpressionBuilder<LocalVocabularyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LocalVocabulary.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => LocalVocabulary.t;
}

class LocalVocabularyRepository {
  const LocalVocabularyRepository._();

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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LocalVocabularyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LocalVocabularyTable>? orderBy,
    _is.OrderByListBuilder<LocalVocabularyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LocalVocabulary>(
      where: where?.call(LocalVocabulary.t),
      orderBy: orderBy?.call(LocalVocabulary.t),
      orderByList: orderByList?.call(LocalVocabulary.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LocalVocabularyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LocalVocabularyTable>? orderBy,
    _is.OrderByListBuilder<LocalVocabularyTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<LocalVocabulary>(
      where: where?.call(LocalVocabulary.t),
      orderBy: orderBy?.call(LocalVocabulary.t),
      orderByList: orderByList?.call(LocalVocabulary.t),
      limit: limit,
      offset: offset,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LocalVocabularyTable>? where,
    int? offset,
    _is.OrderByBuilder<LocalVocabularyTable>? orderBy,
    _is.OrderByListBuilder<LocalVocabularyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LocalVocabulary>(
      where: where?.call(LocalVocabulary.t),
      orderBy: orderBy?.call(LocalVocabulary.t),
      orderByList: orderByList?.call(LocalVocabulary.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LocalVocabulary] by its [id] or null if no such row exists.
  Future<LocalVocabulary?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LocalVocabulary>(
      id,
      transaction: transaction,
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
    _is.DatabaseSession session,
    List<LocalVocabulary> rows, {
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    LocalVocabulary row, {
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    List<LocalVocabulary> rows, {
    required _is.ColumnSelections<LocalVocabularyTable> conflictColumns,
    _is.ColumnSelections<LocalVocabularyTable>? updateColumns,
    _is.WhereExpressionBuilder<LocalVocabularyTable>? updateWhere,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    LocalVocabulary row, {
    required _is.ColumnSelections<LocalVocabularyTable> conflictColumns,
    _is.ColumnSelections<LocalVocabularyTable>? updateColumns,
    _is.WhereExpressionBuilder<LocalVocabularyTable>? updateWhere,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    List<LocalVocabulary> rows, {
    _is.ColumnSelections<LocalVocabularyTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    LocalVocabulary row, {
    _is.ColumnSelections<LocalVocabularyTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<LocalVocabularyUpdateTable> columnValues,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<LocalVocabularyUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<LocalVocabularyTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LocalVocabularyTable>? orderBy,
    _is.OrderByListBuilder<LocalVocabularyTable>? orderByList,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    List<LocalVocabulary> rows, {
    _is.OrderByBuilder<LocalVocabularyTable>? orderBy,
    _is.OrderByListBuilder<LocalVocabularyTable>? orderByList,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    LocalVocabulary row, {
    _is.Transaction? transaction,
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
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LocalVocabularyTable> where,
    _is.OrderByBuilder<LocalVocabularyTable>? orderBy,
    _is.OrderByListBuilder<LocalVocabularyTable>? orderByList,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LocalVocabularyTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<LocalVocabulary>(
      where: where?.call(LocalVocabulary.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LocalVocabulary] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LocalVocabularyTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LocalVocabulary>(
      where: where(LocalVocabulary.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
