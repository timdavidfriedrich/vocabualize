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

abstract class LocalTranslation
    implements _isd.TableRow<_isc.UuidValue?>, _isc.ProtocolSerialization {
  LocalTranslation._({
    this.id,
    this.spaceId,
    required this.vocabularyId,
    this.vocabulary,
    required this.languageCode,
    required this.text,
    required this.origin,
    this.extras,
  });

  factory LocalTranslation({
    _isc.UuidValue? id,
    int? spaceId,
    required _isc.UuidValue vocabularyId,
    _iwjoehei.LocalVocabulary? vocabulary,
    required String languageCode,
    required String text,
    required String origin,
    String? extras,
  }) = _LocalTranslationImpl;

  factory LocalTranslation.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocalTranslation(
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
      text: jsonSerialization['text'] as String,
      origin: jsonSerialization['origin'] as String,
      extras: jsonSerialization['extras'] as String?,
    );
  }

  static final t = LocalTranslationTable();

  static const db = LocalTranslationRepository._();

  @override
  _isc.UuidValue? id;

  /// The space owning this row. Maintained by the sync engine.
  int? spaceId;

  _isc.UuidValue vocabularyId;

  _iwjoehei.LocalVocabulary? vocabulary;

  String languageCode;

  String text;

  String origin;

  String? extras;

  @override
  _isd.Table<_isc.UuidValue?> get table => t;

  /// Returns a shallow copy of this [LocalTranslation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LocalTranslation copyWith({
    _isc.UuidValue? id = const _isc.$UndefinedUuidValue(),
    int? spaceId,
    _isc.UuidValue? vocabularyId,
    _iwjoehei.LocalVocabulary? vocabulary =
        const _UndefinedLocalTranslation$vocabulary(),
    String? languageCode,
    String? text,
    String? origin,
    String? extras,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LocalTranslation',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'vocabularyId': vocabularyId.toJson(),
      if (vocabulary != null) 'vocabulary': vocabulary?.toJson(),
      'languageCode': languageCode,
      'text': text,
      'origin': origin,
      if (extras != null) 'extras': extras,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LocalTranslation',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'vocabularyId': vocabularyId.toJson(),
      if (vocabulary != null) 'vocabulary': vocabulary?.toJsonForProtocol(),
      'languageCode': languageCode,
      'text': text,
      'origin': origin,
      if (extras != null) 'extras': extras,
    };
  }

  static LocalTranslationInclude include({
    _iwjoehei.LocalVocabularyInclude? vocabulary,
  }) {
    return LocalTranslationInclude._(vocabulary: vocabulary);
  }

  static LocalTranslationIncludeList includeList({
    _isd.WhereExpressionBuilder<LocalTranslationTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalTranslationTable>? orderBy,
    _isd.OrderByListBuilder<LocalTranslationTable>? orderByList,
    LocalTranslationInclude? include,
  }) {
    return LocalTranslationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocalTranslation.t),
      orderByList: orderByList?.call(LocalTranslation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UndefinedLocalTranslation$vocabulary extends _isc.UndefinedSentinel
    implements _iwjoehei.LocalVocabulary {
  const _UndefinedLocalTranslation$vocabulary();
}

class _LocalTranslationImpl extends LocalTranslation {
  _LocalTranslationImpl({
    _isc.UuidValue? id,
    int? spaceId,
    required _isc.UuidValue vocabularyId,
    _iwjoehei.LocalVocabulary? vocabulary,
    required String languageCode,
    required String text,
    required String origin,
    String? extras,
  }) : super._(
         id: id,
         spaceId: spaceId,
         vocabularyId: vocabularyId,
         vocabulary: vocabulary,
         languageCode: languageCode,
         text: text,
         origin: origin,
         extras: extras,
       );

  /// Returns a shallow copy of this [LocalTranslation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LocalTranslation copyWith({
    _isc.UuidValue? id = const _isc.$UndefinedUuidValue(),
    Object? spaceId = _Undefined,
    _isc.UuidValue? vocabularyId,
    _iwjoehei.LocalVocabulary? vocabulary =
        const _UndefinedLocalTranslation$vocabulary(),
    String? languageCode,
    String? text,
    String? origin,
    Object? extras = _Undefined,
  }) {
    return LocalTranslation(
      id: id is _isc.UndefinedSentinel ? this.id : id,
      spaceId: spaceId is int? ? spaceId : this.spaceId,
      vocabularyId: vocabularyId ?? this.vocabularyId,
      vocabulary: vocabulary is _isc.UndefinedSentinel
          ? this.vocabulary?.copyWith()
          : vocabulary,
      languageCode: languageCode ?? this.languageCode,
      text: text ?? this.text,
      origin: origin ?? this.origin,
      extras: extras is String? ? extras : this.extras,
    );
  }
}

