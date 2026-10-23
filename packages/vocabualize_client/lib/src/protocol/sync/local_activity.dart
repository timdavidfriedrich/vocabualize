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

abstract class LocalActivity
    implements _isd.TableRow<_isc.UuidValue?>, _isc.ProtocolSerialization {
  LocalActivity._({
    this.id,
    this.spaceId,
    required this.type,
    required this.localDate,
    required this.occurredAt,
  });

  factory LocalActivity({
    _isc.UuidValue? id,
    int? spaceId,
    required String type,
    required String localDate,
    required DateTime occurredAt,
  }) = _LocalActivityImpl;

  factory LocalActivity.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocalActivity(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      spaceId: jsonSerialization['spaceId'] as int?,
      type: jsonSerialization['type'] as String,
      localDate: jsonSerialization['localDate'] as String,
      occurredAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
    );
  }

  static final t = LocalActivityTable();

  static const db = LocalActivityRepository._();

  @override
  _isc.UuidValue? id;

  /// The space owning this row. Maintained by the sync engine.
  int? spaceId;

  String type;

  String localDate;

  DateTime occurredAt;

  @override
  _isd.Table<_isc.UuidValue?> get table => t;

  /// Returns a shallow copy of this [LocalActivity]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LocalActivity copyWith({
    _isc.UuidValue? id = const _isc.$UndefinedUuidValue(),
    int? spaceId,
    String? type,
    String? localDate,
    DateTime? occurredAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LocalActivity',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'type': type,
      'localDate': localDate,
      'occurredAt': occurredAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LocalActivity',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'type': type,
      'localDate': localDate,
      'occurredAt': occurredAt.toJson(),
    };
  }

  static LocalActivityInclude include() {
    return LocalActivityInclude._();
  }

  static LocalActivityIncludeList includeList({
    _isd.WhereExpressionBuilder<LocalActivityTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalActivityTable>? orderBy,
    _isd.OrderByListBuilder<LocalActivityTable>? orderByList,
    LocalActivityInclude? include,
  }) {
    return LocalActivityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocalActivity.t),
      orderByList: orderByList?.call(LocalActivity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocalActivityImpl extends LocalActivity {
  _LocalActivityImpl({
    _isc.UuidValue? id,
    int? spaceId,
    required String type,
    required String localDate,
    required DateTime occurredAt,
  }) : super._(
         id: id,
         spaceId: spaceId,
         type: type,
         localDate: localDate,
         occurredAt: occurredAt,
       );

  /// Returns a shallow copy of this [LocalActivity]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LocalActivity copyWith({
    _isc.UuidValue? id = const _isc.$UndefinedUuidValue(),
    Object? spaceId = _Undefined,
    String? type,
    String? localDate,
    DateTime? occurredAt,
  }) {
    return LocalActivity(
      id: id is _isc.UndefinedSentinel ? this.id : id,
      spaceId: spaceId is int? ? spaceId : this.spaceId,
      type: type ?? this.type,
      localDate: localDate ?? this.localDate,
      occurredAt: occurredAt ?? this.occurredAt,
    );
  }
}

class LocalActivityUpdateTable extends _isd.UpdateTable<LocalActivityTable> {
  LocalActivityUpdateTable(super.table);

  _isd.ColumnValue<int, int> spaceId(int? value) => _isd.ColumnValue(
    table.spaceId,
    value,
  );

  _isd.ColumnValue<String, String> type(String value) => _isd.ColumnValue(
    table.type,
    value,
  );

  _isd.ColumnValue<String, String> localDate(String value) => _isd.ColumnValue(
    table.localDate,
    value,
  );

  _isd.ColumnValue<DateTime, DateTime> occurredAt(DateTime value) =>
      _isd.ColumnValue(
        table.occurredAt,
        value,
      );
}

class LocalActivityTable extends _isd.Table<_isc.UuidValue?> {
  LocalActivityTable({super.tableRelation}) : super(tableName: 'activity') {
    updateTable = LocalActivityUpdateTable(this);
    spaceId = _isd.ColumnInt(
      'spaceId',
      this,
    );
    type = _isd.ColumnString(
      'type',
      this,
    );
    localDate = _isd.ColumnString(
      'localDate',
      this,
    );
    occurredAt = _isd.ColumnDateTime(
      'occurredAt',
      this,
    );
  }

  late final LocalActivityUpdateTable updateTable;

  /// The space owning this row. Maintained by the sync engine.
  late final _isd.ColumnInt spaceId;

  late final _isd.ColumnString type;

  late final _isd.ColumnString localDate;

  late final _isd.ColumnDateTime occurredAt;

  @override
  List<_isd.Column> get columns => [
    id,
    spaceId,
    type,
    localDate,
    occurredAt,
  ];
}

class LocalActivityInclude extends _isd.IncludeObject {
  LocalActivityInclude._();

  @override
  Map<String, _isd.Include?> get includes => {};

  @override
  _isd.Table<_isc.UuidValue?> get table => LocalActivity.t;
}

