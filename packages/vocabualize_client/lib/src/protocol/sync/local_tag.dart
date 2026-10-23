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

import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_database/serverpod_database.dart' as _isd;

abstract class LocalTag
    implements _isd.TableRow<_isc.UuidValue?>, _isc.ProtocolSerialization {
  LocalTag._({
    this.id,
    this.spaceId,
    required this.name,
    required this.createdAt,
    this.extras,
  });

  factory LocalTag({
    _isc.UuidValue? id,
    int? spaceId,
    required String name,
    required DateTime createdAt,
    String? extras,
  }) = _LocalTagImpl;

  factory LocalTag.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocalTag(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      spaceId: jsonSerialization['spaceId'] as int?,
      name: jsonSerialization['name'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      extras: jsonSerialization['extras'] as String?,
    );
  }

  static final t = LocalTagTable();

  static const db = LocalTagRepository._();

  @override
  _isc.UuidValue? id;

  /// The space owning this row. Maintained by the sync engine.
  int? spaceId;

  String name;

  DateTime createdAt;

  String? extras;

  @override
  _isd.Table<_isc.UuidValue?> get table => t;

  /// Returns a shallow copy of this [LocalTag]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LocalTag copyWith({
    _isc.UuidValue? id = const _isc.$UndefinedUuidValue(),
    int? spaceId,
    String? name,
    DateTime? createdAt,
    String? extras,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LocalTag',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'name': name,
      'createdAt': createdAt.toJson(),
      if (extras != null) 'extras': extras,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LocalTag',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'name': name,
      'createdAt': createdAt.toJson(),
      if (extras != null) 'extras': extras,
    };
  }

  static LocalTagInclude include() {
    return LocalTagInclude._();
  }

  static LocalTagIncludeList includeList({
    _isd.WhereExpressionBuilder<LocalTagTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalTagTable>? orderBy,
    _isd.OrderByListBuilder<LocalTagTable>? orderByList,
    LocalTagInclude? include,
  }) {
    return LocalTagIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocalTag.t),
      orderByList: orderByList?.call(LocalTag.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocalTagImpl extends LocalTag {
  _LocalTagImpl({
    _isc.UuidValue? id,
    int? spaceId,
    required String name,
    required DateTime createdAt,
    String? extras,
  }) : super._(
         id: id,
         spaceId: spaceId,
         name: name,
         createdAt: createdAt,
         extras: extras,
       );

  /// Returns a shallow copy of this [LocalTag]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LocalTag copyWith({
    _isc.UuidValue? id = const _isc.$UndefinedUuidValue(),
    Object? spaceId = _Undefined,
    String? name,
    DateTime? createdAt,
    Object? extras = _Undefined,
  }) {
    return LocalTag(
      id: id is _isc.UndefinedSentinel ? this.id : id,
      spaceId: spaceId is int? ? spaceId : this.spaceId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      extras: extras is String? ? extras : this.extras,
    );
  }
}

class LocalTagUpdateTable extends _isd.UpdateTable<LocalTagTable> {
  LocalTagUpdateTable(super.table);

  _isd.ColumnValue<int, int> spaceId(int? value) => _isd.ColumnValue(
    table.spaceId,
    value,
  );

