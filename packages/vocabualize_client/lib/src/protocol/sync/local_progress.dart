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
import '../sync/local_vocabulary.dart' as _iwjoehei;

abstract class LocalProgress
    implements _isd.TableRow<_isc.UuidValue?>, _isc.ProtocolSerialization {
  LocalProgress._({
    this.id,
    this.spaceId,
    required this.vocabularyId,
    this.vocabulary,
    required this.languageCode,
    required this.stage,
    required this.level,
    required this.intervalMinutes,
    required this.ease,
    required this.nextReviewAt,
    required this.createdAt,
    this.extras,
  });

  factory LocalProgress({
    _isc.UuidValue? id,
    int? spaceId,
    required _isc.UuidValue vocabularyId,
    _iwjoehei.LocalVocabulary? vocabulary,
    required String languageCode,
    required String stage,
    required double level,
    required int intervalMinutes,
    required double ease,
    required DateTime nextReviewAt,
    required DateTime createdAt,
    String? extras,
  }) = _LocalProgressImpl;

  factory LocalProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocalProgress(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      spaceId: jsonSerialization['spaceId'] as int?,
      vocabularyId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['vocabularyId'],
      ),
      vocabulary: jsonSerialization['vocabulary'] == null
          ? null
          : _iow7dylj.Protocol().deserialize<_iwjoehei.LocalVocabulary>(
              jsonSerialization['vocabulary'],
            ),
      languageCode: jsonSerialization['languageCode'] as String,
      stage: jsonSerialization['stage'] as String,
      level: (jsonSerialization['level'] as num).toDouble(),
      intervalMinutes: jsonSerialization['intervalMinutes'] as int,
      ease: (jsonSerialization['ease'] as num).toDouble(),
      nextReviewAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['nextReviewAt'],
      ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      extras: jsonSerialization['extras'] as String?,
    );
  }

  static final t = LocalProgressTable();

  static const db = LocalProgressRepository._();

  @override
  _isc.UuidValue? id;

  /// The space owning this row. Maintained by the sync engine.
  int? spaceId;

  _isc.UuidValue vocabularyId;

  _iwjoehei.LocalVocabulary? vocabulary;

  String languageCode;

  String stage;

  double level;

  int intervalMinutes;

  double ease;

  DateTime nextReviewAt;

  DateTime createdAt;

  String? extras;

  @override
  _isd.Table<_isc.UuidValue?> get table => t;

  /// Returns a shallow copy of this [LocalProgress]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LocalProgress copyWith({
    _isc.UuidValue? id = const _isc.$UndefinedUuidValue(),
    int? spaceId,
    _isc.UuidValue? vocabularyId,
    _iwjoehei.LocalVocabulary? vocabulary =
        const _UndefinedLocalProgress$vocabulary(),
    String? languageCode,
    String? stage,
    double? level,
    int? intervalMinutes,
    double? ease,
    DateTime? nextReviewAt,
    DateTime? createdAt,
    String? extras,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LocalProgress',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'vocabularyId': vocabularyId.toJson(),
      if (vocabulary != null) 'vocabulary': vocabulary?.toJson(),
      'languageCode': languageCode,
      'stage': stage,
      'level': level,
      'intervalMinutes': intervalMinutes,
      'ease': ease,
      'nextReviewAt': nextReviewAt.toJson(),
      'createdAt': createdAt.toJson(),
      if (extras != null) 'extras': extras,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LocalProgress',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'vocabularyId': vocabularyId.toJson(),
      if (vocabulary != null) 'vocabulary': vocabulary?.toJsonForProtocol(),
      'languageCode': languageCode,
      'stage': stage,
      'level': level,
      'intervalMinutes': intervalMinutes,
      'ease': ease,
      'nextReviewAt': nextReviewAt.toJson(),
      'createdAt': createdAt.toJson(),
      if (extras != null) 'extras': extras,
    };
  }

  static LocalProgressInclude include({
    _iwjoehei.LocalVocabularyInclude? vocabulary,
  }) {
    return LocalProgressInclude._(vocabulary: vocabulary);
  }

  static LocalProgressIncludeList includeList({
    _isd.WhereExpressionBuilder<LocalProgressTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalProgressTable>? orderBy,
    _isd.OrderByListBuilder<LocalProgressTable>? orderByList,
    LocalProgressInclude? include,
  }) {
    return LocalProgressIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocalProgress.t),
      orderByList: orderByList?.call(LocalProgress.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UndefinedLocalProgress$vocabulary extends _isc.UndefinedSentinel
    implements _iwjoehei.LocalVocabulary {
  const _UndefinedLocalProgress$vocabulary();
}

class _LocalProgressImpl extends LocalProgress {
  _LocalProgressImpl({
    _isc.UuidValue? id,
    int? spaceId,
    required _isc.UuidValue vocabularyId,
    _iwjoehei.LocalVocabulary? vocabulary,
    required String languageCode,
    required String stage,
    required double level,
    required int intervalMinutes,
    required double ease,
    required DateTime nextReviewAt,
    required DateTime createdAt,
    String? extras,
  }) : super._(
         id: id,
         spaceId: spaceId,
         vocabularyId: vocabularyId,
         vocabulary: vocabulary,
         languageCode: languageCode,
         stage: stage,
         level: level,
         intervalMinutes: intervalMinutes,
         ease: ease,
         nextReviewAt: nextReviewAt,
         createdAt: createdAt,
         extras: extras,
       );

  /// Returns a shallow copy of this [LocalProgress]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LocalProgress copyWith({
    _isc.UuidValue? id = const _isc.$UndefinedUuidValue(),
    Object? spaceId = _Undefined,
    _isc.UuidValue? vocabularyId,
    _iwjoehei.LocalVocabulary? vocabulary =
        const _UndefinedLocalProgress$vocabulary(),
    String? languageCode,
    String? stage,
    double? level,
    int? intervalMinutes,
    double? ease,
    DateTime? nextReviewAt,
    DateTime? createdAt,
    Object? extras = _Undefined,
  }) {
    return LocalProgress(
      id: id is _isc.UndefinedSentinel ? this.id : id,
      spaceId: spaceId is int? ? spaceId : this.spaceId,
      vocabularyId: vocabularyId ?? this.vocabularyId,
      vocabulary: vocabulary is _isc.UndefinedSentinel
          ? this.vocabulary?.copyWith()
          : vocabulary,
      languageCode: languageCode ?? this.languageCode,
      stage: stage ?? this.stage,
      level: level ?? this.level,
      intervalMinutes: intervalMinutes ?? this.intervalMinutes,
      ease: ease ?? this.ease,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      createdAt: createdAt ?? this.createdAt,
      extras: extras is String? ? extras : this.extras,
    );
  }
}