class LocalTranslationUpdateTable
    extends _isd.UpdateTable<LocalTranslationTable> {
  LocalTranslationUpdateTable(super.table);

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

  _isd.ColumnValue<String, String> text(String value) => _isd.ColumnValue(
    table.text,
    value,
  );

  _isd.ColumnValue<String, String> origin(String value) => _isd.ColumnValue(
    table.origin,
    value,
  );

  _isd.ColumnValue<String, String> extras(String? value) => _isd.ColumnValue(
    table.extras,
    value,
  );
}

class LocalTranslationTable extends _isd.Table<_isc.UuidValue?> {
  LocalTranslationTable({super.tableRelation})
    : super(tableName: 'translation') {
    updateTable = LocalTranslationUpdateTable(this);
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
    text = _isd.ColumnString(
      'text',
      this,
    );
    origin = _isd.ColumnString(
      'origin',
      this,
    );
    extras = _isd.ColumnString(
      'extras',
      this,
    );
  }

  late final LocalTranslationUpdateTable updateTable;

  /// The space owning this row. Maintained by the sync engine.
  late final _isd.ColumnInt spaceId;

  late final _isd.ColumnUuid vocabularyId;

  _iwjoehei.LocalVocabularyTable? _vocabulary;

  late final _isd.ColumnString languageCode;

  late final _isd.ColumnString text;

  late final _isd.ColumnString origin;

  late final _isd.ColumnString extras;

