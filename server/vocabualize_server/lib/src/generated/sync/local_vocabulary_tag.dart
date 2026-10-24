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
import 'package:serverpod/serverpod.dart' as _is;
import 'package:vocabualize_server/src/generated/protocol.dart' as _i935iz7n;
import '../sync/local_tag.dart' as _i739zjxr;
import '../sync/local_vocabulary.dart' as _iwjoehei;

abstract class LocalVocabularyTag
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  LocalVocabularyTag._({
    this.id,
    this.spaceId,
    required this.vocabularyId,
    this.vocabulary,
    required this.tagId,
    this.tag,
    this.extras,
  });

  factory LocalVocabularyTag({
    _is.UuidValue? id,
    int? spaceId,
    required _is.UuidValue vocabularyId,
    _iwjoehei.LocalVocabulary? vocabulary,
    required _is.UuidValue tagId,
    _i739zjxr.LocalTag? tag,
    String? extras,
  }) = _LocalVocabularyTagImpl;

  factory LocalVocabularyTag.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocalVocabularyTag(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      spaceId: jsonSerialization['spaceId'] as int?,
      vocabularyId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['vocabularyId']),
      vocabulary: jsonSerialization['vocabulary'] == null
          ? null
          : _i935iz7n.Protocol().deserialize<_iwjoehei.LocalVocabulary>(
              jsonSerialization['vocabulary'],
            ),
      tagId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['tagId']),
      tag: jsonSerialization['tag'] == null
          ? null
          : _i935iz7n.Protocol().deserialize<_i739zjxr.LocalTag>(jsonSerialization['tag']),
      extras: jsonSerialization['extras'] as String?,
    );
  }

  static final t = LocalVocabularyTagTable();

  static const db = LocalVocabularyTagRepository._();

  @override
  _is.UuidValue? id;

  /// The space owning this row. Maintained by the sync engine.
  int? spaceId;

  _is.UuidValue vocabularyId;

  _iwjoehei.LocalVocabulary? vocabulary;

  _is.UuidValue tagId;

  _i739zjxr.LocalTag? tag;

  String? extras;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [LocalVocabularyTag]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LocalVocabularyTag copyWith({
    _is.UuidValue? id = const _is.$UndefinedUuidValue(),
    int? spaceId,
    _is.UuidValue? vocabularyId,
    _iwjoehei.LocalVocabulary? vocabulary = const _UndefinedLocalVocabularyTag$vocabulary(),
    _is.UuidValue? tagId,
    _i739zjxr.LocalTag? tag = const _UndefinedLocalVocabularyTag$tag(),
    String? extras,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LocalVocabularyTag',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'vocabularyId': vocabularyId.toJson(),
      if (vocabulary != null) 'vocabulary': vocabulary?.toJson(),
      'tagId': tagId.toJson(),
      if (tag != null) 'tag': tag?.toJson(),
      if (extras != null) 'extras': extras,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LocalVocabularyTag',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'vocabularyId': vocabularyId.toJson(),
      if (vocabulary != null) 'vocabulary': vocabulary?.toJsonForProtocol(),
      'tagId': tagId.toJson(),
      if (tag != null) 'tag': tag?.toJsonForProtocol(),
      if (extras != null) 'extras': extras,
    };
  }

  static LocalVocabularyTagInclude include({
    _iwjoehei.LocalVocabularyInclude? vocabulary,
    _i739zjxr.LocalTagInclude? tag,
  }) {
    return LocalVocabularyTagInclude._(
      vocabulary: vocabulary,
      tag: tag,
    );
  }

  static LocalVocabularyTagIncludeList includeList({
    _is.WhereExpressionBuilder<LocalVocabularyTagTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LocalVocabularyTagTable>? orderBy,
    _is.OrderByListBuilder<LocalVocabularyTagTable>? orderByList,
    LocalVocabularyTagInclude? include,
  }) {
    return LocalVocabularyTagIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocalVocabularyTag.t),
      orderByList: orderByList?.call(LocalVocabularyTag.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UndefinedLocalVocabularyTag$vocabulary extends _is.UndefinedSentinel
    implements _iwjoehei.LocalVocabulary {
  const _UndefinedLocalVocabularyTag$vocabulary();
}

class _UndefinedLocalVocabularyTag$tag extends _is.UndefinedSentinel implements _i739zjxr.LocalTag {
  const _UndefinedLocalVocabularyTag$tag();
}

class _LocalVocabularyTagImpl extends LocalVocabularyTag {
  _LocalVocabularyTagImpl({
    _is.UuidValue? id,
    int? spaceId,
    required _is.UuidValue vocabularyId,
    _iwjoehei.LocalVocabulary? vocabulary,
    required _is.UuidValue tagId,
    _i739zjxr.LocalTag? tag,
    String? extras,
  }) : super._(
         id: id,
         spaceId: spaceId,
         vocabularyId: vocabularyId,
         vocabulary: vocabulary,
         tagId: tagId,
         tag: tag,
         extras: extras,
       );

  /// Returns a shallow copy of this [LocalVocabularyTag]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LocalVocabularyTag copyWith({
    _is.UuidValue? id = const _is.$UndefinedUuidValue(),
    Object? spaceId = _Undefined,
    _is.UuidValue? vocabularyId,
    _iwjoehei.LocalVocabulary? vocabulary = const _UndefinedLocalVocabularyTag$vocabulary(),
    _is.UuidValue? tagId,
    _i739zjxr.LocalTag? tag = const _UndefinedLocalVocabularyTag$tag(),
    Object? extras = _Undefined,
  }) {
    return LocalVocabularyTag(
      id: id is _is.UndefinedSentinel ? this.id : id,
      spaceId: spaceId is int? ? spaceId : this.spaceId,
      vocabularyId: vocabularyId ?? this.vocabularyId,
      vocabulary: vocabulary is _is.UndefinedSentinel ? this.vocabulary?.copyWith() : vocabulary,
      tagId: tagId ?? this.tagId,
      tag: tag is _is.UndefinedSentinel ? this.tag?.copyWith() : tag,
      extras: extras is String? ? extras : this.extras,
    );
  }
}