class LocalProgressUpdateTable extends _isd.UpdateTable<LocalProgressTable> {
  LocalProgressUpdateTable(super.table);

  _isd.ColumnValue<int, int> spaceId(int? value) => _isd.ColumnValue(
    table.spaceId,
    value,
  );

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> vocabularyId(
    _isc.UuidValue value,
  ) => _isd.ColumnValue(
    table.vocabularyId,
    value,
  );

  _isd.ColumnValue<String, String> languageCode(String value) =>
      _isd.ColumnValue(
        table.languageCode,
        value,
      );

  _isd.ColumnValue<String, String> stage(String value) => _isd.ColumnValue(
    table.stage,
    value,
  );

  _isd.ColumnValue<double, double> level(double value) => _isd.ColumnValue(
    table.level,
    value,
  );

  _isd.ColumnValue<int, int> intervalMinutes(int value) => _isd.ColumnValue(
    table.intervalMinutes,
    value,
  );

  _isd.ColumnValue<double, double> ease(double value) => _isd.ColumnValue(
    table.ease,
    value,
  );

  _isd.ColumnValue<DateTime, DateTime> nextReviewAt(DateTime value) =>
      _isd.ColumnValue(
        table.nextReviewAt,
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

class LocalProgressTable extends _isd.Table<_isc.UuidValue?> {
  LocalProgressTable({super.tableRelation}) : super(tableName: 'progress') {
    updateTable = LocalProgressUpdateTable(this);
    spaceId = _isd.ColumnInt(
      'spaceId',
      this,
    );
    vocabularyId = _isd.ColumnUuid(
      'vocabularyId',
      this,
    );
    languageCode = _isd.ColumnString(
      'languageCode',
      this,
    );
    stage = _isd.ColumnString(
      'stage',
      this,
    );
    level = _isd.ColumnDouble(
      'level',
      this,
    );
    intervalMinutes = _isd.ColumnInt(
      'intervalMinutes',
      this,
    );
    ease = _isd.ColumnDouble(
      'ease',
      this,
    );
    nextReviewAt = _isd.ColumnDateTime(
      'nextReviewAt',
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

  late final LocalProgressUpdateTable updateTable;

  /// The space owning this row. Maintained by the sync engine.
  late final _isd.ColumnInt spaceId;

  late final _isd.ColumnUuid vocabularyId;

  _iwjoehei.LocalVocabularyTable? _vocabulary;

  late final _isd.ColumnString languageCode;

  late final _isd.ColumnString stage;

  late final _isd.ColumnDouble level;

  late final _isd.ColumnInt intervalMinutes;

  late final _isd.ColumnDouble ease;

  late final _isd.ColumnDateTime nextReviewAt;

  late final _isd.ColumnDateTime createdAt;

  late final _isd.ColumnString extras;

  _iwjoehei.LocalVocabularyTable get vocabulary {
    if (_vocabulary != null) return _vocabulary!;
    _vocabulary = _isd.createRelationTable(
      relationFieldName: 'vocabulary',
      field: LocalProgress.t.vocabularyId,
      foreignField: _iwjoehei.LocalVocabulary.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iwjoehei.LocalVocabularyTable(tableRelation: foreignTableRelation),
    );
    return _vocabulary!;
  }

  @override
  List<_isd.Column> get columns => [
    id,
    spaceId,
    vocabularyId,
    languageCode,
    stage,
    level,
    intervalMinutes,
    ease,
    nextReviewAt,
    createdAt,
    extras,
  ];

  @override
  _isd.Table? getRelationTable(String relationField) {
    if (relationField == 'vocabulary') {
      return vocabulary;
    }
    return null;
  }
}

class LocalProgressInclude extends _isd.IncludeObject {
  LocalProgressInclude._({_iwjoehei.LocalVocabularyInclude? vocabulary}) {
    _vocabulary = vocabulary;
  }

  _iwjoehei.LocalVocabularyInclude? _vocabulary;

  @override
  Map<String, _isd.Include?> get includes => {'vocabulary': _vocabulary};

  @override
  _isd.Table<_isc.UuidValue?> get table => LocalProgress.t;
}

class LocalProgressIncludeList extends _isd.IncludeList {
  LocalProgressIncludeList._({
    _isd.WhereExpressionBuilder<LocalProgressTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LocalProgress.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<_isc.UuidValue?> get table => LocalProgress.t;
}

class LocalProgressRepository {
  const LocalProgressRepository._();

  final attachRow = const LocalProgressAttachRowRepository._();

  /// Returns a list of [LocalProgress]s matching the given query parameters.
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
  Future<List<LocalProgress>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalProgressTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalProgressTable>? orderBy,
    _isd.OrderByListBuilder<LocalProgressTable>? orderByList,
    _isd.Transaction? transaction,
    LocalProgressInclude? include,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LocalProgress>(
      where: where?.call(LocalProgress.t),
      orderBy: orderBy?.call(LocalProgress.t),
      orderByList: orderByList?.call(LocalProgress.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [LocalProgress]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `LocalProgress.t`.
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
  _ida.Stream<List<LocalProgress>> watch(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalProgressTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalProgressTable>? orderBy,
    _isd.OrderByListBuilder<LocalProgressTable>? orderByList,
    LocalProgressInclude? include,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_isd.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<LocalProgress>(
      where: where?.call(LocalProgress.t),
      orderBy: orderBy?.call(LocalProgress.t),
      orderByList: orderByList?.call(LocalProgress.t),
      limit: limit,
      offset: offset,
      include: include,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [LocalProgress] matching the given query parameters.
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
  Future<LocalProgress?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalProgressTable>? where,
    int? offset,
    _isd.OrderByBuilder<LocalProgressTable>? orderBy,
    _isd.OrderByListBuilder<LocalProgressTable>? orderByList,
    _isd.Transaction? transaction,
    LocalProgressInclude? include,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LocalProgress>(
      where: where?.call(LocalProgress.t),
      orderBy: orderBy?.call(LocalProgress.t),
      orderByList: orderByList?.call(LocalProgress.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LocalProgress] by its [id] or null if no such row exists.
  Future<LocalProgress?> findById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    _isd.Transaction? transaction,
    LocalProgressInclude? include,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LocalProgress>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LocalProgress]s in the list and returns the inserted rows.
  ///
  /// The returned [LocalProgress]s will have their `id` fields set.
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
  Future<List<LocalProgress>> insert(
    _isd.DatabaseSession session,
    List<LocalProgress> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<LocalProgress>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [LocalProgress] and returns the inserted row.
  ///
  /// The returned [LocalProgress] will have its `id` field set.
  Future<LocalProgress> insertRow(
    _isd.DatabaseSession session,
    LocalProgress row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<LocalProgress>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [LocalProgress]s in the list and returns the resulting rows.
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
  /// The returned [LocalProgress]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalProgress>> upsert(
    _isd.DatabaseSession session,
    List<LocalProgress> rows, {
    required _isd.ColumnSelections<LocalProgressTable> conflictColumns,
    _isd.ColumnSelections<LocalProgressTable>? updateColumns,
    _isd.WhereExpressionBuilder<LocalProgressTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<LocalProgress>(
      rows,
      conflictColumns: conflictColumns(LocalProgress.t),
      updateColumns: updateColumns?.call(LocalProgress.t),
      updateWhere: updateWhere?.call(LocalProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [LocalProgress] and returns the resulting row.
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
  /// The returned [LocalProgress] will have its `id` field set.
  Future<LocalProgress?> upsertRow(
    _isd.DatabaseSession session,
    LocalProgress row, {
    required _isd.ColumnSelections<LocalProgressTable> conflictColumns,
    _isd.ColumnSelections<LocalProgressTable>? updateColumns,
    _isd.WhereExpressionBuilder<LocalProgressTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<LocalProgress>(
      row,
      conflictColumns: conflictColumns(LocalProgress.t),
      updateColumns: updateColumns?.call(LocalProgress.t),
      updateWhere: updateWhere?.call(LocalProgress.t),
      transaction: transaction,
    );
  }

  /// Updates all [LocalProgress]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalProgress>> update(
    _isd.DatabaseSession session,
    List<LocalProgress> rows, {
    _isd.ColumnSelections<LocalProgressTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<LocalProgress>(
      rows,
      columns: columns?.call(LocalProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [LocalProgress]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LocalProgress> updateRow(
    _isd.DatabaseSession session,
    LocalProgress row, {
    _isd.ColumnSelections<LocalProgressTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<LocalProgress>(
      row,
      columns: columns?.call(LocalProgress.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LocalProgress] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LocalProgress?> updateById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    required _isd.ColumnValueListBuilder<LocalProgressUpdateTable> columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<LocalProgress>(
      id,
      columnValues: columnValues(LocalProgress.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LocalProgress]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalProgress>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<LocalProgressUpdateTable> columnValues,
    required _isd.WhereExpressionBuilder<LocalProgressTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalProgressTable>? orderBy,
    _isd.OrderByListBuilder<LocalProgressTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<LocalProgress>(
      columnValues: columnValues(LocalProgress.t.updateTable),
      where: where(LocalProgress.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocalProgress.t),
      orderByList: orderByList?.call(LocalProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [LocalProgress]s in the list and returns the deleted rows.
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
  Future<List<LocalProgress>> delete(
    _isd.DatabaseSession session,
    List<LocalProgress> rows, {
    _isd.OrderByBuilder<LocalProgressTable>? orderBy,
    _isd.OrderByListBuilder<LocalProgressTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<LocalProgress>(
      rows,
      orderBy: orderBy?.call(LocalProgress.t),
      orderByList: orderByList?.call(LocalProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [LocalProgress].
  Future<LocalProgress> deleteRow(
    _isd.DatabaseSession session,
    LocalProgress row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LocalProgress>(
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
  Future<List<LocalProgress>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<LocalProgressTable> where,
    _isd.OrderByBuilder<LocalProgressTable>? orderBy,
    _isd.OrderByListBuilder<LocalProgressTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<LocalProgress>(
      where: where(LocalProgress.t),
      orderBy: orderBy?.call(LocalProgress.t),
      orderByList: orderByList?.call(LocalProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalProgressTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<LocalProgress>(
      where: where?.call(LocalProgress.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LocalProgress] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<LocalProgressTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LocalProgress>(
      where: where(LocalProgress.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class LocalProgressAttachRowRepository {
  const LocalProgressAttachRowRepository._();

  /// Creates a relation between the given [LocalProgress] and [LocalVocabulary]
  /// by setting the [LocalProgress]'s foreign key `vocabularyId` to refer to the [LocalVocabulary].
  Future<void> vocabulary(
    _isd.DatabaseSession session,
    LocalProgress localProgress,
    _iwjoehei.LocalVocabulary vocabulary, {
    _isd.Transaction? transaction,
  }) async {
    if (localProgress.id == null) {
      throw ArgumentError.notNull('localProgress.id');
    }
    if (vocabulary.id == null) {
      throw ArgumentError.notNull('vocabulary.id');
    }

    var $localProgress = localProgress.copyWith(vocabularyId: vocabulary.id);
    await session.db.updateRow<LocalProgress>(
      $localProgress,
      columns: [LocalProgress.t.vocabularyId],
      transaction: transaction,
    );
  }
}
