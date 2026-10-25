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

abstract class AiUsage implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AiUsage._({
    this.id,
    required this.authUserId,
    required this.kind,
    required this.status,
    required this.createdAt,
  });

  factory AiUsage({
    int? id,
    required _is.UuidValue authUserId,
    required String kind,
    required String status,
    required DateTime createdAt,
  }) = _AiUsageImpl;

  factory AiUsage.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiUsage(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['authUserId']),
      kind: jsonSerialization['kind'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = AiUsageTable();

  static const db = AiUsageRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String kind;

  String status;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AiUsage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AiUsage copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? kind,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiUsage',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'kind': kind,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static AiUsageInclude include() {
    return AiUsageInclude._();
  }

  static AiUsageIncludeList includeList({
    _is.WhereExpressionBuilder<AiUsageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AiUsageTable>? orderBy,
    _is.OrderByListBuilder<AiUsageTable>? orderByList,
    AiUsageInclude? include,
  }) {
    return AiUsageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AiUsage.t),
      orderByList: orderByList?.call(AiUsage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiUsageImpl extends AiUsage {
  _AiUsageImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String kind,
    required String status,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         kind: kind,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AiUsage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AiUsage copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? kind,
    String? status,
    DateTime? createdAt,
  }) {
    return AiUsage(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      kind: kind ?? this.kind,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AiUsageUpdateTable extends _is.UpdateTable<AiUsageTable> {
  AiUsageUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(_is.UuidValue value) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) => _is.ColumnValue(
    table.createdAt,
    value,
  );
}

class AiUsageTable extends _is.Table<int?> {
  AiUsageTable({super.tableRelation}) : super(tableName: 'ai_usage') {
    updateTable = AiUsageUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    kind = _is.ColumnString(
      'kind',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final AiUsageUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString kind;

  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    kind,
    status,
    createdAt,
  ];
}

class AiUsageInclude extends _is.IncludeObject {
  AiUsageInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => AiUsage.t;
}

class AiUsageIncludeList extends _is.IncludeList {
  AiUsageIncludeList._({
    _is.WhereExpressionBuilder<AiUsageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AiUsage.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AiUsage.t;
}

class AiUsageRepository {
  const AiUsageRepository._();

  /// Returns a list of [AiUsage]s matching the given query parameters.
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
  Future<List<AiUsage>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AiUsageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AiUsageTable>? orderBy,
    _is.OrderByListBuilder<AiUsageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AiUsage>(
      where: where?.call(AiUsage.t),
      orderBy: orderBy?.call(AiUsage.t),
      orderByList: orderByList?.call(AiUsage.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [AiUsage]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `AiUsage.t`.
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
  _ida.Stream<List<AiUsage>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AiUsageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AiUsageTable>? orderBy,
    _is.OrderByListBuilder<AiUsageTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<AiUsage>(
      where: where?.call(AiUsage.t),
      orderBy: orderBy?.call(AiUsage.t),
      orderByList: orderByList?.call(AiUsage.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [AiUsage] matching the given query parameters.
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
  Future<AiUsage?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AiUsageTable>? where,
    int? offset,
    _is.OrderByBuilder<AiUsageTable>? orderBy,
    _is.OrderByListBuilder<AiUsageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AiUsage>(
      where: where?.call(AiUsage.t),
      orderBy: orderBy?.call(AiUsage.t),
      orderByList: orderByList?.call(AiUsage.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AiUsage] by its [id] or null if no such row exists.
  Future<AiUsage?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AiUsage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AiUsage]s in the list and returns the inserted rows.
  ///
  /// The returned [AiUsage]s will have their `id` fields set.
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
  Future<List<AiUsage>> insert(
    _is.DatabaseSession session,
    List<AiUsage> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AiUsage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AiUsage] and returns the inserted row.
  ///
  /// The returned [AiUsage] will have its `id` field set.
  Future<AiUsage> insertRow(
    _is.DatabaseSession session,
    AiUsage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AiUsage>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AiUsage]s in the list and returns the resulting rows.
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
  /// The returned [AiUsage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AiUsage>> upsert(
    _is.DatabaseSession session,
    List<AiUsage> rows, {
    required _is.ColumnSelections<AiUsageTable> conflictColumns,
    _is.ColumnSelections<AiUsageTable>? updateColumns,
    _is.WhereExpressionBuilder<AiUsageTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AiUsage>(
      rows,
      conflictColumns: conflictColumns(AiUsage.t),
      updateColumns: updateColumns?.call(AiUsage.t),
      updateWhere: updateWhere?.call(AiUsage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AiUsage] and returns the resulting row.
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
  /// The returned [AiUsage] will have its `id` field set.
  Future<AiUsage?> upsertRow(
    _is.DatabaseSession session,
    AiUsage row, {
    required _is.ColumnSelections<AiUsageTable> conflictColumns,
    _is.ColumnSelections<AiUsageTable>? updateColumns,
    _is.WhereExpressionBuilder<AiUsageTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AiUsage>(
      row,
      conflictColumns: conflictColumns(AiUsage.t),
      updateColumns: updateColumns?.call(AiUsage.t),
      updateWhere: updateWhere?.call(AiUsage.t),
      transaction: transaction,
    );
  }

  /// Updates all [AiUsage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AiUsage>> update(
    _is.DatabaseSession session,
    List<AiUsage> rows, {
    _is.ColumnSelections<AiUsageTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AiUsage>(
      rows,
      columns: columns?.call(AiUsage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AiUsage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AiUsage> updateRow(
    _is.DatabaseSession session,
    AiUsage row, {
    _is.ColumnSelections<AiUsageTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AiUsage>(
      row,
      columns: columns?.call(AiUsage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AiUsage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AiUsage?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AiUsageUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AiUsage>(
      id,
      columnValues: columnValues(AiUsage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AiUsage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AiUsage>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AiUsageUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AiUsageTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AiUsageTable>? orderBy,
    _is.OrderByListBuilder<AiUsageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AiUsage>(
      columnValues: columnValues(AiUsage.t.updateTable),
      where: where(AiUsage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AiUsage.t),
      orderByList: orderByList?.call(AiUsage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AiUsage]s in the list and returns the deleted rows.
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
  Future<List<AiUsage>> delete(
    _is.DatabaseSession session,
    List<AiUsage> rows, {
    _is.OrderByBuilder<AiUsageTable>? orderBy,
    _is.OrderByListBuilder<AiUsageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AiUsage>(
      rows,
      orderBy: orderBy?.call(AiUsage.t),
      orderByList: orderByList?.call(AiUsage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AiUsage].
  Future<AiUsage> deleteRow(
    _is.DatabaseSession session,
    AiUsage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AiUsage>(
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
  Future<List<AiUsage>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AiUsageTable> where,
    _is.OrderByBuilder<AiUsageTable>? orderBy,
    _is.OrderByListBuilder<AiUsageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AiUsage>(
      where: where(AiUsage.t),
      orderBy: orderBy?.call(AiUsage.t),
      orderByList: orderByList?.call(AiUsage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AiUsageTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AiUsage>(
      where: where?.call(AiUsage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AiUsage] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AiUsageTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AiUsage>(
      where: where(AiUsage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