class LocalVocabularyTagUpdateTable extends _is.UpdateTable<LocalVocabularyTagTable> {
  LocalVocabularyTagUpdateTable(super.table);

  _is.ColumnValue<int, int> spaceId(int? value) => _is.ColumnValue(
    table.spaceId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> vocabularyId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.vocabularyId,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> tagId(_is.UuidValue value) => _is.ColumnValue(
    table.tagId,
    value,
  );

  _is.ColumnValue<String, String> extras(String? value) => _is.ColumnValue(
    table.extras,
    value,
  );
}

class LocalVocabularyTagTable extends _is.Table<_is.UuidValue?> {
  LocalVocabularyTagTable({super.tableRelation}) : super(tableName: 'vocabulary_tag') {
    updateTable = LocalVocabularyTagUpdateTable(this);
    spaceId = _is.ColumnInt(
      'spaceId',
      this,
    );
    vocabularyId = _is.ColumnUuid(
      'vocabularyId',
      this,
    );
    tagId = _is.ColumnUuid(
      'tagId',
      this,
    );
    extras = _is.ColumnString(
      'extras',
      this,
    );
  }

  late final LocalVocabularyTagUpdateTable updateTable;

  /// The space owning this row. Maintained by the sync engine.
  late final _is.ColumnInt spaceId;

  late final _is.ColumnUuid vocabularyId;

  _iwjoehei.LocalVocabularyTable? _vocabulary;

  late final _is.ColumnUuid tagId;

  _i739zjxr.LocalTagTable? _tag;

  late final _is.ColumnString extras;

  _iwjoehei.LocalVocabularyTable get vocabulary {
    if (_vocabulary != null) return _vocabulary!;
    _vocabulary = _is.createRelationTable(
      relationFieldName: 'vocabulary',
      field: LocalVocabularyTag.t.vocabularyId,
      foreignField: _iwjoehei.LocalVocabulary.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iwjoehei.LocalVocabularyTable(tableRelation: foreignTableRelation),
    );
    return _vocabulary!;
  }

  _i739zjxr.LocalTagTable get tag {
    if (_tag != null) return _tag!;
    _tag = _is.createRelationTable(
      relationFieldName: 'tag',
      field: LocalVocabularyTag.t.tagId,
      foreignField: _i739zjxr.LocalTag.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i739zjxr.LocalTagTable(tableRelation: foreignTableRelation),
    );
    return _tag!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    spaceId,
    vocabularyId,
    tagId,
    extras,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'vocabulary') {
      return vocabulary;
    }
    if (relationField == 'tag') {
      return tag;
    }
    return null;
  }
}

class LocalVocabularyTagInclude extends _is.IncludeObject {
  LocalVocabularyTagInclude._({
    _iwjoehei.LocalVocabularyInclude? vocabulary,
    _i739zjxr.LocalTagInclude? tag,
  }) {
    _vocabulary = vocabulary;
    _tag = tag;
  }

  _iwjoehei.LocalVocabularyInclude? _vocabulary;

  _i739zjxr.LocalTagInclude? _tag;

  @override
  Map<String, _is.Include?> get includes => {
    'vocabulary': _vocabulary,
    'tag': _tag,
  };