  _isd.ColumnValue<String, String> name(String value) => _isd.ColumnValue(
    table.name,
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

class LocalTagTable extends _isd.Table<_isc.UuidValue?> {
  LocalTagTable({super.tableRelation}) : super(tableName: 'tag') {
    updateTable = LocalTagUpdateTable(this);
    spaceId = _isd.ColumnInt(
      'spaceId',
      this,
    );
    name = _isd.ColumnString(
      'name',
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

  late final LocalTagUpdateTable updateTable;

  /// The space owning this row. Maintained by the sync engine.
  late final _isd.ColumnInt spaceId;

  late final _isd.ColumnString name;

  late final _isd.ColumnDateTime createdAt;

  late final _isd.ColumnString extras;

  @override
  List<_isd.Column> get columns => [
    id,
    spaceId,
    name,
    createdAt,
    extras,
  ];
}

class LocalTagInclude extends _isd.IncludeObject {
  LocalTagInclude._();

  @override
  Map<String, _isd.Include?> get includes => {};

  @override
  _isd.Table<_isc.UuidValue?> get table => LocalTag.t;
}

class LocalTagIncludeList extends _isd.IncludeList {
  LocalTagIncludeList._({
    _isd.WhereExpressionBuilder<LocalTagTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LocalTag.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<_isc.UuidValue?> get table => LocalTag.t;
}

class LocalTagRepository {
  const LocalTagRepository._();

  /// Returns a list of [LocalTag]s matching the given query parameters.
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
  Future<List<LocalTag>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalTagTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalTagTable>? orderBy,
    _isd.OrderByListBuilder<LocalTagTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LocalTag>(
      where: where?.call(LocalTag.t),
      orderBy: orderBy?.call(LocalTag.t),
      orderByList: orderByList?.call(LocalTag.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [LocalTag]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `LocalTag.t`.
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
  _ida.Stream<List<LocalTag>> watch(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalTagTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalTagTable>? orderBy,
    _isd.OrderByListBuilder<LocalTagTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_isd.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<LocalTag>(
      where: where?.call(LocalTag.t),
      orderBy: orderBy?.call(LocalTag.t),
      orderByList: orderByList?.call(LocalTag.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [LocalTag] matching the given query parameters.
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
  Future<LocalTag?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalTagTable>? where,
    int? offset,
    _isd.OrderByBuilder<LocalTagTable>? orderBy,
    _isd.OrderByListBuilder<LocalTagTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LocalTag>(
      where: where?.call(LocalTag.t),
      orderBy: orderBy?.call(LocalTag.t),
      orderByList: orderByList?.call(LocalTag.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LocalTag] by its [id] or null if no such row exists.
  Future<LocalTag?> findById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LocalTag>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LocalTag]s in the list and returns the inserted rows.
  ///
  /// The returned [LocalTag]s will have their `id` fields set.
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
  Future<List<LocalTag>> insert(
    _isd.DatabaseSession session,
    List<LocalTag> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<LocalTag>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [LocalTag] and returns the inserted row.
  ///
  /// The returned [LocalTag] will have its `id` field set.
  Future<LocalTag> insertRow(
    _isd.DatabaseSession session,
    LocalTag row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<LocalTag>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [LocalTag]s in the list and returns the resulting rows.
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
  /// The returned [LocalTag]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalTag>> upsert(
    _isd.DatabaseSession session,
    List<LocalTag> rows, {
    required _isd.ColumnSelections<LocalTagTable> conflictColumns,
    _isd.ColumnSelections<LocalTagTable>? updateColumns,
    _isd.WhereExpressionBuilder<LocalTagTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<LocalTag>(
      rows,
      conflictColumns: conflictColumns(LocalTag.t),
      updateColumns: updateColumns?.call(LocalTag.t),
      updateWhere: updateWhere?.call(LocalTag.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [LocalTag] and returns the resulting row.
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
  /// The returned [LocalTag] will have its `id` field set.
  Future<LocalTag?> upsertRow(
    _isd.DatabaseSession session,
    LocalTag row, {
    required _isd.ColumnSelections<LocalTagTable> conflictColumns,
    _isd.ColumnSelections<LocalTagTable>? updateColumns,
    _isd.WhereExpressionBuilder<LocalTagTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<LocalTag>(
      row,
      conflictColumns: conflictColumns(LocalTag.t),
      updateColumns: updateColumns?.call(LocalTag.t),
      updateWhere: updateWhere?.call(LocalTag.t),
      transaction: transaction,
    );
  }

  /// Updates all [LocalTag]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalTag>> update(
    _isd.DatabaseSession session,
    List<LocalTag> rows, {
    _isd.ColumnSelections<LocalTagTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<LocalTag>(
      rows,
      columns: columns?.call(LocalTag.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [LocalTag]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LocalTag> updateRow(
    _isd.DatabaseSession session,
    LocalTag row, {
    _isd.ColumnSelections<LocalTagTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<LocalTag>(
      row,
      columns: columns?.call(LocalTag.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LocalTag] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LocalTag?> updateById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    required _isd.ColumnValueListBuilder<LocalTagUpdateTable> columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<LocalTag>(
      id,
      columnValues: columnValues(LocalTag.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LocalTag]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalTag>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<LocalTagUpdateTable> columnValues,
    required _isd.WhereExpressionBuilder<LocalTagTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalTagTable>? orderBy,
    _isd.OrderByListBuilder<LocalTagTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<LocalTag>(
      columnValues: columnValues(LocalTag.t.updateTable),
      where: where(LocalTag.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocalTag.t),
      orderByList: orderByList?.call(LocalTag.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [LocalTag]s in the list and returns the deleted rows.
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
  Future<List<LocalTag>> delete(
    _isd.DatabaseSession session,
    List<LocalTag> rows, {
    _isd.OrderByBuilder<LocalTagTable>? orderBy,
    _isd.OrderByListBuilder<LocalTagTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<LocalTag>(
      rows,
      orderBy: orderBy?.call(LocalTag.t),
      orderByList: orderByList?.call(LocalTag.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [LocalTag].
  Future<LocalTag> deleteRow(
    _isd.DatabaseSession session,
    LocalTag row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LocalTag>(
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
  Future<List<LocalTag>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<LocalTagTable> where,
    _isd.OrderByBuilder<LocalTagTable>? orderBy,
    _isd.OrderByListBuilder<LocalTagTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<LocalTag>(
      where: where(LocalTag.t),
      orderBy: orderBy?.call(LocalTag.t),
      orderByList: orderByList?.call(LocalTag.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalTagTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<LocalTag>(
      where: where?.call(LocalTag.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LocalTag] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<LocalTagTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LocalTag>(
      where: where(LocalTag.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