class LocalActivityIncludeList extends _isd.IncludeList {
  LocalActivityIncludeList._({
    _isd.WhereExpressionBuilder<LocalActivityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LocalActivity.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<_isc.UuidValue?> get table => LocalActivity.t;
}

class LocalActivityRepository {
  const LocalActivityRepository._();

  /// Returns a list of [LocalActivity]s matching the given query parameters.
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
  Future<List<LocalActivity>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalActivityTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalActivityTable>? orderBy,
    _isd.OrderByListBuilder<LocalActivityTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LocalActivity>(
      where: where?.call(LocalActivity.t),
      orderBy: orderBy?.call(LocalActivity.t),
      orderByList: orderByList?.call(LocalActivity.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [LocalActivity]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `LocalActivity.t`.
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
  _ida.Stream<List<LocalActivity>> watch(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalActivityTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalActivityTable>? orderBy,
    _isd.OrderByListBuilder<LocalActivityTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_isd.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<LocalActivity>(
      where: where?.call(LocalActivity.t),
      orderBy: orderBy?.call(LocalActivity.t),
      orderByList: orderByList?.call(LocalActivity.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [LocalActivity] matching the given query parameters.
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
  Future<LocalActivity?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalActivityTable>? where,
    int? offset,
    _isd.OrderByBuilder<LocalActivityTable>? orderBy,
    _isd.OrderByListBuilder<LocalActivityTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LocalActivity>(
      where: where?.call(LocalActivity.t),
      orderBy: orderBy?.call(LocalActivity.t),
      orderByList: orderByList?.call(LocalActivity.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LocalActivity] by its [id] or null if no such row exists.
  Future<LocalActivity?> findById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LocalActivity>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LocalActivity]s in the list and returns the inserted rows.
  ///
  /// The returned [LocalActivity]s will have their `id` fields set.
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
  Future<List<LocalActivity>> insert(
    _isd.DatabaseSession session,
    List<LocalActivity> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<LocalActivity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [LocalActivity] and returns the inserted row.
  ///
  /// The returned [LocalActivity] will have its `id` field set.
  Future<LocalActivity> insertRow(
    _isd.DatabaseSession session,
    LocalActivity row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<LocalActivity>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [LocalActivity]s in the list and returns the resulting rows.
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
  /// The returned [LocalActivity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalActivity>> upsert(
    _isd.DatabaseSession session,
    List<LocalActivity> rows, {
    required _isd.ColumnSelections<LocalActivityTable> conflictColumns,
    _isd.ColumnSelections<LocalActivityTable>? updateColumns,
    _isd.WhereExpressionBuilder<LocalActivityTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<LocalActivity>(
      rows,
      conflictColumns: conflictColumns(LocalActivity.t),
      updateColumns: updateColumns?.call(LocalActivity.t),
      updateWhere: updateWhere?.call(LocalActivity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [LocalActivity] and returns the resulting row.
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
  /// The returned [LocalActivity] will have its `id` field set.
  Future<LocalActivity?> upsertRow(
    _isd.DatabaseSession session,
    LocalActivity row, {
    required _isd.ColumnSelections<LocalActivityTable> conflictColumns,
    _isd.ColumnSelections<LocalActivityTable>? updateColumns,
    _isd.WhereExpressionBuilder<LocalActivityTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<LocalActivity>(
      row,
      conflictColumns: conflictColumns(LocalActivity.t),
      updateColumns: updateColumns?.call(LocalActivity.t),
      updateWhere: updateWhere?.call(LocalActivity.t),
      transaction: transaction,
    );
  }

  /// Updates all [LocalActivity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalActivity>> update(
    _isd.DatabaseSession session,
    List<LocalActivity> rows, {
    _isd.ColumnSelections<LocalActivityTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<LocalActivity>(
      rows,
      columns: columns?.call(LocalActivity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [LocalActivity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LocalActivity> updateRow(
    _isd.DatabaseSession session,
    LocalActivity row, {
    _isd.ColumnSelections<LocalActivityTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<LocalActivity>(
      row,
      columns: columns?.call(LocalActivity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LocalActivity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LocalActivity?> updateById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    required _isd.ColumnValueListBuilder<LocalActivityUpdateTable> columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<LocalActivity>(
      id,
      columnValues: columnValues(LocalActivity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LocalActivity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalActivity>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<LocalActivityUpdateTable> columnValues,
    required _isd.WhereExpressionBuilder<LocalActivityTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<LocalActivityTable>? orderBy,
    _isd.OrderByListBuilder<LocalActivityTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<LocalActivity>(
      columnValues: columnValues(LocalActivity.t.updateTable),
      where: where(LocalActivity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocalActivity.t),
      orderByList: orderByList?.call(LocalActivity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [LocalActivity]s in the list and returns the deleted rows.
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
  Future<List<LocalActivity>> delete(
    _isd.DatabaseSession session,
    List<LocalActivity> rows, {
    _isd.OrderByBuilder<LocalActivityTable>? orderBy,
    _isd.OrderByListBuilder<LocalActivityTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<LocalActivity>(
      rows,
      orderBy: orderBy?.call(LocalActivity.t),
      orderByList: orderByList?.call(LocalActivity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [LocalActivity].
  Future<LocalActivity> deleteRow(
    _isd.DatabaseSession session,
    LocalActivity row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LocalActivity>(
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
  Future<List<LocalActivity>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<LocalActivityTable> where,
    _isd.OrderByBuilder<LocalActivityTable>? orderBy,
    _isd.OrderByListBuilder<LocalActivityTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<LocalActivity>(
      where: where(LocalActivity.t),
      orderBy: orderBy?.call(LocalActivity.t),
      orderByList: orderByList?.call(LocalActivity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<LocalActivityTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<LocalActivity>(
      where: where?.call(LocalActivity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LocalActivity] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<LocalActivityTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LocalActivity>(
      where: where(LocalActivity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