  @override
  _is.Table<_is.UuidValue?> get table => LocalVocabularyTag.t;
}

class LocalVocabularyTagIncludeList extends _is.IncludeList {
  LocalVocabularyTagIncludeList._({
    _is.WhereExpressionBuilder<LocalVocabularyTagTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LocalVocabularyTag.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => LocalVocabularyTag.t;
}

class LocalVocabularyTagRepository {
  const LocalVocabularyTagRepository._();

  final attachRow = const LocalVocabularyTagAttachRowRepository._();

  /// Returns a list of [LocalVocabularyTag]s matching the given query parameters.
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
  Future<List<LocalVocabularyTag>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LocalVocabularyTagTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LocalVocabularyTagTable>? orderBy,
    _is.OrderByListBuilder<LocalVocabularyTagTable>? orderByList,
    _is.Transaction? transaction,
    LocalVocabularyTagInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LocalVocabularyTag>(
      where: where?.call(LocalVocabularyTag.t),
      orderBy: orderBy?.call(LocalVocabularyTag.t),
      orderByList: orderByList?.call(LocalVocabularyTag.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [LocalVocabularyTag]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `LocalVocabularyTag.t`.
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
  _ida.Stream<List<LocalVocabularyTag>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LocalVocabularyTagTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LocalVocabularyTagTable>? orderBy,
    _is.OrderByListBuilder<LocalVocabularyTagTable>? orderByList,
    LocalVocabularyTagInclude? include,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<LocalVocabularyTag>(
      where: where?.call(LocalVocabularyTag.t),
      orderBy: orderBy?.call(LocalVocabularyTag.t),
      orderByList: orderByList?.call(LocalVocabularyTag.t),
      limit: limit,
      offset: offset,
      include: include,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [LocalVocabularyTag] matching the given query parameters.
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
  Future<LocalVocabularyTag?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LocalVocabularyTagTable>? where,
    int? offset,
    _is.OrderByBuilder<LocalVocabularyTagTable>? orderBy,
    _is.OrderByListBuilder<LocalVocabularyTagTable>? orderByList,
    _is.Transaction? transaction,
    LocalVocabularyTagInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LocalVocabularyTag>(
      where: where?.call(LocalVocabularyTag.t),
      orderBy: orderBy?.call(LocalVocabularyTag.t),
      orderByList: orderByList?.call(LocalVocabularyTag.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LocalVocabularyTag] by its [id] or null if no such row exists.
  Future<LocalVocabularyTag?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    LocalVocabularyTagInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LocalVocabularyTag>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LocalVocabularyTag]s in the list and returns the inserted rows.
  ///
  /// The returned [LocalVocabularyTag]s will have their `id` fields set.
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
  Future<List<LocalVocabularyTag>> insert(
    _is.DatabaseSession session,
    List<LocalVocabularyTag> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<LocalVocabularyTag>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [LocalVocabularyTag] and returns the inserted row.
  ///
  /// The returned [LocalVocabularyTag] will have its `id` field set.
  Future<LocalVocabularyTag> insertRow(
    _is.DatabaseSession session,
    LocalVocabularyTag row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<LocalVocabularyTag>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [LocalVocabularyTag]s in the list and returns the resulting rows.
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
  /// The returned [LocalVocabularyTag]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalVocabularyTag>> upsert(
    _is.DatabaseSession session,
    List<LocalVocabularyTag> rows, {
    required _is.ColumnSelections<LocalVocabularyTagTable> conflictColumns,
    _is.ColumnSelections<LocalVocabularyTagTable>? updateColumns,
    _is.WhereExpressionBuilder<LocalVocabularyTagTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<LocalVocabularyTag>(
      rows,
      conflictColumns: conflictColumns(LocalVocabularyTag.t),
      updateColumns: updateColumns?.call(LocalVocabularyTag.t),
      updateWhere: updateWhere?.call(LocalVocabularyTag.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [LocalVocabularyTag] and returns the resulting row.
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
  /// The returned [LocalVocabularyTag] will have its `id` field set.
  Future<LocalVocabularyTag?> upsertRow(
    _is.DatabaseSession session,
    LocalVocabularyTag row, {
    required _is.ColumnSelections<LocalVocabularyTagTable> conflictColumns,
    _is.ColumnSelections<LocalVocabularyTagTable>? updateColumns,
    _is.WhereExpressionBuilder<LocalVocabularyTagTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<LocalVocabularyTag>(
      row,
      conflictColumns: conflictColumns(LocalVocabularyTag.t),
      updateColumns: updateColumns?.call(LocalVocabularyTag.t),
      updateWhere: updateWhere?.call(LocalVocabularyTag.t),
      transaction: transaction,
    );
  }

  /// Updates all [LocalVocabularyTag]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalVocabularyTag>> update(
    _is.DatabaseSession session,
    List<LocalVocabularyTag> rows, {
    _is.ColumnSelections<LocalVocabularyTagTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<LocalVocabularyTag>(
      rows,
      columns: columns?.call(LocalVocabularyTag.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [LocalVocabularyTag]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LocalVocabularyTag> updateRow(
    _is.DatabaseSession session,
    LocalVocabularyTag row, {
    _is.ColumnSelections<LocalVocabularyTagTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<LocalVocabularyTag>(
      row,
      columns: columns?.call(LocalVocabularyTag.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LocalVocabularyTag] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LocalVocabularyTag?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<LocalVocabularyTagUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<LocalVocabularyTag>(
      id,
      columnValues: columnValues(LocalVocabularyTag.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LocalVocabularyTag]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalVocabularyTag>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<LocalVocabularyTagUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<LocalVocabularyTagTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LocalVocabularyTagTable>? orderBy,
    _is.OrderByListBuilder<LocalVocabularyTagTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<LocalVocabularyTag>(
      columnValues: columnValues(LocalVocabularyTag.t.updateTable),
      where: where(LocalVocabularyTag.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocalVocabularyTag.t),
      orderByList: orderByList?.call(LocalVocabularyTag.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [LocalVocabularyTag]s in the list and returns the deleted rows.
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
  Future<List<LocalVocabularyTag>> delete(
    _is.DatabaseSession session,
    List<LocalVocabularyTag> rows, {
    _is.OrderByBuilder<LocalVocabularyTagTable>? orderBy,
    _is.OrderByListBuilder<LocalVocabularyTagTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<LocalVocabularyTag>(
      rows,
      orderBy: orderBy?.call(LocalVocabularyTag.t),
      orderByList: orderByList?.call(LocalVocabularyTag.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [LocalVocabularyTag].
  Future<LocalVocabularyTag> deleteRow(
    _is.DatabaseSession session,
    LocalVocabularyTag row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LocalVocabularyTag>(
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
  Future<List<LocalVocabularyTag>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LocalVocabularyTagTable> where,
    _is.OrderByBuilder<LocalVocabularyTagTable>? orderBy,
    _is.OrderByListBuilder<LocalVocabularyTagTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<LocalVocabularyTag>(
      where: where(LocalVocabularyTag.t),
      orderBy: orderBy?.call(LocalVocabularyTag.t),
      orderByList: orderByList?.call(LocalVocabularyTag.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LocalVocabularyTagTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<LocalVocabularyTag>(
      where: where?.call(LocalVocabularyTag.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LocalVocabularyTag] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LocalVocabularyTagTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LocalVocabularyTag>(
      where: where(LocalVocabularyTag.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class LocalVocabularyTagAttachRowRepository {
  const LocalVocabularyTagAttachRowRepository._();

  /// Creates a relation between the given [LocalVocabularyTag] and [LocalVocabulary]
  /// by setting the [LocalVocabularyTag]'s foreign key `vocabularyId` to refer to the [LocalVocabulary].
  Future<void> vocabulary(
    _is.DatabaseSession session,
    LocalVocabularyTag localVocabularyTag,
    _iwjoehei.LocalVocabulary vocabulary, {
    _is.Transaction? transaction,
  }) async {
    if (localVocabularyTag.id == null) {
      throw ArgumentError.notNull('localVocabularyTag.id');
    }
    if (vocabulary.id == null) {
      throw ArgumentError.notNull('vocabulary.id');
    }

    var $localVocabularyTag = localVocabularyTag.copyWith(vocabularyId: vocabulary.id);
    await session.db.updateRow<LocalVocabularyTag>(
      $localVocabularyTag,
      columns: [LocalVocabularyTag.t.vocabularyId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [LocalVocabularyTag] and [LocalTag]
  /// by setting the [LocalVocabularyTag]'s foreign key `tagId` to refer to the [LocalTag].
  Future<void> tag(
    _is.DatabaseSession session,
    LocalVocabularyTag localVocabularyTag,
    _i739zjxr.LocalTag tag, {
    _is.Transaction? transaction,
  }) async {
    if (localVocabularyTag.id == null) {
      throw ArgumentError.notNull('localVocabularyTag.id');
    }
    if (tag.id == null) {
      throw ArgumentError.notNull('tag.id');
    }

    var $localVocabularyTag = localVocabularyTag.copyWith(tagId: tag.id);
    await session.db.updateRow<LocalVocabularyTag>(
      $localVocabularyTag,
      columns: [LocalVocabularyTag.t.tagId],
      transaction: transaction,
    );
  }
}