  _iwjoehei.LocalVocabularyTable get vocabulary {
    if (_vocabulary != null) return _vocabulary!;
    _vocabulary = _isd.createRelationTable(
      relationFieldName: 'vocabulary',
      field: LocalTranslation.t.vocabularyId,
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
    text,
    origin,
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

class LocalTranslationInclude extends _isd.IncludeObject {
  LocalTranslationInclude._({_iwjoehei.LocalVocabularyInclude? vocabulary}) {
    _vocabulary = vocabulary;
  }

  _iwjoehei.LocalVocabularyInclude? _vocabulary;

  @override
  Map<String, _isd.Include?> get includes => {'vocabulary': _vocabulary};

  @override
  _isd.Table<_isc.UuidValue?> get table => LocalTranslation.t;
}

class LocalTranslationIncludeList extends _isd.IncludeList {
  LocalTranslationIncludeList._({
    _isd.WhereExpressionBuilder<LocalTranslationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LocalTranslation.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<_isc.UuidValue?> get table => LocalTranslation.t;
}

class LocalTranslationRepository {
  const LocalTranslationRepository._();

  final attachRow = const LocalTranslationAttachRowRepository._();

  /// Returns a list of [LocalTranslation]s matching the given query parameters.
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
  Future<List<LocalTranslation>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalTranslationTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalTranslationTable>? orderBy,
    _isd.OrderByListBuilder<LocalTranslationTable>? orderByList,
    _isd.Transaction? transaction,
    LocalTranslationInclude? include,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LocalTranslation>(
      where: where?.call(LocalTranslation.t),
      orderBy: orderBy?.call(LocalTranslation.t),
      orderByList: orderByList?.call(LocalTranslation.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [LocalTranslation]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `LocalTranslation.t`.
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
  _ida.Stream<List<LocalTranslation>> watch(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalTranslationTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalTranslationTable>? orderBy,
    _isd.OrderByListBuilder<LocalTranslationTable>? orderByList,
    LocalTranslationInclude? include,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_isd.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<LocalTranslation>(
      where: where?.call(LocalTranslation.t),
      orderBy: orderBy?.call(LocalTranslation.t),
      orderByList: orderByList?.call(LocalTranslation.t),
      limit: limit,
      offset: offset,
      include: include,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [LocalTranslation] matching the given query parameters.
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
  Future<LocalTranslation?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalTranslationTable>? where,
    int? offset,
    _isd.OrderByBuilder<LocalTranslationTable>? orderBy,
    _isd.OrderByListBuilder<LocalTranslationTable>? orderByList,
    _isd.Transaction? transaction,
    LocalTranslationInclude? include,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LocalTranslation>(
      where: where?.call(LocalTranslation.t),
      orderBy: orderBy?.call(LocalTranslation.t),
      orderByList: orderByList?.call(LocalTranslation.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LocalTranslation] by its [id] or null if no such row exists.
  Future<LocalTranslation?> findById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    _isd.Transaction? transaction,
    LocalTranslationInclude? include,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LocalTranslation>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LocalTranslation]s in the list and returns the inserted rows.
  ///
  /// The returned [LocalTranslation]s will have their `id` fields set.
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
  Future<List<LocalTranslation>> insert(
    _isd.DatabaseSession session,
    List<LocalTranslation> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<LocalTranslation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [LocalTranslation] and returns the inserted row.
  ///
  /// The returned [LocalTranslation] will have its `id` field set.
  Future<LocalTranslation> insertRow(
    _isd.DatabaseSession session,
    LocalTranslation row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<LocalTranslation>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [LocalTranslation]s in the list and returns the resulting rows.
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
  /// The returned [LocalTranslation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalTranslation>> upsert(
    _isd.DatabaseSession session,
    List<LocalTranslation> rows, {
    required _isd.ColumnSelections<LocalTranslationTable> conflictColumns,
    _isd.ColumnSelections<LocalTranslationTable>? updateColumns,
    _isd.WhereExpressionBuilder<LocalTranslationTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<LocalTranslation>(
      rows,
      conflictColumns: conflictColumns(LocalTranslation.t),
      updateColumns: updateColumns?.call(LocalTranslation.t),
      updateWhere: updateWhere?.call(LocalTranslation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [LocalTranslation] and returns the resulting row.
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
  /// The returned [LocalTranslation] will have its `id` field set.
  Future<LocalTranslation?> upsertRow(
    _isd.DatabaseSession session,
    LocalTranslation row, {
    required _isd.ColumnSelections<LocalTranslationTable> conflictColumns,
    _isd.ColumnSelections<LocalTranslationTable>? updateColumns,
    _isd.WhereExpressionBuilder<LocalTranslationTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<LocalTranslation>(
      row,
      conflictColumns: conflictColumns(LocalTranslation.t),
      updateColumns: updateColumns?.call(LocalTranslation.t),
      updateWhere: updateWhere?.call(LocalTranslation.t),
      transaction: transaction,
    );
  }

  /// Updates all [LocalTranslation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalTranslation>> update(
    _isd.DatabaseSession session,
    List<LocalTranslation> rows, {
    _isd.ColumnSelections<LocalTranslationTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<LocalTranslation>(
      rows,
      columns: columns?.call(LocalTranslation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [LocalTranslation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LocalTranslation> updateRow(
    _isd.DatabaseSession session,
    LocalTranslation row, {
    _isd.ColumnSelections<LocalTranslationTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<LocalTranslation>(
      row,
      columns: columns?.call(LocalTranslation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LocalTranslation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LocalTranslation?> updateById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    required _isd.ColumnValueListBuilder<LocalTranslationUpdateTable>
    columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<LocalTranslation>(
      id,
      columnValues: columnValues(LocalTranslation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LocalTranslation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalTranslation>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<LocalTranslationUpdateTable>
    columnValues,
    required _isd.WhereExpressionBuilder<LocalTranslationTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalTranslationTable>? orderBy,
    _isd.OrderByListBuilder<LocalTranslationTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<LocalTranslation>(
      columnValues: columnValues(LocalTranslation.t.updateTable),
      where: where(LocalTranslation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocalTranslation.t),
      orderByList: orderByList?.call(LocalTranslation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [LocalTranslation]s in the list and returns the deleted rows.
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
  Future<List<LocalTranslation>> delete(
    _isd.DatabaseSession session,
    List<LocalTranslation> rows, {
    _isd.OrderByBuilder<LocalTranslationTable>? orderBy,
    _isd.OrderByListBuilder<LocalTranslationTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<LocalTranslation>(
      rows,
      orderBy: orderBy?.call(LocalTranslation.t),
      orderByList: orderByList?.call(LocalTranslation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [LocalTranslation].
  Future<LocalTranslation> deleteRow(
    _isd.DatabaseSession session,
    LocalTranslation row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LocalTranslation>(
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
  Future<List<LocalTranslation>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<LocalTranslationTable> where,
    _isd.OrderByBuilder<LocalTranslationTable>? orderBy,
    _isd.OrderByListBuilder<LocalTranslationTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<LocalTranslation>(
      where: where(LocalTranslation.t),
      orderBy: orderBy?.call(LocalTranslation.t),
      orderByList: orderByList?.call(LocalTranslation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalTranslationTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<LocalTranslation>(
      where: where?.call(LocalTranslation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LocalTranslation] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<LocalTranslationTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LocalTranslation>(
      where: where(LocalTranslation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class LocalTranslationAttachRowRepository {
  const LocalTranslationAttachRowRepository._();

  /// Creates a relation between the given [LocalTranslation] and [LocalVocabulary]
  /// by setting the [LocalTranslation]'s foreign key `vocabularyId` to refer to the [LocalVocabulary].
  Future<void> vocabulary(
    _isd.DatabaseSession session,
    LocalTranslation localTranslation,
    _iwjoehei.LocalVocabulary vocabulary, {
    _isd.Transaction? transaction,
  }) async {
    if (localTranslation.id == null) {
      throw ArgumentError.notNull('localTranslation.id');
    }
    if (vocabulary.id == null) {
      throw ArgumentError.notNull('vocabulary.id');
    }

    var $localTranslation = localTranslation.copyWith(
      vocabularyId: vocabulary.id,
    );
    await session.db.updateRow<LocalTranslation>(
      $localTranslation,
      columns: [LocalTranslation.t.vocabularyId],
      transaction: transaction,
    );
  }
}
